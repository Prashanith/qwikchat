import 'package:get/get.dart';
import '../navigation/route_generator.dart';
import '../navigation/routes.dart';
import '../services/init_services.dart';
import 'mixin.dart';

class ApplicationController extends GetxController with ControllersMixin {
  final router = locator<RouteGenerator>().navigator;
  Future<void> postInitializationCalls() async {
    // Use Shared Preferences to see if user is using the app for the first time
    if (authController.user.value == null) {
      //make calls to get the state
      router.currentState?.pushNamed(Routes.user);
    } else {
      router.currentState?.pushNamed(Routes.login);
    }
    //
  }
}
