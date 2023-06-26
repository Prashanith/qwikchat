import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyle = const TextStyle(
  fontWeight: FontWeight.normal,
);

TextTheme textTheme = GoogleFonts.acmeTextTheme(TextTheme(
  displayLarge: textStyle.merge(const TextStyle(fontSize: 36)),
  displayMedium: textStyle.merge(const TextStyle(fontSize: 32)),
  displaySmall: textStyle.merge(const TextStyle(fontSize: 30)),
  headlineLarge: textStyle.merge(const TextStyle(fontSize: 28)),
  headlineMedium: textStyle.merge(const TextStyle(fontSize: 26)),
  headlineSmall: textStyle.merge(const TextStyle(fontSize: 24)),
  titleLarge: textStyle.merge(const TextStyle(fontSize: 22)),
  titleMedium: textStyle.merge(const TextStyle(fontSize: 20)),
  titleSmall: textStyle.merge(const TextStyle(fontSize: 18)),
  bodyLarge: textStyle.merge(const TextStyle(fontSize: 16)),
  bodyMedium: textStyle.merge(const TextStyle(fontSize: 14)),
  bodySmall: textStyle.merge(const TextStyle(fontSize: 12)),
  labelLarge: textStyle.merge(const TextStyle(fontSize: 10)),
  labelMedium: textStyle.merge(const TextStyle(fontSize: 9)),
  labelSmall: textStyle.merge(const TextStyle(fontSize: 8)),
));
