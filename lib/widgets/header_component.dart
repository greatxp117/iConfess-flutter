import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../theme.dart';

/// A reusable header component that can be used across different screens
class HeaderComponent extends StatelessWidget {
  final String? badgeText;
  final String? badgeIcon;
  final String title;
  final String description;
  final String? subtitle;
  final List<HeaderAction>? actions;
  final bool centerContent;
  final EdgeInsets? padding;

  const HeaderComponent({
    super.key,
    this.badgeText,
    this.badgeIcon,
    required this.title,
    required this.description,
    this.subtitle,
    this.actions,
    this.centerContent = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= Breakpoints.lg;
        final isTablet = constraints.maxWidth >= Breakpoints.md;

        return Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isDesktop ? 800 : (isTablet ? 600 : double.infinity),
            ),
            padding: padding ??
                EdgeInsets.symmetric(
                  horizontal: isDesktop ? 0 : 24,
                  vertical: 48,
                ),
            child: Column(
              mainAxisAlignment: centerContent
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                // Badge (optional)
                if (badgeText != null) ...[
                  ShadBadge.secondary(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(badgeText!),
                        if (badgeIcon != null) ...[
                          const SizedBox(width: 8),
                          Icon(
                            _getIconData(badgeIcon!),
                            size: 14,
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],

                // Main heading
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isDesktop ? 56 : (isTablet ? 48 : 36),
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                    letterSpacing: -0.02,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 24),

                // Description
                Text(
                  description,
                  style: TextStyle(
                    fontSize: isDesktop ? 18 : 16,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.7),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),

                // Subtitle (optional)
                if (subtitle != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: isDesktop ? 16 : 14,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.7),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],

                // Action buttons (optional)
                if (actions != null && actions!.isNotEmpty) ...[
                  const SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: actions!.map((action) {
                      final isFirst = actions!.indexOf(action) == 0;
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!isFirst) const SizedBox(width: 16),
                          _buildActionButton(context, action),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton(BuildContext context, HeaderAction action) {
    switch (action.variant) {
      case HeaderActionVariant.primary:
        return ShadButton(
          onPressed: action.onPressed,
          child: Text(action.text),
        );
      case HeaderActionVariant.secondary:
        return ShadButton.outline(
          onPressed: action.onPressed,
          child: Text(action.text),
        );
      case HeaderActionVariant.ghost:
        return ShadButton.ghost(
          onPressed: action.onPressed,
          child: Text(action.text),
        );
      case HeaderActionVariant.destructive:
        return ShadButton.destructive(
          onPressed: action.onPressed,
          child: Text(action.text),
        );
    }
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'arrow_forward':
        return Icons.arrow_forward;
      case 'add':
        return Icons.add;
      case 'search':
        return Icons.search;
      case 'settings':
        return Icons.settings;
      default:
        return Icons.arrow_forward;
    }
  }
}

/// Represents an action button in the header
class HeaderAction {
  final String text;
  final VoidCallback? onPressed;
  final HeaderActionVariant variant;

  const HeaderAction({
    required this.text,
    this.onPressed,
    this.variant = HeaderActionVariant.primary,
  });
}

/// Available action button variants
enum HeaderActionVariant {
  primary,
  secondary,
  ghost,
  destructive,
}
