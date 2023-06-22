import 'package:flutter/material.dart';

import '../../controllers/mixin.dart';
import '../../widgets/page_wrappers/bottom_nav_scaffold.dart';
import '../../widgets/page_wrappers/plain_scaffold.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> with ControllersMixin {
  @override
  Widget build(BuildContext context) {
    return const BottomNavScaffold();
  }
}
