import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../widgets/responsive_nav.dart';
import '../widgets/header_component.dart';
import '../routes/go_router_config.dart';
import 'package:iconfess/widgets/shared/mobile_nav_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      drawer: const MobileNavDrawer(),
      body: Column(
        children: [
          // Top title bar
          const ResponsiveNav(),
          // Main content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Hero section – welcoming landing copy
                  HeaderComponent(
                    badgeText: 'Welcome to iConfess',
                    badgeIcon: 'arrow_forward',
                    title: 'Encounter mercy. Begin again.',
                    description:
                        'A gentle guide to the Sacrament of Reconciliation — nearby confession times, a thoughtful examination of conscience, and simple next steps.',
                    subtitle:
                        '"The confessional is not a torture chamber, but the place of the Lord’s mercy." — Pope Francis',
                    actions: [
                      HeaderAction(
                        text: 'Find Confessions Near Me',
                        onPressed: () => context.go(AppRoutes.map),
                        variant: HeaderActionVariant.primary,
                      ),
                      HeaderAction(
                        text: 'Examination of Conscience',
                        onPressed: () => context.go(AppRoutes.examen),
                        variant: HeaderActionVariant.secondary,
                      ),
                      HeaderAction(
                        text: 'Settings',
                        onPressed: () => context.go(AppRoutes.settings),
                        variant: HeaderActionVariant.ghost,
                      ),
                    ],
                  ),

                  // Quick links section – shadcn-style cards
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth >= 900;
                        final isMedium = constraints.maxWidth >= 600;
                        final crossAxisCount = isWide ? 3 : (isMedium ? 2 : 1);

                        final items = [
                          _QuickLink(
                            icon: LucideIcons.mapPin,
                            title: 'Nearby Churches',
                            description: 'See parishes offering confession close to you.',
                            onTap: () => context.go(AppRoutes.map),
                            accentColor: theme.colorScheme.secondary,
                          ),
                          _QuickLink(
                            icon: LucideIcons.squareCheck,
                            title: 'Begin the Examen',
                            description: 'A calm, guided review of life since last confession.',
                            onTap: () => context.go(AppRoutes.examen),
                            accentColor: theme.colorScheme.primary,
                          ),
                          _QuickLink(
                            icon: LucideIcons.settings,
                            title: 'Personalize iConfess',
                            description: 'Preferences, reminders, and privacy controls.',
                            onTap: () => context.go(AppRoutes.settings),
                            accentColor: theme.colorScheme.secondary,
                          ),
                        ];

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: isWide ? 1.8 : 1.6,
                          ),
                          itemBuilder: (context, index) => items[index],
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickLink extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;
  final Color accentColor;

  const _QuickLink({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: accentColor.withValues(alpha: 0.3),
                ),
              ),
              child: Icon(icon, size: 20, color: accentColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.75),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
