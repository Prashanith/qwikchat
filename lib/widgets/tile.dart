import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tile extends StatelessWidget {
  const Tile(
      {super.key,
      required this.leading,
      required this.trailing,
      required this.center,
      this.onTap});

  final Widget leading;
  final Widget trailing;
  final Widget center;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
            color: context.theme.colorScheme.secondary,
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            leading,
            const SizedBox(
              width: 20,
            ),
            center,
            const Spacer(),
            trailing,
          ],
        ),
      ),
    );
  }
}
