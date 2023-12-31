import 'package:flutter/material.dart';

import '../screens/authentication/authenticate.dart';
import '../screens/splash/init.dart';
import '../screens/user/chat/chat.dart';
import '../screens/user/user.dart';
import 'routes.dart';

class RouteGenerator {
  final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.init:
        return Page(const InitScreen());
      case Routes.login:
        return Page(const AuthenticationScreen());
      case Routes.user:
        return Page(const User());
      case Routes.chatHead:
        return Page(const ChatWindow());
      default:
        return Page(const AuthenticationScreen());
    }
  }
}

// ignore: non_constant_identifier_names
Route<dynamic> Page(Widget widget) {
  return MaterialPageRoute(builder: (_) => widget);
}
