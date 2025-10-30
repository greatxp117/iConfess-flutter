/// Application-wide constants and configuration
/// This file centralizes all hardcoded values for better maintainability
library;

import 'package:flutter/material.dart';

class AppConstants {
  // URLs
  static const String dreamFlowUrl = 'https://dreamflow.app';
  static const String shadcnUiGithubUrl =
      'https://github.com/nank1ro/flutter-shadcn-ui';
  static const String shadcnUiPubUrl = 'https://pub.dev/packages/shadcn_ui';

  // App Information
  static const String appName = 'Shadcn UI Showcase';
  static const String appDescription =
      'Building Blocks for the Web - Clean, modern building blocks. Copy and paste into your apps.';

  // UI Text
  static const String browseBlocksText = 'Browse Blocks';
  static const String addBlockText = 'Add a block';
  static const String cloneProjectText = 'Clone This This Project in Dreamflow';
  static const String openInDreamflowText = 'Open in Dreamflow';

  // Route paths
  static const String homeRoute = '/';
  static const String componentsRoute = '/components';
  static const String componentDetailRoutePrefix = '/component';

  // Component status
  static const String statusComingSoon = 'Coming soon!';
  static const String statusDeleteConfirmation =
      'Are you sure you want to delete this item? This action cannot be undone.';

  // Error messages
  static const String genericErrorMessage =
      'Something went wrong. Please try again.';
  static const String networkErrorMessage =
      'Network error. Please check your connection.';

  // Loading states
  static const String loadingText = 'Loading...';
  static const String processingText = 'Processing';
  static const String savingText = 'Saving';

  // Success messages
  static const String successMessage = 'Operation completed successfully!';
  static const String itemDeletedMessage = 'Item deleted successfully.';

  // Private constructor to prevent instantiation
  const AppConstants._();
}

/// Global UI dimension constants
class AppDimens {
  // Base radius used previously across the app was roughly 8.
  // We define a base and expose scaled radii. Per request, we double the base.
  static const double radiusBase = 8.0;
  static const double radius = radiusBase * 2; // 16.0 (doubled)
  static const double radiusSm = radius * 0.5; // 8.0
  static const double radiusMd = radius; // 16.0
  static const double radiusLg = radius * 1.5; // 24.0
  static const double radiusXl = radius * 2; // 32.0
  static const double radiusPill = 999.0;

  const AppDimens._();
}

/// Global shadow tokens to add dimension consistently
class AppShadows {
  // Very subtle ambient shadow
  static List<BoxShadow> elevation1 = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  // Standard card shadow
  static List<BoxShadow> elevation2 = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.07),
      blurRadius: 18,
      offset: const Offset(0, 8),
    ),
  ];

  // Floating elements (FAB, floating nav)
  static List<BoxShadow> elevation3 = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.10),
      blurRadius: 28,
      offset: const Offset(0, 12),
    ),
  ];

  const AppShadows._();
}

/// Subtle text shadows for large titles
class TextDepth {
  static const List<Shadow> soft = [
    Shadow(
      color: Color(0x33000000), // 20% black
      blurRadius: 6,
      offset: Offset(0, 2),
    ),
  ];

  static const List<Shadow> medium = [
    Shadow(
      color: Color(0x26000000), // 15% black
      blurRadius: 10,
      offset: Offset(0, 3),
    ),
  ];

  const TextDepth._();
}
