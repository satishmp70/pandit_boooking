import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// DivyaSeva design tokens: paper / ink / kumkum tones.
class DvColors {
  const DvColors._();

  static const paper = Color(0xFFF3EDE3);
  static const paper2 = Color(0xFFE8DFD0);
  static const appBg = Color(0xFFFAF6EF);
  static const surface = Color(0xFFFFFFFF);

  static const ink = Color(0xFF241C17);
  static const ink2 = Color(0xFF5E5046);
  static const ink3 = Color(0xFF8E7F71);

  static const line = Color(0xFFDCD1BF);
  static const line2 = Color(0xFFEDE5D8);

  static const kum = Color(0xFFB4342A);
  static const kumSoft = Color(0xFFFBEDEB);
  static const kumDeep = Color(0xFF8A241C);

  static const brass = Color(0xFFA97A1C);
  static const brassSoft = Color(0xFFFBF2DE);
  static const brassText = Color(0xFF6E4A08);

  static const indigo = Color(0xFF241F4B);

  static const green = Color(0xFF2C7A52);
  static const greenSoft = Color(0xFFE9F4ED);
  static const greenDeep = Color(0xFF1E5C3B);

  static const amber = Color(0xFFA9700F);
  static const amberSoft = Color(0xFFFDF2DC);
  static const amberText = Color(0xFF7A4E06);

  static const heroStart = Color(0xFF2A2352);
  static const heroEnd = Color(0xFF3C2140);
  static const gold = Color(0xFFD9A648);
}

class DvText {
  const DvText._();

  static TextStyle display({
    double size = 24,
    Color color = DvColors.ink,
    FontWeight weight = FontWeight.w400,
    double height = 1.15,
  }) => GoogleFonts.marcellus(
    fontSize: size,
    color: color,
    fontWeight: weight,
    height: height,
  );

  static TextStyle body({
    double size = 14,
    Color color = DvColors.ink,
    FontWeight weight = FontWeight.w400,
    double height = 1.45,
    double spacing = 0,
  }) => GoogleFonts.mukta(
    fontSize: size,
    color: color,
    fontWeight: weight,
    height: height,
    letterSpacing: spacing,
  );

  static TextStyle mono({
    double size = 13,
    Color color = DvColors.ink,
    FontWeight weight = FontWeight.w500,
  }) => GoogleFonts.ibmPlexMono(
    fontSize: size,
    color: color,
    fontWeight: weight,
  );

  static TextStyle eyebrow({Color color = DvColors.ink3}) =>
      body(size: 11, weight: FontWeight.w700, color: color, spacing: 1.4);
}

class DvTheme {
  const DvTheme._();

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: DvColors.kum,
        primary: DvColors.kum,
        surface: DvColors.surface,
      ),
      scaffoldBackgroundColor: DvColors.appBg,
    );
    return base.copyWith(
      textTheme: GoogleFonts.muktaTextTheme(base.textTheme),
    );
  }
}
