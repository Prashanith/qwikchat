import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';

import '../../controllers/mixin.dart';
import '../../screens/user/chats.dart';
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
        leading: const Image(
          image: AssetImage('assets/comment.png'),
          height: 30,
          width: 30,
        ),
        title: Text('Qwik Chat', style: context.theme.textTheme.bodyMedium),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => authController.signOut(),
              icon: LineIcon.outdent())
        ],
      ),
      body: [
        const Chats(),
        const Friends(),
        const SearchUsers(),
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
