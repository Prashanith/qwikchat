import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';

import '../../controllers/mixin.dart';
import '../../screens/user/alerts.dart';
import '../../screens/user/friends.dart';
import '../../screens/user/chat/chats.dart';
import '../../screens/user/profile.dart';

class BottomNavScaffold extends StatefulWidget {
  const BottomNavScaffold({super.key});

  @override
  State<BottomNavScaffold> createState() => _BottomNavScaffoldState();
}

class _BottomNavScaffoldState extends State<BottomNavScaffold>
    with ControllersMixin {
  int currentIndex = 0;

  String getTitle(int i) {
    switch (i) {
      case 0:
        return 'Chats';
      case 1:
        return 'Friends';
      case 2:
        return 'Notifications';
      case 3:
        return 'Profile';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Image.asset(
            'assets/comment.png',
            fit: BoxFit.scaleDown,
            scale: 0.5,
          ),
        ),
        leadingWidth: 45,
        title: Text(getTitle(currentIndex),
            style: context.theme.textTheme.titleLarge!
                .merge(const TextStyle(fontWeight: FontWeight.w800, letterSpacing:1.2))),
        actions: [
          Visibility(
              visible: currentIndex == 3,
              child: IconButton(
                  onPressed: () => authController.signOut(),
                  icon: LineIcon.alternateSignOut()))
        ],
      ),
      body: [
        Chats(),
        Friends(),
        const Alerts(),
        const UserProfile()
      ][currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        height: 90,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (i) => setState(() {
                    currentIndex = i;
                  }),
              items: [
                BottomNavigationBarItem(
                    icon: LineIcon.comments(), label: 'Chat'),
                BottomNavigationBarItem(
                    icon: LineIcon.userFriends(), label: 'Friends'),
                BottomNavigationBarItem(
                    icon: LineIcon.heart(), label: 'Notifications'),
                BottomNavigationBarItem(
                    icon: LineIcon.user(), label: 'Profile'),
              ]),
        ),
      ),
    );
  }
}
