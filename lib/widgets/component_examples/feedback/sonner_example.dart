import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'dart:math';
import '../component_example_interface.dart' as example_interface;

class SonnerExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'Sonner';

  @override
  String get description => 'Toast notification functionality';

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.intermediate;

  @override
  String get category => 'Feedback';

  @override
  List<String> get tags => ['feedback', 'sonner', 'toast', 'notification'];

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
        'Toast': example_interface.ComponentVariant(
          previewBuilder: (context) => const ToastSonnerExample(),
          code: _getToastCode(),
        ),
        'Success': example_interface.ComponentVariant(
          previewBuilder: (context) => const SuccessSonnerExample(),
          code: _getSuccessCode(),
        ),
        'Error': example_interface.ComponentVariant(
          previewBuilder: (context) => const ErrorSonnerExample(),
          code: _getErrorCode(),
        ),
        'Custom Sonner': example_interface.ComponentVariant(
          previewBuilder: (context) => const CustomSonnerExample(),
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

  String _getToastCode() {
    return '''class ToastSonnerExample extends StatelessWidget {
  const ToastSonnerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Sonner Toast',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A toast notification with timestamp and undo action.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadButton.outline(
          child: const Text('Show Toast'),
          onPressed: () {
            final sonner = ShadSonner.of(context);
            final id = Random().nextInt(1000);
            sonner.show(
              ShadToast(
                id: id,
                title: const Text('Event has been created'),
                                action: ShadButton(
                  child: const Text('Undo'),
                  onPressed: () => sonner.hide(id),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}''';
  }

  String _getSuccessCode() {
    return '''class SuccessSonnerExample extends StatelessWidget {
  const SuccessSonnerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Success Toast',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A success notification with custom styling.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadButton.outline(
          child: const Text('Show Success Toast'),
          onPressed: () {
            final sonner = ShadSonner.of(context);
            final id = Random().nextInt(1000);
            sonner.show(
              ShadToast(
                id: id,
                title: const Text('Success!'),
                                action: ShadButton(
                  child: const Text('View'),
                  onPressed: () => sonner.hide(id),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}''';
  }

  String _getErrorCode() {
    return '''class ErrorSonnerExample extends StatelessWidget {
  const ErrorSonnerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Error Toast',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'An error notification with retry action.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadButton.outline(
          child: const Text('Show Error Toast'),
          onPressed: () {
            final sonner = ShadSonner.of(context);
            final id = Random().nextInt(1000);
            sonner.show(
              ShadToast.destructive(
                id: id,
                title: const Text('Error'),
                                action: ShadButton.destructive(
                  child: const Text('Retry'),
                  onPressed: () => sonner.hide(id),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}''';
  }

  String _getCustomCode() {
    return '''class CustomSonnerExample extends StatelessWidget {
  const CustomSonnerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Custom Sonner',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A custom sonner with multiple actions.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadButton.outline(
          child: const Text('Show Custom Toast'),
          onPressed: () {
            final sonner = ShadSonner.of(context);
            final id = Random().nextInt(1000);
            final now = DateTime.now();
            sonner.show(
              ShadToast(
                id: id,
                title: const Text('File Upload'),
                                action: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShadButton.outline(
                      child: const Text('Download'),
                      onPressed: () => sonner.hide(id),
                    ),
                    const SizedBox(width: 8),
                    ShadButton(
                      child: const Text('Share'),
                      onPressed: () => sonner.hide(id),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}''';
  }
}

// Widget implementations
class ToastSonnerExample extends StatelessWidget {
  const ToastSonnerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Sonner Toast',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A toast notification with timestamp and undo action.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadButton.outline(
          child: const Text('Show Toast'),
          onPressed: () {
            final sonner = ShadSonner.of(context);
            final id = Random().nextInt(1000);
            sonner.show(
              ShadToast(
                id: id,
                title: const Text('Event has been created'),
                action: ShadButton(
                  child: const Text('Undo'),
                  onPressed: () => sonner.hide(id),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class SuccessSonnerExample extends StatelessWidget {
  const SuccessSonnerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Success Toast',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A success notification with custom styling.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadButton.outline(
          child: const Text('Show Success Toast'),
          onPressed: () {
            final sonner = ShadSonner.of(context);
            final id = Random().nextInt(1000);
            sonner.show(
              ShadToast(
                id: id,
                title: const Text('Success!'),
                description:
                    const Text('Your changes have been saved successfully.'),
                action: ShadButton(
                  child: const Text('View'),
                  onPressed: () => sonner.hide(id),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class ErrorSonnerExample extends StatelessWidget {
  const ErrorSonnerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Error Toast',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'An error notification with retry action.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadButton.outline(
          child: const Text('Show Error Toast'),
          onPressed: () {
            final sonner = ShadSonner.of(context);
            final id = Random().nextInt(1000);
            sonner.show(
              ShadToast.destructive(
                id: id,
                title: const Text('Error'),
                description:
                    const Text('Failed to save changes. Please try again.'),
                action: ShadButton.destructive(
                  child: const Text('Retry'),
                  onPressed: () => sonner.hide(id),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class CustomSonnerExample extends StatelessWidget {
  const CustomSonnerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Custom Sonner',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A custom sonner with multiple actions.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadButton.outline(
          child: const Text('Show Custom Toast'),
          onPressed: () {
            final sonner = ShadSonner.of(context);
            final id = Random().nextInt(1000);
            sonner.show(
              ShadToast(
                id: id,
                title: const Text('File Upload'),
                action: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShadButton.outline(
                      child: const Text('Download'),
                      onPressed: () => sonner.hide(id),
                    ),
                    const SizedBox(width: 8),
                    ShadButton(
                      child: const Text('Share'),
                      onPressed: () => sonner.hide(id),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
