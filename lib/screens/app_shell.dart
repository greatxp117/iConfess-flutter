import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../theme.dart';
import '../services/ui_state.dart';
import 'package:iconfess/constants/app_constants.dart';

/// AppShell wraps tab destinations and shows a bottom tab bar on mobile.
class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  static final _tabs = [
    _TabItem(label: 'Home', icon: LucideIcons.house, route: '/'),
    _TabItem(label: 'Examen', icon: LucideIcons.squareCheck, route: '/examen'),
    _TabItem(label: 'Map', icon: LucideIcons.mapPin, route: '/map'),
    _TabItem(label: 'Learn', icon: LucideIcons.bookOpen, route: '/learn'),
    _TabItem(label: 'Browse', icon: LucideIcons.compass, route: '/browse'),
  ];

  int _currentIndexForLocation(String location) {
    // Match by prefix to handle query params etc.
    for (var i = 0; i < _tabs.length; i++) {
      if (location == _tabs[i].route) return i;
    }
    // Default to home if no match
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.md;
    final currentIndex = _currentIndexForLocation(location);

    Widget _buildBottomBar(bool sheetOpen) {
      final hideMobileNav = isMobile && sheetOpen;
      // shadcn-style mobile bottom bar (floating style handled below)
      if (isMobile && !hideMobileNav) {
        return _FloatingBottomNavBar(
          tabs: _tabs,
          currentIndex: currentIndex,
          onTap: (i) {
            final dest = _tabs[i];
            if (dest.route != location) context.go(dest.route);
          },
        );
      }
      return const SizedBox.shrink();
    }

    if (!isMobile) {
      // Sidebar layout for md+ screens
      return Scaffold(
        body: Row(
          children: [
            _ShadSidebar(
              tabs: _tabs,
              currentIndex: currentIndex,
              onTap: (i) {
                final dest = _tabs[i];
                if (dest.route != location) context.go(dest.route);
              },
            ),
            // Divider between sidebar and content
            Container(
              width: 1,
              color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
            ),
            Expanded(child: child),
          ],
        ),
      );
    }

    // Mobile: overlay floating bottom bar on top of content, hidden when sheet open
    return ValueListenableBuilder<bool>(
      valueListenable: GlobalUiState.examenSheetOpen,
      builder: (context, sheetOpen, _) {
        final bottomBar = _buildBottomBar(sheetOpen);
        final mediaPadding = MediaQuery.of(context).padding;
        // Reserve space at bottom so scrollable content isn’t obscured by the floating tab bar
        const double barHeight = 60;
        const double barBottomMargin = 12;
        final bool showBottomBar = isMobile && bottomBar is! SizedBox;
        final double bottomSpace = showBottomBar
            ? barHeight + barBottomMargin + mediaPadding.bottom
            : 0;
        final Widget paddedChild = showBottomBar
            ? Padding(
                padding: EdgeInsets.only(bottom: bottomSpace),
                child: child,
              )
            : child;
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(child: paddedChild),
              if (bottomBar is! SizedBox)
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 12,
                  child: SafeArea(
                    top: false,
                    child: bottomBar,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _TabItem {
  final String label;
  final IconData icon;
  final String route;
  const _TabItem({required this.label, required this.icon, required this.route});
}

class _ShadBottomNavBar extends StatelessWidget {
  final List<_TabItem> tabs;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _ShadBottomNavBar({
    required this.tabs,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(color: theme.dividerColor.withValues(alpha: 0.1), width: 1),
        ),
      ),
      height: 64,
      child: Row(
        children: [
          for (int i = 0; i < tabs.length; i++)
            Expanded(
              child: _NavButton(
                icon: tabs[i].icon,
                label: tabs[i].label,
                selected: i == currentIndex,
                onTap: () => onTap(i),
                orientation: Axis.vertical,
              ),
            ),
        ],
      ),
    );
  }
}

/// Floating bottom nav bar with shadcn look: blurred, rounded, subtle border/shadow
class _FloatingBottomNavBar extends StatelessWidget {
  final List<_TabItem> tabs;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _FloatingBottomNavBar({
    required this.tabs,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimens.radiusLg),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(AppDimens.radiusLg),
            border: Border.all(
              color: theme.dividerColor.withValues(alpha: 0.12),
              width: 1,
            ),
            boxShadow: AppShadows.elevation3,
          ),
          child: Row(
            children: [
              for (int i = 0; i < tabs.length; i++)
                Expanded(
                  child: _NavButton(
                    icon: tabs[i].icon,
                    label: tabs[i].label,
                    selected: i == currentIndex,
                    onTap: () => onTap(i),
                    orientation: Axis.vertical,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShadSidebar extends StatelessWidget {
  final List<_TabItem> tabs;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _ShadSidebar({
    required this.tabs,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 220,
      color: theme.colorScheme.surface,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              // App brand / spacer
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                      onTap: () => context.go('/'),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/logoword.png',
                            height: 20,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              for (int i = 0; i < tabs.length; i++)
                _NavButton(
                  icon: tabs[i].icon,
                  label: tabs[i].label,
                  selected: i == currentIndex,
                  onTap: () => onTap(i),
                  orientation: Axis.horizontal,
                ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Axis orientation; // vertical for bottom bar, horizontal for sidebar

  const _NavButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    required this.orientation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedColor = theme.colorScheme.primary;
    final baseColor = theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.7);

    final child = orientation == Axis.vertical
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: selected ? selectedColor : baseColor),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  color: selected ? selectedColor : baseColor,
                ),
              ),
            ],
          )
        : Row(
            children: [
              const SizedBox(width: 12),
              Icon(icon, size: 18, color: selected ? selectedColor : baseColor),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                    color: selected ? selectedColor : baseColor,
                  ),
                ),
              ),
            ],
          );

    return Padding(
      padding: orientation == Axis.vertical
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimens.radiusSm),
        child: Container(
          height: orientation == Axis.vertical ? double.infinity : 40,
          decoration: selected
              ? BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                )
              : null,
          child: child,
        ),
      ),
    );
  }
}
