import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        widget: SizedBox(
      height: rd.getScreenHeight(context),
      // decoration: const BoxDecoration(
      //     image: DecorationImage(
      //         fit: BoxFit.fitHeight, image: AssetImage('assets/loginbg.png'))),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: rd.spacerXl(context) * 2,
            ),
            Row(
              children: [
                const Image(
                  image: AssetImage('assets/comment.png'),
                  height: 30,
                  width: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text('QWIKCHAT', style: theme.titleLarge)
              ],
            ),
            SizedBox(
              height: rd.spacerXs(context),
            ),
            Text(
              'A secure place to connect',
              style: context.textTheme.bodyLarge
                  ?.merge(const TextStyle(fontWeight: FontWeight.w600)),
            ),
            SizedBox(
              height: rd.spacerSm(context),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 20)),
              onPressed: () {
                auth.signInWithGoogle();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/google.png',
                      height: 25,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text('Continue with Google')
                  ],
                ),
              ),
            ),
            SizedBox(
              height: rd.spacerSm(context),
            ),
            const Text(
                'By Signing up you agree to the Qwik Chat Terms of use and Privacy Policy')
          ],
        ),
      ),
    ));
  }
}
