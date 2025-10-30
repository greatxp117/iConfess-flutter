import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../component_example_interface.dart' as example_interface;

class SwitchExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'Switch';

  @override
  String get description => 'Toggle control for boolean values';

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.basic;

  @override
  String get category => 'Form';

  @override
  List<String> get tags => ['form', 'switch', 'toggle', 'boolean'];

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
        'Basic': example_interface.ComponentVariant(
          previewBuilder: (context) => const BasicSwitchExample(),
          code: _getBasicCode(),
        ),
        'Form Field': example_interface.ComponentVariant(
          previewBuilder: (context) => const FormFieldSwitchExample(),
          code: _getFormFieldCode(),
        ),
        'Custom Switch': example_interface.ComponentVariant(
          previewBuilder: (context) => const CustomSwitchExample(),
          code: _getCustomCode(),
        ),
        'Multiple Switches': example_interface.ComponentVariant(
          previewBuilder: (context) => const MultipleSwitchesExample(),
          code: _getMultipleCode(),
        ),
      };

  @override
  Widget buildPreview(BuildContext context, [String? variantKey]) {
    final key = variantKey ?? variants.keys.first;
    return variants[key]!.previewBuilder(context);
  }

  @override
  String getCode([String? variantKey]) {
    final key = variantKey ?? variants.keys.first;
    return variants[key]!.code;
  }

  String _getBasicCode() {
    return '''class BasicSwitchExample extends StatefulWidget {
  const BasicSwitchExample({super.key});

  @override
  State<BasicSwitchExample> createState() => _BasicSwitchExampleState();
}

class _BasicSwitchExampleState extends State<BasicSwitchExample> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Basic Switch',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A basic switch with label for toggling features.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadSwitch(
          value: value,
          onChanged: (v) => setState(() => value = v),
          label: const Text('Airplane Mode'),
        ),
      ],
    );
  }
}''';
  }

  String _getFormFieldCode() {
    return '''class FormFieldSwitchExample extends StatelessWidget {
  const FormFieldSwitchExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Form Field Switch',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A switch integrated as a form field with validation.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ShadSwitchFormField(
            id: 'terms',
            initialValue: false,
            inputLabel: const Text('I accept the terms and conditions'),
            onChanged: (v) {},
            inputSublabel: const Text('You agree to our Terms and Conditions'),
            validator: (v) {
              if (!v) {
                return 'You must accept the terms and conditions';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}''';
  }

  String _getCustomCode() {
    return '''class CustomSwitchExample extends StatefulWidget {
  const CustomSwitchExample({super.key});

  @override
  State<CustomSwitchExample> createState() => _CustomSwitchExampleState();
}

class _CustomSwitchExampleState extends State<CustomSwitchExample> {
  bool darkMode = false;
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Custom Switch',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A switch with custom styling and layout.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: theme.colorScheme.outline),
          ),
          child: Column(
            children: [
              ShadSwitch(
                value: darkMode,
                onChanged: (v) => setState(() => darkMode = v),
                label: const Text('Dark Mode'),
              ),
              const SizedBox(height: 12),
              ShadSwitch(
                value: notifications,
                onChanged: (v) => setState(() => notifications = v),
                label: const Text('Push Notifications'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}''';
  }

  String _getMultipleCode() {
    return '''class MultipleSwitchesExample extends StatefulWidget {
  const MultipleSwitchesExample({super.key});

  @override
  State<MultipleSwitchesExample> createState() => _MultipleSwitchesExampleState();
}

class _MultipleSwitchesExampleState extends State<MultipleSwitchesExample> {
  final Map<String, bool> settings = {
    'Wi-Fi': true,
    'Bluetooth': false,
    'Location': true,
    'Notifications': false,
    'Auto-update': true,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Multiple Switches',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Multiple switches with different states and labels.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Column(
            children: settings.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: ShadSwitch(
                  value: entry.value,
                  onChanged: (v) => setState(() => settings[entry.key] = v),
                  label: Text(entry.key),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}''';
  }
}

// Widget implementations
class BasicSwitchExample extends StatefulWidget {
  const BasicSwitchExample({super.key});

  @override
  State<BasicSwitchExample> createState() => _BasicSwitchExampleState();
}

class _BasicSwitchExampleState extends State<BasicSwitchExample> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Basic Switch',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A basic switch with label for toggling features.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadSwitch(
          value: value,
          onChanged: (v) => setState(() => value = v),
          label: const Text('Airplane Mode'),
        ),
      ],
    );
  }
}

class FormFieldSwitchExample extends StatelessWidget {
  const FormFieldSwitchExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Form Field Switch',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A switch integrated as a form field with validation.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ShadSwitchFormField(
            id: 'terms',
            initialValue: false,
            inputLabel: const Text('I accept the terms and conditions'),
            onChanged: (v) {},
            inputSublabel: const Text('You agree to our Terms and Conditions'),
            validator: (v) {
              if (!v) {
                return 'You must accept the terms and conditions';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}

class CustomSwitchExample extends StatefulWidget {
  const CustomSwitchExample({super.key});

  @override
  State<CustomSwitchExample> createState() => _CustomSwitchExampleState();
}

class _CustomSwitchExampleState extends State<CustomSwitchExample> {
  bool darkMode = false;
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Custom Switch',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A switch with custom styling and layout.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: theme.colorScheme.outline),
          ),
          child: Column(
            children: [
              ShadSwitch(
                value: darkMode,
                onChanged: (v) => setState(() => darkMode = v),
                label: const Text('Dark Mode'),
              ),
              const SizedBox(height: 12),
              ShadSwitch(
                value: notifications,
                onChanged: (v) => setState(() => notifications = v),
                label: const Text('Push Notifications'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MultipleSwitchesExample extends StatefulWidget {
  const MultipleSwitchesExample({super.key});

  @override
  State<MultipleSwitchesExample> createState() =>
      _MultipleSwitchesExampleState();
}

class _MultipleSwitchesExampleState extends State<MultipleSwitchesExample> {
  final Map<String, bool> settings = {
    'Wi-Fi': true,
    'Bluetooth': false,
    'Location': true,
    'Notifications': false,
    'Auto-update': true,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Multiple Switches',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Multiple switches with different states and labels.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Column(
            children: settings.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: ShadSwitch(
                  value: entry.value,
                  onChanged: (v) => setState(() => settings[entry.key] = v),
                  label: Text(entry.key),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
