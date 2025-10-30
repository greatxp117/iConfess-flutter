import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconfess/constants/app_constants.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// A minimalist, shadcn-inspired header used across the app.
///
/// - Shows iConfess brand on the left
/// - Optional back button
/// - Subtle bottom border and soft blur on supported platforms
class MinimalHeader extends StatelessWidget {
  final bool showBack;
  final VoidCallback? onBack;
  final String? subtitle; // optional small caption on the right

  const MinimalHeader({super.key, this.showBack = false, this.onBack, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final divider = theme.dividerColor.withValues(alpha: 0.10);
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            // Colorful gradient background to ensure white logo contrast
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.secondary,
              ],
            ),
            border: Border(
              bottom: BorderSide(color: divider, width: 1),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000), // 20% black
                blurRadius: 16,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: IconTheme(
                data: IconThemeData(color: theme.colorScheme.onPrimary),
                child: Row(
                  children: [
                    if (showBack)
                      _GhostIconButton(
                        icon: LucideIcons.chevronLeft,
                        onPressed: onBack ?? () => context.pop(),
                      ),
                    if (showBack) const SizedBox(width: 6),
                    _BrandChip(),
                    const Spacer(),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.onPrimary.withValues(alpha: 0.85),
                          shadows: const [
                            Shadow(color: Color(0x33000000), blurRadius: 8, offset: Offset(0, 2)),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
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
    );
  }
}

class _GhostIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const _GhostIconButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppDimens.radiusSm),
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, size: 20),
      ),
    );
  }
}
