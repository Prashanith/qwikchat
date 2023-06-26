import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';

import '../../controllers/mixin.dart';
import '../../screens/user/chat/chats.dart';
import '../../screens/user/friends.dart';
import '../../screens/user/profile.dart';
import '../../screens/user/search.dart';

class BottomNavScaffold extends StatefulWidget {
  const BottomNavScaffold({super.key});

  @override
  State<BottomNavScaffold> createState() => _BottomNavScaffoldState();
}

class _BottomNavScaffoldState extends State<BottomNavScaffold>
    with ControllersMixin {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.secondaryHeaderColor,

        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Image.asset(
            'assets/comment.png',
            fit: BoxFit.scaleDown,
            scale: 0.5,
          ),
        ),
        leadingWidth: 45,
        title: Text('Qwik Chat', style: context.theme.textTheme.bodyMedium),
        // actions: [
        //   IconButton(
        //       onPressed: () => authController.signOut(),
        //       icon: LineIcon.alternateSignOut())
        // ],
      ),
      body: [
        Chats(),
        const Friends(),
        SearchUsers(),
        const UserProfile()
      ][currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          selectedFontSize: 12.0,
          unselectedFontSize: 10,
          onTap: (i) => setState(() {
                currentIndex = i;
              }),
          items: [
            BottomNavigationBarItem(icon: LineIcon.comments(), label: 'Chat'),
            BottomNavigationBarItem(
                icon: LineIcon.userFriends(), label: 'Friends'),
            BottomNavigationBarItem(icon: LineIcon.userPlus(), label: 'Add'),
            BottomNavigationBarItem(
                icon: LineIcon.userCircle(), label: 'Profile'),
          ]),
    );
  }
}
