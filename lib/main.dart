import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/config.dart';
import 'navigation/route_generator.dart';
import 'services/init_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ServiceInitializer.initializeServices();
  runApp(const MyApp());
}

class BrandTheme extends ThemeExtension<BrandTheme> {
  const BrandTheme({
    this.brandColor,
  });
  final Color? brandColor;

  @override
  BrandTheme copyWith({
    Color? brandColor,
  }) =>
      BrandTheme(
        brandColor: brandColor ?? this.brandColor,
      );

  @override
  BrandTheme lerp(ThemeExtension<BrandTheme>? other, double t) {
    if (other is! BrandTheme) {
      return this;
    }
    return BrandTheme(
      brandColor: Color.lerp(brandColor, other.brandColor, t),
    );
  }
}

const BrandTheme lightBrandTheme = BrandTheme(
  brandColor: Color.fromARGB(255, 8, 79, 71),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Qwik Chat',
      theme: FlexThemeData.light(
          useMaterial3: true,
          appBarBackground: Colors.blue.shade900,
          appBarStyle: FlexAppBarStyle.surface,
          colors: FlexSchemeColor(
              primary: Colors.blue.shade900,
              secondary: Colors.blue.shade50,
              tertiary: Colors.grey.shade500),
          lightIsWhite: false,
          textTheme: textTheme,
          platform: defaultTargetPlatform,
          subThemesData: const FlexSubThemesData(
              elevatedButtonSecondarySchemeColor: SchemeColor.primary,
              elevatedButtonSchemeColor: SchemeColor.secondary)),
      themeMode: ThemeMode.light,
      navigatorKey: locator.get<RouteGenerator>().navigator,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
