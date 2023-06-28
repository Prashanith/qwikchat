import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../config/database.dart';
import '../models/entities/search_user.dart';
import 'mixin.dart';

class RequestsController extends GetxController with ControllersMixin {
  var docs = <SearchUser>[].obs;

  Future<void> getRequests() async {
    var users = await Database.requestsCollection
        .doc(authController.user.value?.uid)
        .get();
    var user = users.data() as Map<String, dynamic>;
    List<dynamic> requests = user['requests'];
    for (int i = 0; i < requests.length; i++) {
      var u = await Database.publicUsersCollection
          .doc(requests[i].toString())
          .get();
      var add = u.data() as Map<String, dynamic>;
      docs.addIf(
          docs.isEmpty ||
              docs.any((element) => element.id != requests[i].toString()),
          SearchUser(add, u.id));
    }
    print(docs.length.toString());
  }

  Future<void> acceptRequest(String userId) async {
    var chatId = const Uuid().v1();
    DateTime date = DateTime.now().toUtc();

    await Future.wait([
      Database.requestsCollection
          .doc(authController.user.value?.uid.toString())
          .update({
        'requests': FieldValue.arrayRemove([userId])
      }),
      Database.friendsCollection
          .doc(authController.user.value?.uid.toString())
          .collection('friends')
          .doc(userId)
          .set({
        'id': userId,
        'chatId': chatId,
        'friendSince': date,
      }),
      Database.friendsCollection
          .doc(userId)
          .collection('friends')
          .doc(authController.user.value?.uid.toString())
          .set({
        'id': authController.user.value?.uid.toString(),
        'chatId': chatId,
        'friendSince': date,
      }),
      Database.chatsCollection
          .doc(chatId).set({'id':chatId})
    ]);
    await Database.chatsCollection
        .doc(chatId)
        .collection('messages')
        .doc('messages')
        .set({
      'id': const Uuid().v1(),
      'sentAt': date,
      'readAt': null,
      'message': 'Hi ${authController.user.value!.displayName}',
      'sender': authController.user.value!.uid
    });
    docs.removeWhere((element) => element.docId == userId);
  }

  Future<void> deleteRequest(String userId) async {
    await Database.requestsCollection
        .doc(authController.user.value?.uid.toString())
        .update({
      'requests': FieldValue.arrayRemove([userId])
    });
    docs.removeWhere((element) => element.docId == userId);
  }
}
