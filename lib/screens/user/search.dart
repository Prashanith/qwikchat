import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../controllers/mixin.dart';
import '../../controllers/search.dart';
import '../../services/init_services.dart';
import '../../services/ui/responsive_design.dart';

class SearchUsers extends StatelessWidget with ControllersMixin {
  SearchUsers({super.key});

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void onLoading(UserSearchController sc) async {
    await sc.getUsers();
    _refreshController.loadComplete();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final sc = searchController;
    final rd = locator<ResponsiveDesign>();

    return SmartRefresher(
      controller: _refreshController,
      onRefresh: () => onLoading(sc),
      child: Column(
        children: [
          Obx(
            () => ListView.separated(
              shrinkWrap: true,
              itemCount: sc.docs.length,
              itemBuilder: (context, i) {
                final user = sc.docs[i];
                return ListTile(
                  style: ListTileStyle.list,
                  leading: CircleAvatar(
                    radius: rd.getWidth(context) * 0.15,
                    backgroundImage: NetworkImage(user.photoUrl),
                  ),
                  title: Text(user.displayName),
                  isThreeLine: false,
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                height: 3,
              ),
            ),
          )
        ],
      ),
    );
  }
}
