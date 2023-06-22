import 'package:get/get.dart';

import 'mixin.dart';

class ApplicationController extends GetxController with ControllersMixin {
  @override
  void onInit() {
    postInitializationCalls();
    super.onInit();
  }

  Future<void> postInitializationCalls() async {
    //
  }
}
