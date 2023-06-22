import 'package:flutter/material.dart';

import '../../navigation/route_generator.dart';
import '../../navigation/routes.dart';
import '../../services/init_services.dart';
import '../../services/ui/responsive_design.dart';
import '../../widgets/page_wrappers/plain_scaffold.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rd = locator<ResponsiveDesign>();
    final router = locator<RouteGenerator>();
    return PlainScaffold(
      removePadding: true,
      widget: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/init.png',
                width: rd.getWidth(context, excludePadding: true),
              ),
              Container(
                padding: rd.getPadding(context),
                constraints: BoxConstraints(
                    minHeight:
                        rd.getScreenHeight(context, excludePadding: true) *
                            0.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: rd.spacerCustom(context, 0.1),
                    ),
                    const Text(
                        'Enjoy the new experience of chatting with global friends'),
                    const Text('Connection Redefined'),
                    SizedBox(
                      height: rd.spacerCustom(context, 0.1),
                    ),
                    ElevatedButton(
                        onPressed: () =>
                            router.navigator.currentState?.pushNamed('/login'),
                        child: const Text('Get Started'))
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
