import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../config/database.dart';
import '../models/entities/search_user.dart';
import 'mixin.dart';

class UserSearchController extends GetxController with ControllersMixin {
  var docs = <SearchUser>[].obs;
  RxBool isLoading = true.obs;

  Future<void> getUsers() async {
    CollectionReference publicUsersCollection = Database.publicUsersCollection;
    var users = await publicUsersCollection.get();
    List<SearchUser> dcs = [];
    for (var element in users.docs) {
      if (![authController.user.value?.uid, 'publicUsers']
          .contains(element.id)) {
        var data = element.data() as Map<String, dynamic>;
        dcs.add(SearchUser(data, element.id));
      }
    }
    docs.value = dcs;
  }

  Future<void> createRequest(String userId) async {
    await Database.requestsCollection.doc(userId).update({
      'requests': FieldValue.arrayUnion([authController.user.value?.uid])
    });
  }
}
