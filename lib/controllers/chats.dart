import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../config/database.dart';
import '../models/entities/chat_head.dart';
import '../models/entities/message.dart';
import 'authentication.dart';
import 'mixin.dart';

class ChatController extends GetxController with ControllersMixin {
  final auth = Get.put(AuthenticationController());
  var chats = <ChatHead>[].obs;
  var currentChatHead = ChatHead(null, '').obs;
  Rx<ChatHead> personalChatHead = ChatHead(null, '').obs;

  Future<void> getPersonalChat() async {
    var res = await Database.chatsCollection.doc(auth.user.value?.uid).get();
    personalChatHead.value = ChatHead(res.data(), res.id);
    personalChatHead.value.setProfile(authController.user.value!.photoURL ?? '',
        authController.user.value!.displayName ?? '');
    print(res.data());
  }

  Future<void> getChats() async {
    chats.value = [];
    for (var friend in profileController.friends) {
      var chatHead = await Database.chatsCollection.doc(friend.chatId).get();
      if (chatHead.exists) {
        final chat = ChatHead(chatHead.data(), chatHead.id);
        var user = await Database.publicUsersCollection.doc(friend.id).get();
        var data = user.data() as Map<String, dynamic>;
        chat.setProfile(data['photoUrl'], data['displayName']);
        chats.add(chat);
      }
    }
  }

  setCurrentChatHead(String id, bool isPersonal) async {
    currentChatHead.value = isPersonal
        ? personalChatHead.value
        : chats.value.where((e) => e.documentId == id).first;
    var messages = await Database.messagesCollection(id).get();
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
    CollectionReference chatRef =
        Database.messagesCollection(currentChatHead.value.documentId);
    await chatRef.add(Message.toJson(authController.user.value!.uid, message));
  }
}
