import 'package:flutter/material.dart';
import 'package:iconfess/constants/app_constants.dart';

/// Application theme configuration following Flutter best practices.
/// This file defines colors, typography, and theme data for light mode.

/// Light mode color palette
class LightModeColors {
  static const lightPrimary = Color(0xFF722ED1);
  static const lightOnPrimary = Color(0xFFFFFFFF);
  static const lightPrimaryContainer = Color(0xFFEAE0FF);
  static const lightOnPrimaryContainer = Color(0xFF23105F);
  static const lightSecondary = Color(0xFF9254DE);
  static const lightOnSecondary = Color(0xFFFFFFFF);
  static const lightTertiary = Color(0xFF7E525D);
  static const lightOnTertiary = Color(0xFFFFFFFF);
  static const lightError = Color(0xFFBA1A1A);
  static const lightOnError = Color(0xFFFFFFFF);
  static const lightErrorContainer = Color(0xFFFFDAD6);
  static const lightOnErrorContainer = Color(0xFF410002);
  static const lightInversePrimary = Color(0xFFC6B3F7);
  static const lightShadow = Color(0xFF000000);
  static const lightSurface = Color(0xFFFAFAFA);
  static const lightOnSurface = Color(0xFF1C1C1C);
  static const lightAppBarBackground = Color(0xFFEAE0FF);

  // Legacy properties for backward compatibility
  static const Color primary = lightPrimary;
  static const Color primaryForeground = lightOnPrimary;
  static const Color secondary = lightSecondary;
  static const Color secondaryForeground = lightOnSecondary;
  static const Color accent = lightTertiary;
  static const Color accentForeground = lightOnTertiary;
  static const Color destructive = lightError;
  static const Color destructiveForeground = lightOnError;
  static const Color muted = lightSurface;
  static const Color mutedForeground = lightOnSurface;
  static const Color card = lightSurface;
  static const Color cardForeground = lightOnSurface;
  static const Color popover = lightSurface;
  static const Color popoverForeground = lightOnSurface;
  static const Color background = lightSurface;
  static const Color foreground = lightOnSurface;
  static const Color border = Color(0xFFE2E8F0);
  static const Color input = lightSurface;
  static const Color ring = lightPrimary;
  static const Color selection = Color(0xFFE2E8F0);
}

/// Font sizes and typography definitions
class FontSizes {
  static const double displayLarge = 57.0;
  static const double displayMedium = 45.0;
  static const double displaySmall = 36.0;
  static const double headlineLarge = 32.0;
  static const double headlineMedium = 24.0;
  static const double headlineSmall = 22.0;
  static const double titleLarge = 22.0;
  static const double titleMedium = 18.0;
  static const double titleSmall = 16.0;
  static const double labelLarge = 16.0;
  static const double labelMedium = 14.0;
  static const double labelSmall = 12.0;
  static const double bodyLarge = 16.0;
  static const double bodyMedium = 14.0;
  static const double bodySmall = 12.0;

  // Legacy properties for backward compatibility
  static const double xs = labelSmall;
  static const double sm = labelMedium;
  static const double base = bodyMedium;
  static const double lg = bodyLarge;
  static const double xl = titleSmall;
  static const double xl2 = titleMedium;
  static const double xl3 = titleLarge;
  static const double xl4 = headlineSmall;
  static const double xl5 = headlineMedium;
  static const double xl6 = headlineLarge;
  static const double xl7 = displaySmall;
  static const double xl8 = displayMedium;
  static const double xl9 = displayLarge;
}

/// Breakpoints for responsive design
class Breakpoints {
  static const double sm = 640.0;
  static const double md = 768.0;
  static const double lg = 1024.0;
  static const double xl = 1280.0;
  static const double xl2 = 1536.0;
}

/// Extension methods to check screen size
extension BreakpointExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;

  bool get isSm => screenWidth >= Breakpoints.sm;
  bool get isMd => screenWidth >= Breakpoints.md;
  bool get isLg => screenWidth >= Breakpoints.lg;
  bool get isXl => screenWidth >= Breakpoints.xl;
  bool get is2Xl => screenWidth >= Breakpoints.xl2;
}

/// Extension methods to easily access theme colors
extension ThemeColors on BuildContext {
  Color get primary => Theme.of(this).colorScheme.primary;
  Color get primaryForeground => Theme.of(this).colorScheme.onPrimary;
  Color get secondary => Theme.of(this).colorScheme.secondary;
  Color get secondaryForeground => Theme.of(this).colorScheme.onSecondary;
  Color get background => Theme.of(this).colorScheme.surface;
  Color get foreground => Theme.of(this).colorScheme.onSurface;
  Color get error => Theme.of(this).colorScheme.error;
  Color get errorForeground => Theme.of(this).colorScheme.onError;
  Color get surface => Theme.of(this).colorScheme.surface;
  Color get surfaceVariant =>
      Theme.of(this).colorScheme.surfaceContainerHighest;
  Color get outline => Theme.of(this).colorScheme.outline;
}

/// Light theme data
ThemeData get lightTheme => ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: LightModeColors.lightPrimary,
    onPrimary: LightModeColors.lightOnPrimary,
    primaryContainer: LightModeColors.lightPrimaryContainer,
    onPrimaryContainer: LightModeColors.lightOnPrimaryContainer,
    secondary: LightModeColors.lightSecondary,
    onSecondary: LightModeColors.lightOnSecondary,
    tertiary: LightModeColors.lightTertiary,
    onTertiary: LightModeColors.lightOnTertiary,
    error: LightModeColors.lightError,
    onError: LightModeColors.lightOnError,
    errorContainer: LightModeColors.lightErrorContainer,
    onErrorContainer: LightModeColors.lightOnErrorContainer,
    inversePrimary: LightModeColors.lightInversePrimary,
    shadow: LightModeColors.lightShadow,
    surface: LightModeColors.lightSurface,
    onSurface: LightModeColors.lightOnSurface,
  ),
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: LightModeColors.lightAppBarBackground,
    foregroundColor: LightModeColors.lightOnPrimaryContainer,
    elevation: 0,
  ),
  cardTheme: CardThemeData(
    elevation: 1.5,
    shadowColor: Colors.black.withValues(alpha: 0.08),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimens.radiusMd),
    ),
  ),
  dialogTheme: DialogThemeData(
    elevation: 2.0,
    shadowColor: Colors.black.withValues(alpha: 0.12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimens.radiusMd),
    ),
  ),
  bottomSheetTheme: BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppDimens.radiusLg),
      ),
    ),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: FontSizes.displayLarge,
      fontWeight: FontWeight.normal,
      fontFamily: 'Geist',
    ),
    displayMedium: TextStyle(
      fontSize: FontSizes.displayMedium,
      fontWeight: FontWeight.normal,
      fontFamily: 'Geist',
    ),
    displaySmall: TextStyle(
      fontSize: FontSizes.displaySmall,
      fontWeight: FontWeight.w600,
      fontFamily: 'Geist',
    ),
    headlineLarge: TextStyle(
      fontSize: FontSizes.headlineLarge,
      fontWeight: FontWeight.normal,
      fontFamily: 'Geist',
    ),
    headlineMedium: TextStyle(
      fontSize: FontSizes.headlineMedium,
      fontWeight: FontWeight.w500,
      fontFamily: 'Geist',
    ),
    headlineSmall: TextStyle(
      fontSize: FontSizes.headlineSmall,
      fontWeight: FontWeight.bold,
      fontFamily: 'Geist',
    ),
    titleLarge: TextStyle(
      fontSize: FontSizes.titleLarge,
      fontWeight: FontWeight.w500,
      fontFamily: 'Geist',
    ),
    titleMedium: TextStyle(
      fontSize: FontSizes.titleMedium,
      fontWeight: FontWeight.w500,
      fontFamily: 'Geist',
    ),
    titleSmall: TextStyle(
      fontSize: FontSizes.titleSmall,
      fontWeight: FontWeight.w500,
      fontFamily: 'Geist',
    ),
    labelLarge: TextStyle(
      fontSize: FontSizes.labelLarge,
      fontWeight: FontWeight.w500,
      fontFamily: 'Geist',
    ),
    labelMedium: TextStyle(
      fontSize: FontSizes.labelMedium,
      fontWeight: FontWeight.w500,
      fontFamily: 'Geist',
    ),
    labelSmall: TextStyle(
      fontSize: FontSizes.labelSmall,
      fontWeight: FontWeight.w500,
      fontFamily: 'Geist',
    ),
    bodyLarge: TextStyle(
      fontSize: FontSizes.bodyLarge,
      fontWeight: FontWeight.normal,
      fontFamily: 'Geist',
    ),
    bodyMedium: TextStyle(
      fontSize: FontSizes.bodyMedium,
      fontWeight: FontWeight.normal,
      fontFamily: 'Geist',
    ),
    bodySmall: TextStyle(
      fontSize: FontSizes.bodySmall,
      fontWeight: FontWeight.normal,
      fontFamily: 'Geist',
    ),
  ),
  fontFamily: 'Geist',
  fontFamilyFallback: ['Geist', 'sans-serif'],
);
