import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../component_example_interface.dart' as example_interface;

/// Badge component implementation using the new architecture
class BadgeExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'Badge';

  @override
  String get description =>
      'Displays a badge or a component that looks like a badge.';

  @override
  String get category => 'Media & Content';

  @override
  List<String> get tags => ['label', 'status', 'count', 'indicator'];

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.basic;

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
        'Basic Variants': example_interface.ComponentVariant(
          previewBuilder: (context) => _buildBasicVariants(),
          code: _getBasicCode(),
        ),
        'With Icons': example_interface.ComponentVariant(
          previewBuilder: (context) => _buildIconBadges(),
          code: _getIconCode(),
        ),
        'Number Badges': example_interface.ComponentVariant(
          previewBuilder: (context) => _buildNumberBadges(),
          code: _getNumberCode(),
        ),
        'Custom Status': example_interface.ComponentVariant(
          previewBuilder: (context) => _buildCustomBadges(),
          code: _getCustomCode(),
        ),
      };

  @override
  Widget buildPreview(BuildContext context, [String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.previewBuilder(context) ?? const SizedBox();
  }

  @override
  String getCode([String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.code ?? '';
  }

  Widget _buildBasicVariants() {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShadBadge(child: Text('Default')),
        SizedBox(width: 8),
        ShadBadge.secondary(child: Text('Secondary')),
        SizedBox(width: 8),
        ShadBadge.destructive(child: Text('Destructive')),
        SizedBox(width: 8),
        ShadBadge.outline(child: Text('Outline')),
      ],
    );
  }

  Widget _buildIconBadges() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ShadBadge(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, size: 12),
              SizedBox(width: 4),
              Text('Featured'),
            ],
          ),
        ),
        const SizedBox(width: 8),
        ShadBadge.secondary(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              const Text('Online'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNumberBadges() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ShadBadge.destructive(child: Text('99+')),
        const SizedBox(width: 12),
        const ShadBadge(child: Text('3')),
        const SizedBox(width: 12),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(Icons.notifications_outlined,
                size: 24, color: Colors.grey.shade600),
            Positioned(
              top: -4,
              right: -4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  '5',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCustomBadges() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'Active',
            style: TextStyle(
              color: Colors.green.shade700,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.orange.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'Pending',
            style: TextStyle(
              color: Colors.orange.shade700,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.red.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'Inactive',
            style: TextStyle(
              color: Colors.red.shade700,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  String _getBasicCode() {
    return '''// Basic Badge Variants
ShadBadge(child: Text('Default'))
ShadBadge.secondary(child: Text('Secondary'))
ShadBadge.destructive(child: Text('Destructive'))
ShadBadge.outline(child: Text('Outline'))''';
  }

  String _getIconCode() {
    return '''// Badge with Icon
ShadBadge(
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.star, size: 12),
      SizedBox(width: 4),
      Text('Featured'),
    ],
  ),
)

// Status Indicator Badge
ShadBadge.secondary(
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
      ),
      SizedBox(width: 6),
      Text('Online'),
    ],
  ),
)''';
  }

  String _getNumberCode() {
    return '''// Number Badge
ShadBadge.destructive(child: Text('99+'))
ShadBadge(child: Text('3'))

// Notification Badge
Stack(
  clipBehavior: Clip.none,
  children: [
    Icon(Icons.notifications_outlined, size: 24),
    Positioned(
      top: -4,
      right: -4,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          '5',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ],
)''';
  }

  String _getCustomCode() {
    return '''// Custom Status Badges
Container(
  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  decoration: BoxDecoration(
    color: Colors.green.shade100,
    borderRadius: BorderRadius.circular(12),
  ),
  child: Text(
    'Active',
    style: TextStyle(
      color: Colors.green.shade700,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
  ),
)

Container(
  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  decoration: BoxDecoration(
    color: Colors.orange.shade100,
    borderRadius: BorderRadius.circular(12),
  ),
  child: Text(
    'Pending',
    style: TextStyle(
      color: Colors.orange.shade700,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
  ),
)''';
  }
}
