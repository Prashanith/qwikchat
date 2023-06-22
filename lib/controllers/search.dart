import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserSearchController extends GetxController {
  final docs = [].obs;

  Future<void> getUsers() async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('searchUsers');
    var users = await usersCollection.get();
    docs.value = users.docs;
    users.docs.length;
  }
}
