import 'package:get/get.dart';
import '../navigation/route_generator.dart';
import '../navigation/routes.dart';
import '../services/init_services.dart';
import '../services/local_storage.dart';
import 'mixin.dart';

class ApplicationController extends GetxController with ControllersMixin {
  final router = locator<RouteGenerator>().navigator;
  final ls = locator<LocalStorage>();
  Future<void> postInitializationCalls() async {
    bool? val = await ls.getValue('isFirstInstall') as bool?;
    if (val ?? true) {
    } else {
      if (authController.user.value == null) {
        router.currentState?.pushNamed(Routes.login);
      } else {
        router.currentState?.pushNamed(Routes.user);
      }
    }
  }
}
