import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../main.dart';
import '../../navigation/route_generator.dart';
import '../../services/init_services.dart';
import '../../services/local_storage.dart';
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
        child: Container(
          color: darkScheme.primary,
          padding: rd.getPadding(context),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(
                  'assets/init_bg.svg',
                  width: rd.getWidth(context, excludePadding: true),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: rd.spacerCustom(context, 0.1),
                    ),
                    Text(
                      'Enjoy the new experience of chatting with global friends',
                      style: context.textTheme.bodyLarge?.merge(const TextStyle(
                        fontWeight: FontWeight.w700,
                      )),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Connection Redefined',
                      style: context.textTheme.bodyLarge?.merge(TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade700)),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: rd.spacerCustom(context, 0.1),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5000)
                          )
                        ),
                        onPressed: () async {
                          var s = locator<LocalStorage>();
                          await s.setValue('isFirstInstall', false);
                          router.navigator.currentState?.pushNamed('/login');
                        },
                        child: Text(
                          'Get Started',
                          style: context.textTheme.titleSmall!
                              .merge(const TextStyle(color: Colors.white)),
                        ))
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
