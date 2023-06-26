import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'authentication.dart';
import 'chats.dart';
import 'search.dart';

mixin ControllersMixin {
  AuthenticationController get authController =>
      Get.put(AuthenticationController());
  UserSearchController get searchController => Get.put(UserSearchController());
  ChatController get chatController => Get.put(ChatController());

  void dispose() {
    authController.dispose();
  }
}
