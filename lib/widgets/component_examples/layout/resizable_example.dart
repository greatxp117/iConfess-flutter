import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../component_example_interface.dart' as example_interface;

class ResizableExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'Resizable';

  @override
  String get description =>
      'Resizable panels that can be dragged to adjust sizes';

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.intermediate;

  @override
  String get category => 'Layout';

  @override
  List<String> get tags => ['layout', 'resizable', 'panels', 'drag'];

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
        'Basic': example_interface.ComponentVariant(
          previewBuilder: (context) => const BasicResizableExample(),
          code: _getBasicCode(),
        ),
        'Vertical': example_interface.ComponentVariant(
          previewBuilder: (context) => const VerticalResizableExample(),
          code: _getVerticalCode(),
        ),
        'With Handle': example_interface.ComponentVariant(
          previewBuilder: (context) => const HandleResizableExample(),
          code: _getHandleCode(),
        ),
        'Custom Layout': example_interface.ComponentVariant(
          previewBuilder: (context) => const CustomLayoutExample(),
          code: _getCustomLayoutCode(),
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
    return '''class BasicResizableExample extends StatelessWidget {
  const BasicResizableExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Basic Resizable',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Nested resizable panels with size constraints.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colorScheme.outline,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ShadResizablePanelGroup(
                children: [
                  ShadResizablePanel(
                    id: 0,
                    defaultSize: .5,
                    minSize: .2,
                    maxSize: .8,
                    child: Center(
                      child: Text('One', style: theme.textTheme.titleLarge),
                    ),
                  ),
                  ShadResizablePanel(
                    id: 1,
                    defaultSize: .5,
                    child: ShadResizablePanelGroup(
                      axis: Axis.vertical,
                      children: [
                        ShadResizablePanel(
                          id: 0,
                          defaultSize: .3,
                          child: Center(
                              child: Text('Two', style: theme.textTheme.titleLarge)),
                        ),
                        ShadResizablePanel(
                          id: 1,
                          defaultSize: .7,
                          child: Align(
                              child: Text('Three', style: theme.textTheme.titleLarge)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}''';
  }

  String _getVerticalCode() {
    return '''class VerticalResizableExample extends StatelessWidget {
  const VerticalResizableExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Vertical Resizable',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Vertical resizable panels with header and footer.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colorScheme.outline,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ShadResizablePanelGroup(
                axis: Axis.vertical,
                children: [
                  ShadResizablePanel(
                    id: 0,
                    defaultSize: 0.3,
                    minSize: 0.1,
                    child: Center(
                      child: Text('Header', style: theme.textTheme.titleLarge),
                    ),
                  ),
                  ShadResizablePanel(
                    id: 1,
                    defaultSize: 0.7,
                    minSize: 0.1,
                    child: Center(
                      child: Text('Footer', style: theme.textTheme.titleLarge),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}''';
  }

  String _getHandleCode() {
    return '''class HandleResizableExample extends StatelessWidget {
  const HandleResizableExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Resizable with Handle',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Resizable panels with visible drag handles.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colorScheme.outline,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ShadResizablePanelGroup(
                showHandle: true,
                children: [
                  ShadResizablePanel(
                    id: 0,
                    defaultSize: .5,
                    minSize: .2,
                    child: Center(
                      child: Text('Sidebar', style: theme.textTheme.titleLarge),
                    ),
                  ),
                  ShadResizablePanel(
                    id: 1,
                    defaultSize: .5,
                    minSize: .2,
                    child: Center(
                      child: Text('Content', style: theme.textTheme.titleLarge),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}''';
  }

  String _getCustomLayoutCode() {
    return '''class CustomLayoutExample extends StatelessWidget {
  const CustomLayoutExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Custom Layout',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Complex resizable layout with multiple panels.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 250),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colorScheme.outline,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ShadResizablePanelGroup(
                showHandle: true,
                children: [
                  ShadResizablePanel(
                    id: 0,
                    defaultSize: .3,
                    minSize: .15,
                    child: Center(
                      child: Text('Navigation', style: theme.textTheme.titleLarge),
                    ),
                  ),
                  ShadResizablePanel(
                    id: 1,
                    defaultSize: .7,
                    child: ShadResizablePanelGroup(
                      axis: Axis.vertical,
                      children: [
                        ShadResizablePanel(
                          id: 0,
                          defaultSize: .6,
                          child: Center(
                            child: Text('Main Content', style: theme.textTheme.titleLarge),
                          ),
                        ),
                        ShadResizablePanel(
                          id: 1,
                          defaultSize: .4,
                          child: Center(
                            child:
                                Text('Details', style: theme.textTheme.titleLarge),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
class BasicResizableExample extends StatelessWidget {
  const BasicResizableExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Basic Resizable',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Nested resizable panels with size constraints.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colorScheme.outline,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ShadResizablePanelGroup(
                children: [
                  ShadResizablePanel(
                    id: 0,
                    defaultSize: .5,
                    minSize: .2,
                    maxSize: .8,
                    child: Center(
                      child: Text('One', style: theme.textTheme.titleLarge),
                    ),
                  ),
                  ShadResizablePanel(
                    id: 1,
                    defaultSize: .5,
                    child: ShadResizablePanelGroup(
                      axis: Axis.vertical,
                      children: [
                        ShadResizablePanel(
                          id: 0,
                          defaultSize: .3,
                          child: Center(
                              child: Text('Two',
                                  style: theme.textTheme.titleLarge)),
                        ),
                        ShadResizablePanel(
                          id: 1,
                          defaultSize: .7,
                          child: Align(
                              child: Text('Three',
                                  style: theme.textTheme.titleLarge)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class VerticalResizableExample extends StatelessWidget {
  const VerticalResizableExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Vertical Resizable',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Vertical resizable panels with header and footer.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colorScheme.outline,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ShadResizablePanelGroup(
                axis: Axis.vertical,
                children: [
                  ShadResizablePanel(
                    id: 0,
                    defaultSize: 0.3,
                    minSize: 0.1,
                    child: Center(
                      child: Text('Header', style: theme.textTheme.titleLarge),
                    ),
                  ),
                  ShadResizablePanel(
                    id: 1,
                    defaultSize: 0.7,
                    minSize: 0.1,
                    child: Center(
                      child: Text('Footer', style: theme.textTheme.titleLarge),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HandleResizableExample extends StatelessWidget {
  const HandleResizableExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Resizable with Handle',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Resizable panels with visible drag handles.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colorScheme.outline,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ShadResizablePanelGroup(
                showHandle: true,
                children: [
                  ShadResizablePanel(
                    id: 0,
                    defaultSize: .5,
                    minSize: .2,
                    child: Center(
                      child: Text('Sidebar', style: theme.textTheme.titleLarge),
                    ),
                  ),
                  ShadResizablePanel(
                    id: 1,
                    defaultSize: .5,
                    minSize: .2,
                    child: Center(
                      child: Text('Content', style: theme.textTheme.titleLarge),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomLayoutExample extends StatelessWidget {
  const CustomLayoutExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Custom Layout',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Complex resizable layout with multiple panels.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 250),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colorScheme.outline,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ShadResizablePanelGroup(
                showHandle: true,
                children: [
                  ShadResizablePanel(
                    id: 0,
                    defaultSize: .3,
                    minSize: .15,
                    child: Center(
                      child:
                          Text('Navigation', style: theme.textTheme.titleLarge),
                    ),
                  ),
                  ShadResizablePanel(
                    id: 1,
                    defaultSize: .7,
                    child: ShadResizablePanelGroup(
                      axis: Axis.vertical,
                      children: [
                        ShadResizablePanel(
                          id: 0,
                          defaultSize: .6,
                          child: Center(
                            child: Text('Main Content',
                                style: theme.textTheme.titleLarge),
                          ),
                        ),
                        ShadResizablePanel(
                          id: 1,
                          defaultSize: .4,
                          child: Center(
                            child: Text('Details',
                                style: theme.textTheme.titleLarge),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
