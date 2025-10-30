import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:iconfess/constants/app_constants.dart';
import 'package:iconfess/routes/go_router_config.dart';
import 'package:iconfess/widgets/component_categories.dart';
import 'package:iconfess/widgets/component_examples/component_example_registry.dart';

class MobileNavDrawer extends StatelessWidget {
  const MobileNavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            const _DrawerHandle(),
            const SizedBox(height: 8),
            // Quick link to Components overview
            ListTile(
              leading: const Icon(Icons.grid_view),
              title: const Text('Components'),
              onTap: () {
                Navigator.of(context).pop();
                context.go(AppRoutes.components);
              },
            ),
            // Categorized component navigation
            const _ComponentNavSection(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.code),
              title: const Text('GitHub'),
              onTap: () async {
                Navigator.of(context).pop();
                await _launchUrl(AppConstants.shadcnUiGithubUrl);
              },
            ),
            ListTile(
              leading: const Icon(Icons.library_books),
              title: const Text('pub.dev'),
              onTap: () async {
                Navigator.of(context).pop();
                await _launchUrl(AppConstants.shadcnUiPubUrl);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _ComponentNavSection extends StatelessWidget {
  const _ComponentNavSection();

  @override
  Widget build(BuildContext context) {
    // Build a categorized map of only implemented components (registered in the registry)
    final entries = ComponentCategories.categories.entries
        .map((entry) {
          final implemented = entry.value
              .where((c) => ComponentExampleRegistry.hasExample(c.name))
              .toList();
          return MapEntry(entry.key, implemented);
        })
        .where((e) => e.value.isNotEmpty)
        .toList();

    if (entries.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Browse by category',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          ...entries.map(
            (entry) => _CategoryExpansionTile(
              category: entry.key,
              components: entry.value.map((c) => c.name).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryExpansionTile extends StatelessWidget {
  final String category;
  final List<String> components;
  const _CategoryExpansionTile({
    required this.category,
    required this.components,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(category),
        childrenPadding: const EdgeInsets.only(left: 8),
        children: components
            .map((name) => _ComponentListTile(componentName: name))
            .toList(),
      ),
    );
  }
}

class _ComponentListTile extends StatelessWidget {
  final String componentName;
  const _ComponentListTile({required this.componentName});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      minLeadingWidth: 0,
      leading: const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
      title: Text(componentName, overflow: TextOverflow.ellipsis),
      onTap: () {
        Navigator.of(context).pop();
        context.go(AppRoutes.componentRoute(componentName));
      },
    );
  }
}

class _DrawerHandle extends StatelessWidget {
  const _DrawerHandle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Theme.of(context).dividerColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}
