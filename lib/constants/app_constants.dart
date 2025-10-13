/// Application-wide constants and configuration
/// This file centralizes all hardcoded values for better maintainability
library;

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
