import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../screens/home_screen.dart';
import '../screens/components_screen.dart';
import '../screens/component_detail/component_detail_screen.dart';
import '../screens/app_shell.dart';
import '../screens/map_search_screen.dart';
import '../screens/examination_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/learn_screen.dart';
import '../screens/article_detail_screen.dart';

/// GoRouter configuration for the application
class GoRouterConfig {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      // Shell with bottom tabs
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            pageBuilder: (context, state) => NoTransitionPage(
              child: const HomeScreen(),
            ),
          ),
          GoRoute(
            path: '/map',
            name: 'map',
            pageBuilder: (context, state) => NoTransitionPage(
              child: const MapSearchScreen(),
            ),
          ),
          GoRoute(
            path: '/learn',
            name: 'learn',
            pageBuilder: (context, state) => NoTransitionPage(
              child: const LearnScreen(),
            ),
          ),
          GoRoute(
            path: '/learn/:slug',
            name: 'article',
            pageBuilder: (context, state) {
              final slug = state.pathParameters['slug']!;
              return NoTransitionPage(
                child: ArticleDetailScreen(slug: slug),
              );
            },
          ),
          GoRoute(
            path: '/examen',
            name: 'examen',
            pageBuilder: (context, state) => NoTransitionPage(
              child: const ExaminationScreen(),
            ),
          ),
          GoRoute(
            path: '/settings',
            name: 'settings',
            pageBuilder: (context, state) => NoTransitionPage(
              child: const SettingsScreen(),
            ),
          ),
        ],
      ),

      // Components route (outside shell)
      GoRoute(
        path: '/components',
        name: 'components',
        pageBuilder: (context, state) => NoTransitionPage(
          child: const ComponentsScreen(),
        ),
      ),

      // Component detail route with parameter
      GoRoute(
        path: '/component/:componentName',
        name: 'component-detail',
        pageBuilder: (context, state) {
          final componentName = state.pathParameters['componentName']!;
          return NoTransitionPage(
            child: _buildComponentDetailPage(componentName),
          );
        },
      ),
    ],
    errorBuilder: (context, state) {
      // Error page - redirect to home for unknown routes
      return const HomeScreen();
    },
  );

  /// Builds component detail page with proper data loading
  static Widget _buildComponentDetailPage(String componentName) {
    return ShadSonner(
      child: ComponentDetailScreen(
        componentName: componentName,
      ),
    );
  }
}

/// Route constants for type-safe navigation
class AppRoutes {
  static const String home = '/';
  static const String map = '/map';
  static const String learn = '/learn';
  static const String article = '/learn/:slug';
  static const String examen = '/examen';
  static const String settings = '/settings';
  static const String components = '/components';
  static const String componentDetail = '/component';

  /// Generate component route path
  static String componentRoute(String componentName) =>
      '$componentDetail/$componentName';

  /// Generate article route path
  static String articleRoute(String slug) => '/learn/$slug';

  /// Extract component name from route path
  static String? extractComponentName(String routePath) {
    if (!routePath.startsWith('$componentDetail/')) return null;
    final name = routePath.substring('$componentDetail/'.length);
    return name.isNotEmpty ? name : null;
  }

  /// Validate if route is valid
  static bool isValidRoute(String routePath) {
    return routePath == home ||
        routePath == components ||
        extractComponentName(routePath) != null;
  }
}
