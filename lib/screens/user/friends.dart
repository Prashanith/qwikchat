import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../controllers/mixin.dart';
import '../../controllers/request.dart';
import '../../controllers/search.dart';
import '../../services/init_services.dart';
import '../../services/ui/responsive_design.dart';
import '../../widgets/tile.dart';

class Friends extends StatelessWidget with ControllersMixin {
  Friends({super.key});

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void onLoading(RequestsController rc, UserSearchController usc) async {
    await Future.wait([rc.getRequests(), usc.getUsers()]);
    _refreshController.loadComplete();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final rqc = requestsController;
    final rd = locator<ResponsiveDesign>();
    final sc = searchController;

    return SmartRefresher(
      controller: _refreshController,
      onRefresh: () => onLoading(rqc, searchController),
      child: Obx(() {
        return Padding(
          padding: rd.getPadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Visibility(
                    visible: rqc.docs.isNotEmpty,
                    child: Text(
                      'Message Requests',
                      style: context.theme.textTheme.titleMedium,
                    )),
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: rqc.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = rqc.docs[index];
                  return Tile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.photoUrl),
                    ),
                    center: Text(user.displayName),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () =>
                                requestsController.acceptRequest(user.id),
                            icon: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.green,
                                child: LineIcon.check(
                                  size: 14,
                                ))),
                        IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () =>
                                requestsController.deleteRequest(user.id),
                            icon: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.red,
                                child: LineIcon.times(
                                  size: 14,
                                ))),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 1,
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: rqc.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = rqc.docs[index];
                  return Tile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.photoUrl),
                    ),
                    center: Text(user.displayName),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () =>
                                requestsController.acceptRequest(user.id),
                            icon: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.green,
                                child: LineIcon.check(
                                  size: 14,
                                ))),
                        IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () =>
                                requestsController.deleteRequest(user.id),
                            icon: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.red,
                                child: LineIcon.times(
                                  size: 14,
                                ))),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 1,
                  );
                },
              ),
              Visibility(
                  visible: sc.docs.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Find Friends',
                      style: context.theme.textTheme.titleMedium,
                    ),
                  )),
              SizedBox(
                height: 180,
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: sc.docs.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) {
                    final user = sc.docs[i];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      width: 150,
                      decoration: BoxDecoration(
                          color: context.theme.colorScheme.secondary,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: rd.getWidth(context) * 0.075,
                            backgroundImage:
                                NetworkImage(user.photoUrl, scale: 1),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(user.displayName),
                          const SizedBox(
                            height: 8,
                          ),
                          ElevatedButton(
                              onPressed: () =>
                                  searchController.createRequest(user.docId),
                              child: Text(
                                'Add',
                                style: context.textTheme.bodyMedium,
                              ))
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    width: 12,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
