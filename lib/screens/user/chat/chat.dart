import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';

import '../../../controllers/mixin.dart';
import '../../../models/entities/message.dart';
import '../../../services/init_services.dart';
import '../../../services/ui/responsive_design.dart';

class ChatWindow extends StatefulWidget {
  const ChatWindow({super.key});

  @override
  State<ChatWindow> createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> with ControllersMixin {
  final TextEditingController textEditingController =
      TextEditingController(text: '');

  @override
  void initState() {
    textEditingController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final chatHead = chatController.currentChatHead.value;
    final rd = locator<ResponsiveDesign>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 30,
          title: Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                  chatHead.photoUrl,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                chatHead.displayName,
                style: context.textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        body: Container(
          padding: rd.getPadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Obx(() {
                  return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(authController.user.value?.uid.toString())
                          .collection('chats')
                          .doc(chatHead.documentId)
                          .collection('messages')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null && snapshot.connectionState == ConnectionState.active) {
                          Object s = snapshot.data!;
                         chatHead.addMessage(Message(snapshot.data?.docChanges.first.doc.data(), ''));
                        }
                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: chatHead.getMessages.length,
                          itemBuilder: (context, index) {
                            final message = chatHead.getMessages[index];
                            return Row(
                              mainAxisAlignment: chatHead.documentId ==
                                      authController.user.value?.uid
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  constraints: BoxConstraints(
                                      maxWidth: rd.getWidth(context) * 0.7),
                                  decoration: BoxDecoration(
                                      color: context.theme.primaryColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    message.message.toString(),
                                    style: context.theme.textTheme.bodyMedium
                                        ?.merge(const TextStyle(
                                            color: Colors.white)),
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 5,
                            );
                          },
                        );
                      });
                }),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      width: rd.getWidth(context, excludePadding: false) - 50,
                      child: TextFormField(
                        controller: textEditingController,
                      )),
                  IconButton(
                      onPressed: () => chatController
                          .sendMessage(textEditingController.text),
                      icon: LineIcon.medal())
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
