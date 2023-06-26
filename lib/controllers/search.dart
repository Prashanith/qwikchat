import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/entities/search_user.dart';
import 'mixin.dart';

class UserSearchController extends GetxController with ControllersMixin {
  @override
  void onInit() {
    super.onInit();
  }

  var docs = <SearchUser>[].obs;
  RxBool isLoading = true.obs;

  Future<void> getUsers() async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('searchUsers');
    var users = await usersCollection.get();
    List<SearchUser> dcs = [];
    for (var element in users.docs) {
      if (![authController.user.value?.uid, 'searchUsers']
          .contains(element.id)) {
        dcs.add(SearchUser(element));
      }
    }
    docs.value = dcs;
  }
}
