import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../component_categories.dart';
import '../../routes/go_router_config.dart';

/// Reusable sidebar widget for component navigation
class ComponentSidebar extends StatelessWidget {
  final String selectedComponent;
  final ScrollController scrollController;
  final VoidCallback? onComponentsPressed;
  final Function(String) onComponentSelected;

  const ComponentSidebar({
    super.key,
    required this.selectedComponent,
    required this.scrollController,
    this.onComponentsPressed,
    required this.onComponentSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Get all components from ComponentCategories
    final allComponents = ComponentCategories.allComponents;
    final implementedComponentNames = allComponents
        .where((component) => component.status == ComponentStatus.implemented)
        .map((component) => component.name)
        .toList();

    // Sort alphabetically
    implementedComponentNames.sort();

    return Container(
      width: 240,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
        ),
        child: ListView(
          key: const PageStorageKey<String>(
            'sidebar_scroll_position',
          ), // Native scroll persistence
          controller: scrollController,
          padding: const EdgeInsets.all(16),
          children: [
            _buildSidebarItem(
              context,
              'Components',
              false,
              onTap:
                  onComponentsPressed ??
                  () {
                    context.go(AppRoutes.components);
                  },
            ),
            const SizedBox(height: 8),
            // Show only implemented components
            ...implementedComponentNames.map(
              (component) => _buildSidebarItem(
                context,
                component,
                component == selectedComponent,
                onTap: () {
                  onComponentSelected(component);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebarItem(
    BuildContext context,
    String title,
    bool isSelected, {
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: isSelected
              ? BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                )
              : null,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected ? null : Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }
}
