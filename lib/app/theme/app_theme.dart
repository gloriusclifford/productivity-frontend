import 'package:flutter/material.dart';

class PlanItColors {
  static const Color background = Color(0xFFFAFAF7);
  static const Color foreground = Color(0xFF1E2022);
  static const Color card = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE8E9E2);

  static const Color primary = Color(0xFFFFBA18);
  static const Color primaryForeground = Color(0xFF1E2022);
  static const Color primaryHover = Color(0xFFEFAC0C);

  static const Color secondary = Color(0xFFE2F0BD);
  static const Color secondaryForeground = Color(0xFF35462B);

  static const Color sage = Color(0xFF8DB654);
  static const Color accentForeground = Color(0xFF263B1B);

  static const Color muted = Color(0xFFF0F1EB);
  static const Color mutedForeground = Color(0xFF73776E);

  static const Color yellow = Color(0xFFFBE577);
  static const Color terracotta = Color(0xFFDB5B23);
}

class PlanItStyles {
  static const double radiusCard = 24.0;
  static const double radiusInput = 16.0;
  static const double radiusButton = 999.0;

  static const EdgeInsets paddingCard = EdgeInsets.all(24.0);
  static const EdgeInsets paddingCardLarge = EdgeInsets.all(28.0);
  static const EdgeInsets paddingInput = EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0);
  static const EdgeInsets paddingButton = EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0);

  static const List<BoxShadow> shadowActiveDate = [
    BoxShadow(
      color: Color(0x338DB654),
      offset: Offset(0, 5),
      blurRadius: 14,
    ),
  ];

  static const List<BoxShadow> shadowDialog = [
    BoxShadow(
      color: Colors.black26,
      offset: Offset(0, 25),
      blurRadius: 50,
    ),
  ];
}

/// -----------------------------------
/// FLUTTER THEMEDATA
/// -----------------------------------
ThemeData getPlanItTheme() {
  return ThemeData(
    scaffoldBackgroundColor: PlanItColors.background,
    primaryColor: PlanItColors.primary,
    fontFamily: 'Inter',

    colorScheme: const ColorScheme.light(
      primary: PlanItColors.primary,
      onPrimary: PlanItColors.primaryForeground,
      secondary: PlanItColors.secondary,
      onSecondary: PlanItColors.secondaryForeground,
      surface: PlanItColors.card,
      onSurface: PlanItColors.foreground,
      error: PlanItColors.terracotta,
      background: PlanItColors.background,
      onBackground: PlanItColors.foreground,
      outline: PlanItColors.border,
    ),

    cardTheme: CardThemeData(
      color: PlanItColors.card,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(PlanItStyles.radiusCard),
        side: const BorderSide(color: PlanItColors.border, width: 1),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: PlanItColors.primary,
        foregroundColor: PlanItColors.primaryForeground,
        elevation: 0,
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
        padding: PlanItStyles.paddingButton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PlanItStyles.radiusButton),
        ),
      ),
    ),

    // Fixed OutlineRectangleBorder -> OutlineInputBorder
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: PlanItColors.background,
      contentPadding: PlanItStyles.paddingInput,
      hintStyle: const TextStyle(
        color: PlanItColors.mutedForeground,
        fontSize: 14,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(PlanItStyles.radiusInput),
        borderSide: const BorderSide(color: PlanItColors.border, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(PlanItStyles.radiusInput),
        borderSide: const BorderSide(color: PlanItColors.sage, width: 1.5),
      ),
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w600,
        color: PlanItColors.foreground,
        height: 1.15,
      ),
      displayMedium: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: PlanItColors.foreground,
      ),
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: PlanItColors.foreground,
        height: 1.2,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: PlanItColors.foreground,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: PlanItColors.foreground,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: PlanItColors.foreground,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: PlanItColors.mutedForeground,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.5,
        color: PlanItColors.mutedForeground,
      ),
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: PlanItColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28.0),
        ),
      ),
    ),
  );
}