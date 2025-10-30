import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../component_example_interface.dart' as example_interface;

class TextareaExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'Textarea';

  @override
  String get description => 'Multi-line text input field';

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.basic;

  @override
  String get category => 'Form';

  @override
  List<String> get tags => ['form', 'textarea', 'text', 'input'];

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
        'Basic': example_interface.ComponentVariant(
          previewBuilder: (context) => const BasicTextareaExample(),
          code: _getBasicCode(),
        ),
        'Form Field': example_interface.ComponentVariant(
          previewBuilder: (context) => const FormFieldTextareaExample(),
          code: _getFormFieldCode(),
        ),
        'Custom Textarea': example_interface.ComponentVariant(
          previewBuilder: (context) => const CustomTextareaExample(),
          code: _getCustomCode(),
        ),
        'Auto-resize': example_interface.ComponentVariant(
          previewBuilder: (context) => const AutoResizeTextareaExample(),
          code: _getAutoResizeCode(),
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
    return '''class BasicTextareaExample extends StatelessWidget {
  const BasicTextareaExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Basic Textarea',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A basic textarea with placeholder text.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: const ShadTextarea(
            placeholder: Text('Type your message here'),
          ),
        ),
      ],
    );
  }
}''';
  }

  String _getFormFieldCode() {
    return '''class FormFieldTextareaExample extends StatelessWidget {
  const FormFieldTextareaExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Form Field Textarea',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A textarea integrated as a form field with validation.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ShadTextareaFormField(
            id: 'bio',
            label: const Text('Bio'),
            placeholder: const Text('Tell us a little bit about yourself'),
            description:
                const Text('You can @mention other users and organizations.'),
            validator: (v) {
              if (v.length < 10) {
                return 'Bio must be at least 10 characters.';
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
    return '''class CustomTextareaExample extends StatelessWidget {
  const CustomTextareaExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Custom Textarea',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A textarea with custom styling and constraints.',
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
            constraints: const BoxConstraints(
              maxWidth: 400,
              minHeight: 120,
              maxHeight: 200,
            ),
            child: const ShadTextarea(
              placeholder: Text('Enter your detailed feedback here...'),
            ),
          ),
        ),
      ],
    );
  }
}''';
  }

  String _getAutoResizeCode() {
    return '''class AutoResizeTextareaExample extends StatefulWidget {
  const AutoResizeTextareaExample({super.key});

  @override
  State<AutoResizeTextareaExample> createState() => _AutoResizeTextareaExampleState();
}

class _AutoResizeTextareaExampleState extends State<AutoResizeTextareaExample> {
  String content = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Auto-resize Textarea',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A textarea that automatically resizes with content.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ShadTextarea(
            placeholder: const Text('Start typing to see auto-resize...'),
            onChanged: (value) => setState(() => content = value),
          ),
        ),
        if (content.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            'Character count: updated',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ],
    );
  }
}''';
  }
}

// Widget implementations
class BasicTextareaExample extends StatelessWidget {
  const BasicTextareaExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Basic Textarea',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A basic textarea with placeholder text.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: const ShadTextarea(
            placeholder: Text('Type your message here'),
          ),
        ),
      ],
    );
  }
}

class FormFieldTextareaExample extends StatelessWidget {
  const FormFieldTextareaExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Form Field Textarea',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A textarea integrated as a form field with validation.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ShadTextareaFormField(
            id: 'bio',
            label: const Text('Bio'),
            placeholder: const Text('Tell us a little bit about yourself'),
            description:
                const Text('You can @mention other users and organizations.'),
            validator: (v) {
              if (v.length < 10) {
                return 'Bio must be at least 10 characters.';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}

class CustomTextareaExample extends StatelessWidget {
  const CustomTextareaExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Custom Textarea',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A textarea with custom styling and constraints.',
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
            constraints: const BoxConstraints(
              maxWidth: 400,
              minHeight: 120,
              maxHeight: 200,
            ),
            child: const ShadTextarea(
              placeholder: Text('Enter your detailed feedback here...'),
            ),
          ),
        ),
      ],
    );
  }
}

class AutoResizeTextareaExample extends StatefulWidget {
  const AutoResizeTextareaExample({super.key});

  @override
  State<AutoResizeTextareaExample> createState() =>
      _AutoResizeTextareaExampleState();
}

class _AutoResizeTextareaExampleState extends State<AutoResizeTextareaExample> {
  String content = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Auto-resize Textarea',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A textarea that automatically resizes with content.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ShadTextarea(
            placeholder: const Text('Start typing to see auto-resize...'),
            onChanged: (value) => setState(() => content = value),
          ),
        ),
        if (content.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            'Character count: updated',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ],
    );
  }
}
