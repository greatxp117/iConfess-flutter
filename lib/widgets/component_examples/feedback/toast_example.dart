import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../component_example_interface.dart' as example_interface;

class ToastExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'Toast';

  @override
  String get description => 'Temporary notification messages';

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.basic;

  @override
  String get category => 'Feedback';

  @override
  List<String> get tags => ['feedback', 'toast', 'notification', 'message'];

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
    'Simple': example_interface.ComponentVariant(
      previewBuilder: (context) => const SimpleToastExample(),
      code: _getSimpleCode(),
    ),
    'With Title': example_interface.ComponentVariant(
      previewBuilder: (context) => const WithTitleToastExample(),
      code: _getWithTitleCode(),
    ),
    'With Action': example_interface.ComponentVariant(
      previewBuilder: (context) => const WithActionToastExample(),
      code: _getWithActionCode(),
    ),
    'Destructive': example_interface.ComponentVariant(
      previewBuilder: (context) => const DestructiveToastExample(),
      code: _getDestructiveCode(),
    ),
    'Scheduled': example_interface.ComponentVariant(
      previewBuilder: (context) => const ScheduledToastExample(),
      code: _getScheduledCode(),
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

  String _getSimpleCode() {
    return '''class SimpleToastExample extends StatelessWidget {
  const SimpleToastExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Simple Toast',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A basic toast with just a description message.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadButton.outline(
          child: const Text('Show Simple Toast'),
          onPressed: () {
            ShadToaster.of(context).show(
              const ShadToast(
                              ),
            );
          },
        ),
      ],
    );
  }
}''';
  }

  String _getWithTitleCode() {
    return '''class WithTitleToastExample extends StatelessWidget {
  const WithTitleToastExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Toast with Title',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A toast with both title and description for more detailed messages.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadButton.outline(
          child: const Text('Show Title Toast'),
          onPressed: () {
            ShadToaster.of(context).show(
              const ShadToast(
                title: Text('Uh oh! Something went wrong'),
                              ),
            );
          },
        ),
      ],
    );
  }
}''';
  }

  String _getWithActionCode() {
    return '''class WithActionToastExample extends StatelessWidget {
  const WithActionToastExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Toast with Action',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A toast with an action button for user interaction.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadButton.outline(
          child: const Text('Show Action Toast'),
          onPressed: () {
            ShadToaster.of(context).show(
              ShadToast(
                title: const Text('Action Required'),
                                action: ShadButton.outline(
                  child: const Text('Review'),
                  onPressed: () => ShadToaster.of(context).hide(),
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

  String _getDestructiveCode() {
    return '''class DestructiveToastExample extends StatelessWidget {
  const DestructiveToastExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Destructive Toast',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A destructive toast with error styling and custom action button.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadButton.outline(
          child: const Text('Show Destructive Toast'),
          onPressed: () {
            final theme = Theme.of(context);
            
            ShadToaster.of(context).show(
              ShadToast.destructive(
                title: const Text('Delete Failed'),
                                action: ShadButton.destructive(
                  child: const Text('Retry'),
                  decoration: ShadDecoration(
                    border: ShadBorder.all(
                      color: theme.colorScheme.onError,
                      width: 1,
                    ),
                  ),
                  onPressed: () => ShadToaster.of(context).hide(),
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

  String _getScheduledCode() {
    return '''class ScheduledToastExample extends StatelessWidget {
  const ScheduledToastExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Scheduled Toast',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A toast for scheduled events with an undo action.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadButton.outline(
          child: const Text('Add to calendar'),
          onPressed: () {
            ShadToaster.of(context).show(
              ShadToast(
                title: const Text('Scheduled: Catch up'),
                February 10, 2023 at 5:57 PM'),
                action: ShadButton.outline(
                  child: const Text('Undo'),
                  onPressed: () => ShadToaster.of(context).hide(),
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
class SimpleToastExample extends StatelessWidget {
  const SimpleToastExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Simple Toast',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A basic toast with just a description message.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadButton.outline(
          child: const Text('Show Simple Toast'),
          onPressed: () {
            ShadToaster.of(context).show(
              const ShadToast(),
            );
          },
        ),
      ],
    );
  }
}

class WithTitleToastExample extends StatelessWidget {
  const WithTitleToastExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Toast with Title',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A toast with both title and description for more detailed messages.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadButton.outline(
          child: const Text('Show Title Toast'),
          onPressed: () {
            ShadToaster.of(context).show(
              const ShadToast(
                title: Text('Uh oh! Something went wrong'),
              ),
            );
          },
        ),
      ],
    );
  }
}

class WithActionToastExample extends StatelessWidget {
  const WithActionToastExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Toast with Action',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A toast with an action button for user interaction.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadButton.outline(
          child: const Text('Show Action Toast'),
          onPressed: () {
            ShadToaster.of(context).show(
              ShadToast(
                title: const Text('Action Required'),
                description: const Text(
                  'Please review and confirm your changes',
                ),
                action: ShadButton.outline(
                  child: const Text('Review'),
                  onPressed: () => ShadToaster.of(context).hide(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class DestructiveToastExample extends StatelessWidget {
  const DestructiveToastExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Destructive Toast',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A destructive toast with error styling and custom action button.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadButton.outline(
          child: const Text('Show Destructive Toast'),
          onPressed: () {
            final theme = Theme.of(context);

            ShadToaster.of(context).show(
              ShadToast.destructive(
                title: const Text('Delete Failed'),
                description: const Text(
                  'Could not delete the item. Please try again.',
                ),
                action: ShadButton.destructive(
                  decoration: ShadDecoration(
                    border: ShadBorder.all(
                      color: theme.colorScheme.onError,
                      width: 1,
                    ),
                  ),
                  onPressed: () => ShadToaster.of(context).hide(),
                  child: const Text('Retry'),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class ScheduledToastExample extends StatelessWidget {
  const ScheduledToastExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Scheduled Toast',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A toast for scheduled events with an undo action.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadButton.outline(
          child: const Text('Add to calendar'),
          onPressed: () {
            ShadToaster.of(context).show(
              ShadToast(
                title: const Text('Scheduled: Catch up'),
                description: const Text('10, 2023 at 5:57 PM'),
                action: ShadButton.outline(
                  child: const Text('Undo'),
                  onPressed: () => ShadToaster.of(context).hide(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
