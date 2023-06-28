import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

import '../../controllers/mixin.dart';
import '../../services/init_services.dart';
import '../../services/ui/responsive_design.dart';
import '../../widgets/label_info_text_widget.dart';

class UserProfile extends StatelessWidget with ControllersMixin {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final rd = locator<ResponsiveDesign>();
    return SingleChildScrollView(
      child: Padding(
        padding: rd.getPadding(context),
        child: Column(
          children: [
            authController.user.value?.photoURL != null
                ? CircleAvatar(
                    radius: rd.getWidth(context) * 0.15,
                    backgroundImage: NetworkImage(
                        authController.user.value!.photoURL.toString()),
                  )
                : LineIcon.user(
                    size: 100,
                  ),
            SizedBox(
              height: rd.spacerMd(context),
            ),
            LabelInfoWidget(
              icon: LineIcon.user(),
              value: authController.user.value!.displayName ?? '',
              label: 'Display Name',
            ),
            SizedBox(
              height: rd.spacerSm(context),
            ),
            LabelInfoWidget(
              icon: LineIcon.envelope(),
              value: authController.user.value!.email ?? '',
              label: 'Email',
            ),
            SizedBox(
              height: rd.spacerSm(context),
            ),
            LabelInfoWidget(
              icon: LineIcon.phone(),
              value: authController.user.value!.phoneNumber ?? '',
              label: 'Mobile Number',
            ),
            SizedBox(
              height: rd.spacerSm(context),
            ),
            LabelInfoWidget(
                label: 'Active Since',
                icon: LineIcon.times(),
                value: authController.user.value!.metadata.creationTime
                        ?.toLocal()
                        .toString() ??
                    ''),
            SizedBox(
              height: rd.spacerSm(context),
            ),
            LabelInfoWidget(
                label: 'Last Sign Time',
                icon: LineIcon.envelope(),
                value: authController.user.value!.metadata.lastSignInTime
                        ?.toLocal()
                        .toString() ??
                    ''),
          ],
        ),
      ),
    );
  }
}


