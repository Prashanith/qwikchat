import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';

import '../../controllers/mixin.dart';
import '../../services/init_services.dart';
import '../../services/ui/responsive_design.dart';
import '../../widgets/page_wrappers/plain_scaffold.dart';

class AuthenticationScreen extends StatelessWidget with ControllersMixin {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rd = locator<ResponsiveDesign>();
    final theme = context.textTheme;
    final auth = authController;

    return PlainScaffold(
        widget: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: rd.spacerXl(context) * 3,
          ),
          Row(
            children: [
              const Image(
                image: AssetImage('assets/comment.png'),
                height: 100,
                width: 100,
              ),
              const SizedBox(
                width: 10,
              ),
              Text('QWIKCHAT', style: theme.titleMedium)
            ],
          ),
          ElevatedButton.icon(
            onPressed: () {
              auth.signInWithGoogle();
            },
            icon: LineIcon.googleLogo(),
            label: const Text('data'),
          )
        ],
      ),
    ));
  }
}
