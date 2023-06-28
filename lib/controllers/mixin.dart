import 'package:get/get.dart';

import 'application.dart';
import 'authentication.dart';
import 'chats.dart';
import 'profile.dart';
import 'request.dart';
import 'search.dart';

mixin ControllersMixin {
  AuthenticationController get authController =>
      Get.put(AuthenticationController());
  UserSearchController get searchController => Get.put(UserSearchController());
  ChatController get chatController => Get.put(ChatController());
  RequestsController get requestsController => Get.put(RequestsController());
  ProfileController get profileController => Get.put(ProfileController());
  ApplicationController get applicationController =>
      Get.put(ApplicationController());

  void dispose() {
    // authController.dispose();
    searchController.dispose();
    chatController.dispose();
    requestsController.dispose();
    profileController.dispose();
    applicationController.dispose();
  }
}
