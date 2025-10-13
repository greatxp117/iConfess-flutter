import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../component_example_interface.dart' as example_interface;

class TimePickerExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'TimePicker';

  @override
  String get description => 'Time selection component with various options';

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.intermediate;

  @override
  String get category => 'Form';

  @override
  List<String> get tags => ['form', 'time', 'picker', 'input'];

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
        'Primary': example_interface.ComponentVariant(
          previewBuilder: (context) => const PrimaryTimePickerExample(),
          code: _getPrimaryCode(),
        ),
        'Form Field': example_interface.ComponentVariant(
          previewBuilder: (context) => const FormFieldTimePickerExample(),
          code: _getFormFieldCode(),
        ),
        'Period': example_interface.ComponentVariant(
          previewBuilder: (context) => const PeriodTimePickerExample(),
          code: _getPeriodCode(),
        ),
        'Custom Time Picker': example_interface.ComponentVariant(
          previewBuilder: (context) => const CustomTimePickerExample(),
          code: _getCustomCode(),
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

  String _getPrimaryCode() {
    return '''class PrimaryTimePickerExample extends StatelessWidget {
  const PrimaryTimePickerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Primary Time Picker',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A basic time picker with a clock icon.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: const ShadTimePicker(
            trailing: Padding(
              padding: EdgeInsets.only(left: 8, top: 14),
              child: Icon(LucideIcons.clock4),
            ),
          ),
        ),
      ],
    );
  }
}''';
  }

  String _getFormFieldCode() {
    return '''class FormFieldTimePickerExample extends StatelessWidget {
  const FormFieldTimePickerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Form Field Time Picker',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A time picker integrated as a form field with label and validation.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ShadTimePickerFormField(
            label: const Text('Pick a time'),
            onChanged: print,
                        validator: (v) => v == null ? 'A time is required' : null,
          ),
        ),
      ],
    );
  }
}''';
  }

  String _getPeriodCode() {
    return '''class PeriodTimePickerExample extends StatelessWidget {
  const PeriodTimePickerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Period Time Picker',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A time picker with AM/PM period selection.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ShadTimePickerFormField.period(
            label: const Text('Pick a time'),
            onChanged: print,
                        validator: (v) => v == null ? 'A time is required' : null,
          ),
        ),
      ],
    );
  }
}''';
  }

  String _getCustomCode() {
    return '''class CustomTimePickerExample extends StatelessWidget {
  const CustomTimePickerExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Custom Time Picker',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A time picker with custom styling and constraints.',
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
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: ShadTimePickerFormField(
              label: const Text('Meeting Time'),
                            onChanged: print,
              validator: (v) => v == null ? 'Please select a meeting time' : null,
            ),
          ),
        ),
      ],
    );
  }
}''';
  }
}

// Widget implementations
class PrimaryTimePickerExample extends StatelessWidget {
  const PrimaryTimePickerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Primary Time Picker',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A basic time picker with a clock icon.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: const ShadTimePicker(
            trailing: Padding(
              padding: EdgeInsets.only(left: 8, top: 14),
              child: Icon(LucideIcons.clock4),
            ),
          ),
        ),
      ],
    );
  }
}

class FormFieldTimePickerExample extends StatelessWidget {
  const FormFieldTimePickerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Form Field Time Picker',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A time picker integrated as a form field with label and validation.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ShadTimePickerFormField(
            label: const Text('Pick a time'),
            onChanged: print,
            validator: (v) => v == null ? 'A time is required' : null,
          ),
        ),
      ],
    );
  }
}

class PeriodTimePickerExample extends StatelessWidget {
  const PeriodTimePickerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Period Time Picker',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A time picker with AM/PM period selection.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ShadTimePickerFormField.period(
            label: const Text('Pick a time'),
            onChanged: print,
            validator: (v) => v == null ? 'A time is required' : null,
          ),
        ),
      ],
    );
  }
}

class CustomTimePickerExample extends StatelessWidget {
  const CustomTimePickerExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Custom Time Picker',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A time picker with custom styling and constraints.',
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
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: ShadTimePickerFormField(
              label: const Text('Meeting Time'),
              onChanged: print,
              validator: (v) =>
                  v == null ? 'Please select a meeting time' : null,
            ),
          ),
        ),
      ],
    );
  }
}
