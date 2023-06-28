import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../navigation/route_generator.dart';
import 'local_storage.dart';
import 'ui/responsive_design.dart';

final locator = GetIt.instance;

class ServiceInitializer {
  static Future<void> initializeServices() async {
    locator.registerSingleton<RouteGenerator>(RouteGenerator());
    locator.registerSingleton<GoogleSignIn>(GoogleSignIn());
    locator.registerSingleton<ResponsiveDesign>(ResponsiveDesign());
    locator.registerSingleton<LocalStorage>(LocalStorage());

  }
}
