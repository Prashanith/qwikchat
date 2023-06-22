import 'package:flutter/material.dart';
import '../../services/init_services.dart';
import '../../services/ui/responsive_design.dart';

class PlainScaffold extends StatelessWidget {
  const PlainScaffold(
      {required this.widget, this.removePadding = false, super.key});

  final Widget widget;
  final bool removePadding;

  @override
  Widget build(BuildContext context) {
    final pd = locator<ResponsiveDesign>().getPadding(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: Padding(
            padding: removePadding ? EdgeInsets.zero : pd, child: widget),
      ),
    );
  }
}
