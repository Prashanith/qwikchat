// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
//
// import '../../controllers/mixin.dart';
// import '../../controllers/search.dart';
// import '../../services/init_services.dart';
// import '../../services/ui/responsive_design.dart';
//
// class SearchUsers extends StatelessWidget with ControllersMixin {
//   SearchUsers({super.key});
//
//   final RefreshController _refreshController =
//       RefreshController(initialRefresh: false);
//
//   void onLoading(UserSearchController sc) async {
//     await sc.getUsers();
//     _refreshController.loadComplete();
//     _refreshController.refreshCompleted();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final sc = searchController;
//     final rd = locator<ResponsiveDesign>();
//
//     return SmartRefresher(
//       controller: _refreshController,
//       onRefresh: () => onLoading(sc),
//       child: Column(
//         children: [
//           Obx(
//             () => ListView.separated(
//               shrinkWrap: true,
//               itemCount: sc.docs.length,
//               itemBuilder: (context, i) {
//                 final user = sc.docs[i];
//                 return ListTile(
//                   leading: CircleAvatar(
//                     radius: rd.getWidth(context) * 0.075,
//                     backgroundImage: NetworkImage(user.photoUrl, scale: 1),
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
//                   title: Text(user.displayName),
//                   isThreeLine: false,
//                   dense: true,
//                   trailing: ElevatedButton(
//                       onPressed: () =>
//                           searchController.createRequest(user.docId),
//                       child: const Text('Add')),
//                 );
//               },
//               separatorBuilder: (BuildContext context, int index) =>
//                   const Divider(
//                 height: 3,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
