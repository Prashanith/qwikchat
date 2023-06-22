import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/mixin.dart';

class SearchUsers extends StatelessWidget with ControllersMixin {
  const SearchUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Text(searchController.docs.length.toString())),
        ElevatedButton(onPressed: ()=>searchController.getUsers(), child: Text('Get users'))
      ],
    );
  }
}
