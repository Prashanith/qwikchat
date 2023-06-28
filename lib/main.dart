import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/config.dart';
import 'controllers/application.dart';
import 'navigation/route_generator.dart';
import 'services/init_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ServiceInitializer.initializeServices();
  final ac = Get.put(ApplicationController());
  await ac.postInitializationCalls();
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

FlexSchemeColor scheme = const FlexSchemeColor(
  primary: Color(0xff2196F3),
  primaryContainer: Colors.black,
  secondary: Color(0xff526D82),
  secondaryContainer: Color(0xffececec),
);

const Color contColor = Color(0xffDDE6ED);

FlexSchemeColor darkScheme = FlexSchemeColor(
    primary: const Color(0xff272a37),
    primaryContainer: const Color(0xff1d90f5),
    secondary: const Color(0xff323644),
    secondaryContainer: contColor,
    tertiary: const Color(0xff373b4a),
    tertiaryContainer: contColor,
    error: Colors.red.shade600);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'QWIKCHAT',
      showSemanticsDebugger: false,
      // theme: FlexThemeData.light(
      //     useMaterial3: true,
      //     appBarElevation: 20,
      //     appBarBackground: Colors.yellow,
      //     appBarStyle: FlexAppBarStyle.primary,
      //     colors: scheme,
      //     lightIsWhite: false,
      //     textTheme: textTheme,
      //     platform: defaultTargetPlatform,
      //     subThemesData: FlexSubThemesData(
      //         appBarBackgroundSchemeColor: SchemeColor.primaryContainer,
      //         inputDecoratorFillColor: scheme.secondaryContainer,
      //         inputDecoratorIsFilled: true,
      //         outlinedButtonTextStyle:
      //             MaterialStatePropertyAll(textTheme.bodyMedium),
      //         outlinedButtonSchemeColor: SchemeColor.primaryContainer,
      //         elevatedButtonSecondarySchemeColor: SchemeColor.primary,
      //         elevatedButtonElevation: 15,
      //         elevatedButtonSchemeColor: SchemeColor.secondary)),
      darkTheme: FlexThemeData.dark(
          colors: darkScheme,
          // scheme: ,
          // colorScheme: ,
          // usedColors: ,
          // surfaceMode:,
          // blendLevel: ,
          appBarStyle: FlexAppBarStyle.scaffoldBackground,
          appBarOpacity: 1,
          // transparentStatusBar: ,
          appBarElevation: 20,
          bottomAppBarElevation: 20,
          // tabBarStyle: ,
          primary: darkScheme.primary,
          primaryContainer: darkScheme.primaryContainer,
          secondary: darkScheme.secondary,
          secondaryContainer: darkScheme.secondaryContainer,
          tertiary: darkScheme.tertiary,
          tertiaryContainer: darkScheme.tertiaryContainer,
          error: darkScheme.error,
          // surface:   ,
          background: darkScheme.primary,
          scaffoldBackground: darkScheme.primary,
          // dialogBackground:,
          appBarBackground: darkScheme.primary,

          // onPrimary: ,
          onPrimaryContainer: darkScheme.secondary,
          // onSecondary: ,
          onSecondaryContainer: darkScheme.secondary,
          // onTertiary: ,
          onTertiaryContainer: darkScheme.secondary,
          // onSurface: ,
          onBackground: darkScheme.secondary,
          // onError: ,
          // surfaceTint:,
          darkIsTrueBlack: false,
          // swapColors:,
          // tooltipsMatchBackground:,
          // subThemesData: ,
          // keyColors:,
          useMaterial3ErrorColors: false,
          // tones:,
          // visualDensity:,
          textTheme: textTheme,
          // primaryTextTheme:,
          // fontFamily:,
          // fontFamilyFallback:,
          // package:,
          // materialTapTargetSize:,
          // pageTransitionsTheme:,
          platform: defaultTargetPlatform,
          // typography:,
          // applyElevationOverlayColor:,
          useMaterial3: true,
          swapLegacyOnMaterial3: false,
          // extensions:,
          subThemesData: FlexSubThemesData(
              elevatedButtonSchemeColor: SchemeColor.secondaryContainer,
              elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
              elevatedButtonElevation: 4,
              elevatedButtonRadius: 8,
              outlinedButtonBorderWidth: 0.4,
              outlinedButtonRadius: 4,
              outlinedButtonSchemeColor: SchemeColor.secondaryContainer,
              outlinedButtonTextStyle:
                  MaterialStatePropertyAll(context.textTheme.titleSmall),
              outlinedButtonOutlineSchemeColor: SchemeColor.secondaryContainer,

              // TEXT FORM FIELD
              inputDecoratorIsFilled: true,
              inputDecoratorFillColor: darkScheme.secondary,
              inputDecoratorPrefixIconSchemeColor:
                  SchemeColor.secondaryContainer,
              inputDecoratorRadius: 12,
              inputDecoratorUnfocusedHasBorder: false,

              // BOTTOM NAVIGATION BAR
              bottomAppBarSchemeColor: SchemeColor.secondary,
              bottomNavigationBarBackgroundSchemeColor: SchemeColor.secondary,
              bottomNavigationBarSelectedLabelSchemeColor:
                  SchemeColor.primaryContainer,
              bottomNavigationBarSelectedIconSchemeColor:
                  SchemeColor.primaryContainer,
              bottomNavigationBarUnselectedLabelSchemeColor:
                  SchemeColor.secondaryContainer,
              bottomNavigationBarUnselectedIconSchemeColor:
                  SchemeColor.secondaryContainer,
              bottomNavigationBarSelectedIconSize: 30,
              bottomNavigationBarSelectedLabelSize: 14,
              bottomNavigationBarUnselectedIconSize: 22,
              bottomNavigationBarUnselectedLabelSize: 12,
              bottomNavigationBarOpacity: 0.4,
              bottomNavigationBarElevation: 0,
              bottomNavigationBarLandscapeLayout:
                  BottomNavigationBarLandscapeLayout.spread,
              bottomNavigationBarType: BottomNavigationBarType.fixed)),
      themeMode: ThemeMode.dark,
      navigatorKey: locator.get<RouteGenerator>().navigator,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
