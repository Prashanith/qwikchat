import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'profile.dart';
import 'request.dart';
import 'search.dart';
import 'package:uuid/uuid.dart';

import '../config/database.dart';
import '../navigation/route_generator.dart';
import '../navigation/routes.dart';
import '../services/init_services.dart';
import 'application.dart';
import 'chats.dart';

class AuthenticationController extends GetxController {
  UserSearchController get searchController => Get.put(UserSearchController());
  ChatController get chatController => Get.put(ChatController());
  RequestsController get requestsController => Get.put(RequestsController());
  ProfileController get profileController => Get.put(ProfileController());
  ApplicationController get applicationController =>
      Get.put(ApplicationController());

  final router = locator<RouteGenerator>();
  final auth = FirebaseAuth.instance;
  final googleAuth = locator<GoogleSignIn>();
  Rx<User?> user = FirebaseAuth.instance.currentUser.obs;

  final email = TextEditingController(text: '').obs;
  final password = TextEditingController(text: '').obs;

  ValueNotifier<String> emailError = ValueNotifier<String>('');
  ValueNotifier<String> passwordError = ValueNotifier<String>('');

  @override
  void onInit() {
    FirebaseAuth.instance.authStateChanges().listen((User? u) {
      if (u == null) {
        user.value = null;
        router.navigator.currentState
            ?.pushNamedAndRemoveUntil(Routes.login, (route) => false);
      } else {
        user.value = u;
        router.navigator.currentState?.pushReplacementNamed(
          Routes.user,
        );
      }
    });
    super.onInit();
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleAuth.signIn();

    final GoogleSignInAuthentication? googleSingInAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleSingInAuth?.accessToken,
      idToken: googleSingInAuth?.idToken,
    );

    var res = await auth.signInWithCredential(credential);
    final bool isNewUser = res.additionalUserInfo?.isNewUser ?? true;
    user.value = res.user;
    if (res.user != null) {
      await postCreationCalls(res.user, isNewUser);
      router.navigator.currentState!.pushReplacementNamed(Routes.user);
    }
  }

  Future<void> postCreationCalls(User? user, bool isNewUser) async {
    if (isNewUser) {
      // Users Collection
      // Stores User Data
      // Public Users Collection
      // Keep Private Data Safe and access only public fields
      await Future.wait([
        Database.usersCollection.doc(user?.uid).set({'id': user?.uid}),
        Database.publicUsersCollection.doc(user?.uid).set({
          'id': user?.uid.toString(),
          'displayName': user?.displayName,
          'photoUrl': user?.photoURL
        })
      ]);

      await Future.wait([
        Database.chatsCollection.doc(user?.uid).set({'id': user?.uid}),
        Database.friendsCollection.doc(user?.uid).set({'id': user?.uid}),
        Database.requestsCollection
            .doc(user?.uid)
            .set({'id': user?.uid, 'requests': []}),
      ]);
      await Database.chatsCollection
          .doc(user?.uid)
          .collection('messages')
          .doc('messages')
          .set({
        'id': const Uuid().v1(),
        'sentAt': DateTime.now().toUtc(),
        'readAt': null,
        'message': 'Hi ${user!.displayName}',
        'sender': user.uid
      });
    } else {
      await profileController.getFriends();
      await chatController.getPersonalChat();
      await chatController.getChats();
      await searchController.getUsers();
    }
  }

  Future<void> signOut() async {
    await googleAuth.disconnect();
    await auth.signOut();
    searchController.dispose();
    chatController.dispose();
    requestsController.dispose();
    profileController.dispose();
    applicationController.dispose();
  }
}
