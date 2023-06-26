import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../controllers/chats.dart';
import '../../../controllers/mixin.dart';
import '../../../navigation/route_generator.dart';
import '../../../navigation/routes.dart';
import '../../../services/init_services.dart';

class Chats extends StatelessWidget with ControllersMixin {
  Chats({super.key});

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void onLoading(ChatController sc) async {
    await sc.getChats();
    _refreshController.loadComplete();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final router = locator<RouteGenerator>();
    final cc = chatController;
    return SmartRefresher(
      onRefresh: () => onLoading(cc),
      controller: _refreshController,
      child: Column(
        children: [
          Obx(
            () => ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  var chatHead = chatController.chats[i];
                  return ListTile(
                    title: Text(chatHead.documentId),
                    onTap: () async{
                      await cc.setCurrentChatHead(chatHead.documentId);
                      router.navigator.currentState?.pushNamed(Routes.chatHead);
                    },
                  );
                },
                separatorBuilder: (context, i) => Container(
                      height: 20,
                    ),
                itemCount: chatController.chats.length),
          )
        ],
      ),
    );
  }
}
