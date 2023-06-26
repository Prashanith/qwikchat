import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../navigation/route_generator.dart';
import '../navigation/routes.dart';
import '../services/init_services.dart';
import 'chats.dart';
import 'mixin.dart';

class AuthenticationController extends GetxController with ControllersMixin {
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

    print(res.user);
  }

  Future<void> postCreationCalls(User? user, bool isNewUser) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    CollectionReference searchUsers =
        FirebaseFirestore.instance.collection('searchUsers');

    if (isNewUser) {
      await Future.wait([
        users.doc(user?.uid).set({'requests': []}),
        searchUsers.doc(user?.uid).set({
          'id': user?.uid.toString(),
          'displayName': user?.displayName,
          'photoUrl': user?.photoURL
        })
      ]);

      await Future.wait([
        users
            .doc(user?.uid)
            .collection('chats')
            .doc(user?.uid)
            .set({'id': user?.uid}),
        users
            .doc(user?.uid)
            .collection('friends')
            .doc(user?.uid)
            .set({'id': user?.uid}),
      ]);
      await users
          .doc(user?.uid)
          .collection('chats')
          .doc(user?.uid)
          .collection('messages')
          .doc('messages')
          .set({'id': 'admin'});
    } else {
      await chatController.getChats();
    }
  }

  Future<void> signOut() async {
    await googleAuth.disconnect();
    await auth.signOut();
  }
}
