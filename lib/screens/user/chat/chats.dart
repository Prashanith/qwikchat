import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../config/config.dart';
import '../../../controllers/chats.dart';
import '../../../controllers/mixin.dart';
import '../../../navigation/route_generator.dart';
import '../../../navigation/routes.dart';
import '../../../services/init_services.dart';
import '../../../services/ui/responsive_design.dart';
import '../../../widgets/tile.dart';

class Chats extends StatelessWidget with ControllersMixin {
  Chats({super.key});

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void onLoading(ChatController sc) async {
    await Future.wait([sc.getChats(), sc.getPersonalChat()]);
    _refreshController.loadComplete();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final router = locator<RouteGenerator>();
    final rd = locator<ResponsiveDesign>();

    final cc = chatController;
    return SmartRefresher(
      onRefresh: () => onLoading(cc),
      controller: _refreshController,
      child: Container(
        color: context.theme.colorScheme.primary,
        padding: rd.getPadding(context),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: ' Search',
                hintStyle: context.textTheme.bodyMedium,
                prefix: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: LineIcon.search(
                    size: 18,
                  ),
                ),
                prefixIconColor: context.theme.colorScheme.secondaryContainer,
                prefixStyle: context.textTheme.titleLarge,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                labelStyle: context.textTheme.labelSmall,
                border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => Tile(
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage(cc.personalChatHead.value.photoUrl),
                ),
                center: Column(
                  children: [
                    Text(
                      cc.personalChatHead.value.displayName,
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
                ),
                trailing: const SizedBox(),
                onTap: () async {
                  await cc.setCurrentChatHead(
                      cc.personalChatHead.value.documentId, true);
                  router.navigator.currentState?.pushNamed(Routes.chatHead);
                })),
            const SizedBox(
              height: 8,
            ),
            Obx(
              () => ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    var chatHead = chatController.chats[i];
                    return Tile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(chatHead.photoUrl),
                        ),
                        trailing: const SizedBox(),
                        center: Column(
                          children: [
                            Text(
                              chatHead.displayName,
                              style: context.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        onTap: () async {
                          await cc.setCurrentChatHead(
                              chatHead.documentId, false);
                          router.navigator.currentState
                              ?.pushNamed(Routes.chatHead);
                        });
                  },
                  separatorBuilder: (context, i) => Container(
                        height: 11,
                      ),
                  itemCount: chatController.chats.length),
            )
          ],
        ),
      ),
    );
  }
}
