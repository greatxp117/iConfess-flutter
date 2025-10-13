import 'package:flutter/material.dart';

/// Reusable tab bar for component detail screens
class ComponentTabBar extends StatelessWidget {
  final String selectedTab;
  final Function(String) onTabSelected;
  final List<String> tabs;

  const ComponentTabBar({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
    this.tabs = const ['Preview', 'Code'],
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...tabs.map((tab) => _buildTab(context, tab)),
      ],
    );
  }

  Widget _buildTab(BuildContext context, String tab) {
    final isSelected = selectedTab == tab;
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: InkWell(
        onTap: () => onTabSelected(tab),
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            tab,
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
