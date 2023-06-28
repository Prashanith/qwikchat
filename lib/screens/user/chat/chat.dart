import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import '../../../config/database.dart';
import '../../../controllers/mixin.dart';
import '../../../models/entities/message.dart';
import '../../../navigation/route_generator.dart';
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
    final textTheme = context.textTheme;
    final rd = locator<ResponsiveDesign>();
    final router = locator<RouteGenerator>();


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: ()=> router.navigator.currentState?.pop(),
            icon: const Icon(Icons.chevron_left),
          ),
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
          actions: const [
            // IconButton(onPressed: () => {}, icon: LineIcon.phone()),
            // IconButton(onPressed: () => {}, icon: LineIcon.video()),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: Container(
          padding: rd.getPadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: Database.chatsCollection
                          .doc(chatHead.documentId)
                          .collection('messages')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null &&
                            snapshot.connectionState ==
                                ConnectionState.active) {
                          if (snapshot.data!.docChanges.isNotEmpty) {
                            chatHead.addMessage(Message(
                                snapshot.data?.docChanges.first.doc.data(),
                                ''));
                          }
                        }
                        return ListView.separated(
                          reverse: true,
                          shrinkWrap: true,
                          itemCount: chatHead.getMessages.length,
                          itemBuilder: (context, index) {
                            final message = chatHead.getMessages[index];
                            return Row(
                              mainAxisAlignment: message.senderId ==
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
                                      color: message.senderId ==
                                              authController.user.value?.uid
                                          ? context.theme.colorScheme
                                              .primaryContainer
                                          : context.theme.colorScheme.secondary,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    message.message.toString(),
                                    style: context.theme.textTheme.bodyMedium
                                        ?.merge(TextStyle(
                                      color: context
                                          .theme.colorScheme.secondaryContainer,
                                    )),
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
                      })),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      width: rd.getWidth(context, excludePadding: false) - 35,
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Type a message',
                            hintStyle: context.textTheme.bodyMedium,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 14),
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                )),
                            disabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                )),
                            enabled: true,
                            enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                )),
                            errorBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                )),
                            focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                )),
                            focusedErrorBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                )),
                            suffixIconColor: Colors.grey.shade400,
                            focusColor: Colors.transparent,
                            labelStyle: textTheme.labelSmall),
                        controller: textEditingController,
                      )),
                  GestureDetector(
                      onTap: () async {
                        chatController.sendMessage(textEditingController.text);
                        textEditingController.clear();
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Icon(
                          Icons.send,
                          size: 20,
                        ),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
