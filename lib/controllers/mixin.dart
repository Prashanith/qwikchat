import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'authentication.dart';
import 'search.dart';

mixin ControllersMixin {
  AuthenticationController get authController =>
      Get.put(AuthenticationController());

  UserSearchController get searchController => Get.put(UserSearchController());

  void dispose() {
    authController.dispose();
  }
}
