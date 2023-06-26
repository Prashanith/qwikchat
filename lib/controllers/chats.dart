import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/entities/chat_head.dart';
import '../models/entities/message.dart';
import 'authentication.dart';

class ChatController extends GetxController {
  final auth = Get.put(AuthenticationController());
  var chats = <ChatHead>[].obs;
  var currentChatHead = ChatHead(null, '').obs;

  Future<void> getChats() async {
    CollectionReference chatRef = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.user.value?.uid.toString())
        .collection('chats');
    var cs = await chatRef.get();
    List<ChatHead> cts = [];
    for (var element in cs.docs) {
      cts.add(ChatHead(element.data(), element.id));
    }
    chats.value = cts;
  }

  setCurrentChatHead(String id) async {
    CollectionReference chatRef = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.user.value?.uid.toString())
        .collection('chats');

    CollectionReference userRef =
        FirebaseFirestore.instance.collection('searchUsers');

    var chatHead = await chatRef.doc(id).get();
    DocumentSnapshot? profile =
        await userRef.doc(auth.user.value?.uid.toString()).get();
    Map<String, dynamic> data = profile.data() as Map<String, dynamic>;

    currentChatHead.value = ChatHead(chatHead.data(), chatHead.id);
    currentChatHead.value.setProfile(data['photoUrl'], data['displayName']!);
    CollectionReference messagesRef = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.user.value?.uid.toString())
        .collection('chats')
        .doc(auth.user.value?.uid.toString())
        .collection('messages');
    var messages = await messagesRef.get();
    List<Message> ms = [];
    for (var element in messages.docs) {
      if (element.id != 'messages') {
        print(element.data());
        ms.add(Message(element.data(), element.id));
      }
    }
    currentChatHead.value.addMessages(ms);
  }

  Future<void> sendMessage(String message) async {
    CollectionReference chatRef = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.user.value?.uid.toString())
        .collection('chats')
        .doc(auth.user.value?.uid.toString())
        .collection('messages');
    var res = await chatRef
        .add(Message.toJson(currentChatHead.value.documentId, message));
  }
}
