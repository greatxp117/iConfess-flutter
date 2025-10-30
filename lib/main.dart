import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'widgets/component_examples/component_example_registry.dart';
import 'routes/go_router_config.dart';
import 'theme.dart';

/// Entry point for the shadcn/ui Flutter showcase application.
/// This application demonstrates various shadcn/ui components with interactive examples
/// and responsive design.
void main() {
  // Initialize all component examples before starting the app
  // This ensures all components are registered and available throughout the app
  ComponentExampleRegistry.registerAll();

  runApp(const MyApp());
}

/// Root widget for the shadcn/ui showcase application.
///
/// This widget sets up the main application structure with:
/// - Go Router for navigation
/// - Standard Flutter theme integration with custom light theme
/// - Responsive design support
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp(
      home: MaterialApp.router(
        theme: lightTheme,
        routerConfig: GoRouterConfig.router,
      ),
    );
  }
}
