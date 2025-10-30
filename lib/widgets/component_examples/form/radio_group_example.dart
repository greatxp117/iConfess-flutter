import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../component_example_interface.dart' as example_interface;

class RadioGroupExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'RadioGroup';

  @override
  String get description =>
      'Radio group component for single selection from multiple options';

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.intermediate;

  @override
  String get category => 'Form';

  @override
  List<String> get tags => ['form', 'selection', 'radio', 'input'];

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
        'Basic': example_interface.ComponentVariant(
          previewBuilder: (context) => const BasicRadioGroupExample(),
          code: _getBasicCode(),
        ),
        'Form Field': example_interface.ComponentVariant(
          previewBuilder: (context) => const FormFieldRadioGroupExample(),
          code: _getFormFieldCode(),
        ),
        'Custom': example_interface.ComponentVariant(
          previewBuilder: (context) => const CustomRadioGroupExample(),
          code: _getCustomCode(),
        ),
        'Interactive': example_interface.ComponentVariant(
          previewBuilder: (context) => const InteractiveRadioGroupExample(),
          code: _getInteractiveCode(),
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
    return '''class BasicRadioGroupExample extends StatefulWidget {
  const BasicRadioGroupExample({super.key});

  @override
  State<BasicRadioGroupExample> createState() => _BasicRadioGroupExampleState();
}

class _BasicRadioGroupExampleState extends State<BasicRadioGroupExample> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Basic Radio Group',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Simple radio group with string values.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadRadioGroup<String>(
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
          },
          items: [
            ShadRadio(
              value: 'default',
              label: const Text('Default'),
            ),
            ShadRadio(
              value: 'comfortable',
              label: const Text('Comfortable'),
            ),
            ShadRadio(
              value: 'nothing',
              label: const Text('Nothing'),
            ),
          ],
        ),
      ],
    );
  }
}''';
  }

  String _getFormFieldCode() {
    return '''enum NotifyAbout {
  all,
  mentions,
  nothing;

  String get message {
    return switch (this) {
      all => 'All new messages',
      mentions => 'Direct messages and mentions',
      nothing => 'Nothing',
    };
  }
}

class FormFieldRadioGroupExample extends StatelessWidget {
  const FormFieldRadioGroupExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Radio Group Form Field',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Radio group with form validation and enum values.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadRadioGroupFormField<NotifyAbout>(
          label: const Text('Notify me about'),
          items: NotifyAbout.values.map(
            (e) => ShadRadio(
              value: e,
              label: Text(e.message),
            ),
          ),
          validator: (v) {
            if (v == null) {
              return 'You need to select a notification type.';
            }
            return null;
          },
        ),
      ],
    );
  }
}''';
  }

  String _getCustomCode() {
    return '''class CustomRadioGroupExample extends StatefulWidget {
  const CustomRadioGroupExample({super.key});

  @override
  State<CustomRadioGroupExample> createState() => _CustomRadioGroupExampleState();
}

class _CustomRadioGroupExampleState extends State<CustomRadioGroupExample> {
  String? selectedTheme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Custom Radio Group',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Radio group with custom styling and layout.',
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
          child: ShadRadioGroup<String>(
            onChanged: (value) {
              setState(() {
                selectedTheme = value;
              });
            },
            items: [
              ShadRadio(
                value: 'light',
                label: const Text('Light Theme'),
              ),
              ShadRadio(
                value: 'dark',
                label: const Text('Dark Theme'),
              ),
              ShadRadio(
                value: 'system',
                label: const Text('System Default'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}''';
  }

  String _getInteractiveCode() {
    return '''class InteractiveRadioGroupExample extends StatefulWidget {
  const InteractiveRadioGroupExample({super.key});

  @override
  State<InteractiveRadioGroupExample> createState() => _InteractiveRadioGroupExampleState();
}

class _InteractiveRadioGroupExampleState extends State<InteractiveRadioGroupExample> {
  String? selectedSize;
  bool showCustomSize = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Interactive Radio Group',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Radio group with dynamic options and state management.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadRadioGroup<String>(
          onChanged: (value) {
            setState(() {
              selectedSize = value;
              showCustomSize = value == 'custom';
            });
          },
          items: [
            ShadRadio(
              value: 'small',
              label: const Text('Small'),
            ),
            ShadRadio(
              value: 'medium',
              label: const Text('Medium'),
            ),
            ShadRadio(
              value: 'large',
              label: const Text('Large'),
            ),
            ShadRadio(
              value: 'custom',
              label: const Text('Custom'),
            ),
          ],
        ),
        if (showCustomSize) ...[
          const SizedBox(height: 16),
          const ShadInput(
            placeholder: Text('Enter custom size'),
          ),
        ],
      ],
    );
  }
}''';
  }
}

// Widget implementations
class BasicRadioGroupExample extends StatefulWidget {
  const BasicRadioGroupExample({super.key});

  @override
  State<BasicRadioGroupExample> createState() => _BasicRadioGroupExampleState();
}

class _BasicRadioGroupExampleState extends State<BasicRadioGroupExample> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Basic Radio Group',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Simple radio group with string values.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadRadioGroup<String>(
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
          },
          items: [
            ShadRadio(
              value: 'default',
              label: const Text('Default'),
            ),
            ShadRadio(
              value: 'comfortable',
              label: const Text('Comfortable'),
            ),
            ShadRadio(
              value: 'nothing',
              label: const Text('Nothing'),
            ),
          ],
        ),
      ],
    );
  }
}

class FormFieldRadioGroupExample extends StatelessWidget {
  const FormFieldRadioGroupExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Radio Group Form Field',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Radio group with form validation and enum values.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadRadioGroupFormField<NotifyAbout>(
          label: const Text('Notify me about'),
          items: NotifyAbout.values.map(
            (e) => ShadRadio(
              value: e,
              label: Text(e.message),
            ),
          ),
          validator: (v) {
            if (v == null) {
              return 'You need to select a notification type.';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class CustomRadioGroupExample extends StatefulWidget {
  const CustomRadioGroupExample({super.key});

  @override
  State<CustomRadioGroupExample> createState() =>
      _CustomRadioGroupExampleState();
}

class _CustomRadioGroupExampleState extends State<CustomRadioGroupExample> {
  String? selectedTheme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Custom Radio Group',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Radio group with custom styling and layout.',
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
          child: ShadRadioGroup<String>(
            onChanged: (value) {
              setState(() {
                selectedTheme = value;
              });
            },
            items: [
              ShadRadio(
                value: 'light',
                label: const Text('Light Theme'),
              ),
              ShadRadio(
                value: 'dark',
                label: const Text('Dark Theme'),
              ),
              ShadRadio(
                value: 'system',
                label: const Text('System Default'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InteractiveRadioGroupExample extends StatefulWidget {
  const InteractiveRadioGroupExample({super.key});

  @override
  State<InteractiveRadioGroupExample> createState() =>
      _InteractiveRadioGroupExampleState();
}

class _InteractiveRadioGroupExampleState
    extends State<InteractiveRadioGroupExample> {
  String? selectedSize;
  bool showCustomSize = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Interactive Radio Group',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Radio group with dynamic options and state management.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadRadioGroup<String>(
          onChanged: (value) {
            setState(() {
              selectedSize = value;
              showCustomSize = value == 'custom';
            });
          },
          items: [
            ShadRadio(
              value: 'small',
              label: const Text('Small'),
            ),
            ShadRadio(
              value: 'medium',
              label: const Text('Medium'),
            ),
            ShadRadio(
              value: 'large',
              label: const Text('Large'),
            ),
            ShadRadio(
              value: 'custom',
              label: const Text('Custom'),
            ),
          ],
        ),
        if (showCustomSize) ...[
          const SizedBox(height: 16),
          const ShadInput(
            placeholder: Text('Enter custom size'),
          ),
        ],
      ],
    );
  }
}

// Enum for form field example
enum NotifyAbout {
  all,
  mentions,
  nothing;

  String get message {
    return switch (this) {
      all => 'All new messages',
      mentions => 'Direct messages and mentions',
      nothing => 'Nothing',
    };
  }
}
