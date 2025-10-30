import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../component_example_interface.dart' as example_interface;

/// Alert component implementation using the new architecture
class AlertExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'Alert';

  @override
  String get description => 'Displays a callout for user attention.';

  @override
  String get category => 'Feedback & Overlays';

  @override
  List<String> get tags => ['notification', 'message', 'status'];

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.basic;

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
        'Default': example_interface.ComponentVariant(
          previewBuilder: (context) => _buildDefaultAlert(),
          code: _getDefaultCode(),
        ),
        'Destructive': example_interface.ComponentVariant(
          previewBuilder: (context) => _buildDestructiveAlert(),
          code: _getDestructiveCode(),
        ),
        'With Icon': example_interface.ComponentVariant(
          previewBuilder: (context) => _buildIconAlert(),
          code: _getIconCode(),
        ),
        'Custom Variants': example_interface.ComponentVariant(
          previewBuilder: (context) => _buildCustomAlerts(),
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

  Widget _buildDefaultAlert() {
    return const ShadAlert(
      title: Text('Heads up!'),
    );
  }

  Widget _buildDestructiveAlert() {
    return const ShadAlert.destructive(
      title: Text('Error'),
    );
  }

  Widget _buildIconAlert() {
    return const ShadAlert(
      icon: Icon(Icons.info_outline, size: 20),
      title: Text('Information'),
    );
  }

  Widget _buildCustomAlerts() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Warning alert
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            border: Border.all(color: Colors.orange.shade200),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.warning_amber,
                  color: Colors.orange.shade600, size: 20),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Warning',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 4),
                    Text(
                        'This action cannot be undone. Please proceed with caution.'),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Success alert
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            border: Border.all(color: Colors.green.shade200),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle_outline,
                  color: Colors.green.shade600, size: 20),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Success',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 4),
                    Text('Your changes have been saved successfully.'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getDefaultCode() {
    return '''// Default Alert
ShadAlert(
  title: const Text('Heads up!'),
  )''';
  }

  String _getDestructiveCode() {
    return '''// Destructive Alert
ShadAlert.destructive(
  title: const Text('Error'),
  )''';
  }

  String _getIconCode() {
    return '''// Alert with Icon
ShadAlert(
  icon: const Icon(Icons.info_outline, size: 20),
  title: const Text('Information'),
  )''';
  }

  String _getCustomCode() {
    return '''// Custom Warning Alert
Container(
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: Colors.orange.shade50,
    border: Border.all(color: Colors.orange.shade200),
    borderRadius: BorderRadius.circular(8),
  ),
  child: Row(
    children: [
      Icon(Icons.warning_amber, color: Colors.orange.shade600, size: 20),
      const SizedBox(width: 12),
      const Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Warning',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 4),
            Text('This action cannot be undone. Please proceed with caution.'),
          ],
        ),
      ),
    ],
  ),
)

// Custom Success Alert
Container(
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: Colors.green.shade50,
    border: Border.all(color: Colors.green.shade200),
    borderRadius: BorderRadius.circular(8),
  ),
  child: Row(
    children: [
      Icon(Icons.check_circle_outline, color: Colors.green.shade600, size: 20),
      const SizedBox(width: 12),
      const Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Success',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 4),
            Text('Your changes have been saved successfully.'),
          ],
        ),
      ),
    ],
  ),
)''';
  }
}
