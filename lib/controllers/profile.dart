import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../config/database.dart';
import '../models/entities/friend.dart';
import 'mixin.dart';

class ProfileController extends GetxController with ControllersMixin {
  var friends = <Friend>[].obs;

  Future<void> getFriends() async {
    friends.value = [];
    CollectionReference chatRef = Database.friendsCollection
        .doc(authController.user.value?.uid.toString())
        .collection('friends');
    List<Friend> fs = [];
    var friendsDocs = await chatRef.get();
    for (var friend in friendsDocs.docs) {
      fs.add(Friend(friend.data(), friend.id));
    }
    friends.addAll(fs);
  }

  Future<void> updateProfile() async {
    //
  }
}
