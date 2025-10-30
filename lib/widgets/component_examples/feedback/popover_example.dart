import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../component_example_interface.dart' as example_interface;

/// Popover component implementation using the new architecture
class PopoverExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'Popover';

  @override
  String get description =>
      'A floating panel component that appears over other content to display additional information, controls, or interactive elements without navigating away from the current context.';

  @override
  String get category => 'Feedback';

  @override
  List<String> get tags => ['popover', 'overlay', 'floating', 'modal'];

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.intermediate;

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
        'Basic Popover': example_interface.ComponentVariant(
          previewBuilder: (context) => const BasicPopoverExample(),
          code: _getBasicCode(),
        ),
        'Form Popover': example_interface.ComponentVariant(
          previewBuilder: (context) => const FormPopoverExample(),
          code: _getFormCode(),
        ),
        'Custom Popover': example_interface.ComponentVariant(
          previewBuilder: (context) => const CustomPopoverExample(),
          code: _getCustomCode(),
        ),
        'Interactive Popover': example_interface.ComponentVariant(
          previewBuilder: (context) => const InteractivePopoverExample(),
          code: _getInteractiveCode(),
        ),
      };

  @override
  Widget buildPreview(BuildContext context, [String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.previewBuilder(context) ?? const BasicPopoverExample();
  }

  @override
  String getCode([String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.code ?? _getBasicCode();
  }

  // Code for basic popover
  String _getBasicCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Basic Popover
class BasicPopoverExample extends StatefulWidget {
  @override
  State<BasicPopoverExample> createState() => _BasicPopoverExampleState();
}

class _BasicPopoverExampleState extends State<BasicPopoverExample> {
  final popoverController = ShadPopoverController();

  @override
  void dispose() {
    popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadPopover(
      controller: popoverController,
      popover: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: const Text('This is a basic popover content.'),
      ),
      child: ShadButton(
        onPressed: popoverController.toggle,
        child: const Text('Open Popover'),
      ),
    );
  }
}

// Basic Popover with Icon
class BasicPopoverWithIcon extends StatefulWidget {
  @override
  State<BasicPopoverWithIcon> createState() => _BasicPopoverWithIconState();
}

class _BasicPopoverWithIconState extends State<BasicPopoverWithIcon> {
  final popoverController = ShadPopoverController();

  @override
  void dispose() {
    popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadPopover(
      controller: popoverController,
      popover: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(LucideIcons.info, size: 16),
            const SizedBox(width: 8),
            const Text('Information popover'),
          ],
        ),
      ),
      child: ShadIconButton(
        onPressed: popoverController.toggle,
        icon: const Icon(LucideIcons.info),
      ),
    );
  }
}

// Basic Popover with Custom Styling
class StyledBasicPopover extends StatefulWidget {
  @override
  State<StyledBasicPopover> createState() => _StyledBasicPopoverState();
}

class _StyledBasicPopoverState extends State<StyledBasicPopover> {
  final popoverController = ShadPopoverController();

  @override
  void dispose() {
    popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadPopover(
      controller: popoverController,
      popover: (context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Text('Styled popover content'),
      ),
      child: ShadButton(
        onPressed: popoverController.toggle,
        child: const Text('Styled Popover'),
      ),
    );
  }
}''';
  }

  // Code for form popover
  String _getFormCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Form Popover
class FormPopoverExample extends StatefulWidget {
  @override
  State<FormPopoverExample> createState() => _FormPopoverExampleState();
}

class _FormPopoverExampleState extends State<FormPopoverExample> {
  final popoverController = ShadPopoverController();

  final List<({String name, String initialValue})> layer = [
    (name: 'Width', initialValue: '100%'),
    (name: 'Height', initialValue: '300px'),
    (name: 'Padding', initialValue: '25px'),
    (name: 'Margin', initialValue: 'none'),
  ];

  @override
  void dispose() {
    popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ShadPopover(
      controller: popoverController,
      popover: (context) => SizedBox(
        width: 288,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Dimensions',
              style: textTheme.headlineSmall,
            ),
            Text(
              'Set the dimensions for the layer.',
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            ...layer
                .map(
                  (e) => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(
                        e.name,
                        textAlign: TextAlign.start,
                      )),
                      Expanded(
                        flex: 2,
                        child: ShadInput(
                          initialValue: e.initialValue,
                        ),
                      )
                    ],
                  ),
                )
                .expand((widget) => [widget, const SizedBox(height: 8)])
                .take(layer.length * 2 - 1), // Remove the last separator
          ],
        ),
      ),
      child: ShadButton.outline(
        onPressed: popoverController.toggle,
        child: const Text('Open popover'),
      ),
    );
  }
}

// Form Popover with Validation
class FormPopoverWithValidation extends StatefulWidget {
  @override
  State<FormPopoverWithValidation> createState() => _FormPopoverWithValidationState();
}

class _FormPopoverWithValidationState extends State<FormPopoverWithValidation> {
  final popoverController = ShadPopoverController();
  final formKey = GlobalKey<ShadFormState>();

  @override
  void dispose() {
    popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadPopover(
      controller: popoverController,
      popover: (context) => SizedBox(
        width: 300,
        child: ShadForm(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('User Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              ShadInputFormField(
                id: 'name',
                label: const Text('Name'),
                placeholder: const Text('Enter your name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ShadInputFormField(
                id: 'email',
                label: const Text('Email'),
                placeholder: const Text('Enter your email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ShadButton(
                      onPressed: () => popoverController.close(),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ShadButton(
                      onPressed: () {
                        if (formKey.currentState!.saveAndValidate()) {
                          debugPrint('Form data submitted');
                          popoverController.close();
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      child: ShadButton(
        onPressed: popoverController.toggle,
        child: const Text('Open Form'),
      ),
    );
  }
}''';
  }

  // Code for custom popover
  String _getCustomCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Custom Popover with List
class CustomPopoverExample extends StatefulWidget {
  @override
  State<CustomPopoverExample> createState() => _CustomPopoverExampleState();
}

class _CustomPopoverExampleState extends State<CustomPopoverExample> {
  final popoverController = ShadPopoverController();

  @override
  void dispose() {
    popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadPopover(
      controller: popoverController,
      popover: (context) => Container(
        width: 200,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Quick Actions', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(LucideIcons.edit, size: 16),
              title: const Text('Edit'),
              onTap: () {
                popoverController.close();
              },
            ),
            ListTile(
              leading: const Icon(LucideIcons.copy, size: 16),
              title: const Text('Copy'),
              onTap: () {
                popoverController.close();
              },
            ),
            ListTile(
              leading: const Icon(LucideIcons.trash2, size: 16),
              title: const Text('Delete'),
              onTap: () {
                popoverController.close();
              },
            ),
          ],
        ),
      ),
      child: ShadButton(
        onPressed: popoverController.toggle,
        child: const Text('Quick Actions'),
      ),
    );
  }
}

// Custom Popover with Image
class ImagePopoverExample extends StatefulWidget {
  @override
  State<ImagePopoverExample> createState() => _ImagePopoverExampleState();
}

class _ImagePopoverExampleState extends State<ImagePopoverExample> {
  final popoverController = ShadPopoverController();

  @override
  void dispose() {
    popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadPopover(
      controller: popoverController,
      popover: (context) => Container(
        width: 250,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 200,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(LucideIcons.image, size: 48, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 12),
            const Text('Image Preview', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('This is a sample image preview in a popover.'),
          ],
        ),
      ),
      child: ShadButton(
        onPressed: popoverController.toggle,
        child: const Text('View Image'),
      ),
    );
  }
}

// Custom Popover with Tabs
class TabbedPopoverExample extends StatefulWidget {
  @override
  State<TabbedPopoverExample> createState() => _TabbedPopoverExampleState();
}

class _TabbedPopoverExampleState extends State<TabbedPopoverExample> {
  final popoverController = ShadPopoverController();

  @override
  void dispose() {
    popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadPopover(
      controller: popoverController,
      popover: (context) => SizedBox(
        width: 300,
        child: ShadTabs(
          tabs: const [
            ShadTab(child: Text('General')),
            ShadTab(child: Text('Advanced')),
          ],
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('General Settings', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  Text('Configure general application settings here.'),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Advanced Settings', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  Text('Configure advanced application settings here.'),
                ],
              ),
            ),
          ],
        ),
      ),
      child: ShadButton(
        onPressed: popoverController.toggle,
        child: const Text('Settings'),
      ),
    );
  }
}''';
  }

  // Code for interactive popover
  String _getInteractiveCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Interactive Popover with State
class InteractivePopoverExample extends StatefulWidget {
  @override
  State<InteractivePopoverExample> createState() => _InteractivePopoverExampleState();
}

class _InteractivePopoverExampleState extends State<InteractivePopoverExample> {
  final popoverController = ShadPopoverController();
  int counter = 0;

  @override
  void dispose() {
    popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadPopover(
      controller: popoverController,
      popover: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Counter: updated', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ShadButton(
                  onPressed: () {
                    setState(() {
                      counter--;
                    });
                  },
                  child: const Text('-'),
                ),
                const SizedBox(width: 8),
                ShadButton(
                  onPressed: () {
                    setState(() {
                      counter++;
                    });
                  },
                  child: const Text('+'),
                ),
              ],
            ),
          ],
        ),
      ),
      child: ShadButton(
        onPressed: popoverController.toggle,
        child: const Text('Interactive Counter'),
      ),
    );
  }
}

// Interactive Popover with Form
class InteractiveFormPopover extends StatefulWidget {
  @override
  State<InteractiveFormPopover> createState() => _InteractiveFormPopoverState();
}

class _InteractiveFormPopoverState extends State<InteractiveFormPopover> {
  final popoverController = ShadPopoverController();
  String selectedOption = 'Option 1';
  bool isEnabled = true;

  @override
  void dispose() {
    popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadPopover(
      controller: popoverController,
      popover: (context) => Container(
        width: 250,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Interactive Form', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ShadSelect(
              value: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value;
                });
              },
              items: const [
                ShadSelectItem(value: 'Option 1', child: Text('Option 1')),
                ShadSelectItem(value: 'Option 2', child: Text('Option 2')),
                ShadSelectItem(value: 'Option 3', child: Text('Option 3')),
              ],
            ),
            const SizedBox(height: 12),
            ShadCheckbox(
              value: isEnabled,
              onChanged: (value) {
                setState(() {
                  isEnabled = value;
                });
              },
              child: const Text('Enable feature'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ShadButton(
                    onPressed: () => popoverController.close(),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ShadButton(
                    onPressed: () {
                      popoverController.close();
                    },
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      child: ShadButton(
        onPressed: popoverController.toggle,
        child: const Text('Interactive Form'),
      ),
    );
  }
}

// Interactive Popover with Animation
class AnimatedPopoverExample extends StatefulWidget {
  @override
  State<AnimatedPopoverExample> createState() => _AnimatedPopoverExampleState();
}

class _AnimatedPopoverExampleState extends State<AnimatedPopoverExample>
    with SingleTickerProviderStateMixin {
  final popoverController = ShadPopoverController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    popoverController.dispose();
    super.dispose();
  }

  void _openPopover() {
    popoverController.toggle();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ShadPopover(
      controller: popoverController,
      popover: (context) => ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Text('Animated popover content'),
        ),
      ),
      child: ShadButton(
        onPressed: _openPopover,
        child: const Text('Animated Popover'),
      ),
    );
  }
}''';
  }
}

/// Basic popover example widget
class BasicPopoverExample extends StatefulWidget {
  const BasicPopoverExample({super.key});

  @override
  State<BasicPopoverExample> createState() => _BasicPopoverExampleState();
}

class _BasicPopoverExampleState extends State<BasicPopoverExample> {
  final popoverController = ShadPopoverController();

  @override
  void dispose() {
    popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Basic Popover',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Simple popover with basic content.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadPopover(
          controller: popoverController,
          popover: (context) => Container(
            padding: const EdgeInsets.all(16),
            child: const Text('This is a basic popover content.'),
          ),
          child: ShadButton(
            onPressed: popoverController.toggle,
            child: const Text('Open Popover'),
          ),
        ),
      ],
    );
  }
}

/// Form popover example widget
class FormPopoverExample extends StatefulWidget {
  const FormPopoverExample({super.key});

  @override
  State<FormPopoverExample> createState() => _FormPopoverExampleState();
}

class _FormPopoverExampleState extends State<FormPopoverExample> {
  final popoverController = ShadPopoverController();

  final List<({String name, String initialValue})> layer = [
    (name: 'Width', initialValue: '100%'),
    (name: 'Height', initialValue: '300px'),
    (name: 'Padding', initialValue: '25px'),
    (name: 'Margin', initialValue: 'none'),
  ];

  @override
  void dispose() {
    popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Form Popover',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Popover with form inputs and controls.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadPopover(
          controller: popoverController,
          popover: (context) => SizedBox(
            width: 288,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Dimensions',
                  style: textTheme.headlineSmall,
                ),
                Text(
                  'Set the dimensions for the layer.',
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                ...layer
                    .map(
                      (e) => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Text(
                            e.name,
                            textAlign: TextAlign.start,
                          )),
                          Expanded(
                            flex: 2,
                            child: ShadInput(
                              initialValue: e.initialValue,
                            ),
                          )
                        ],
                      ),
                    )
                    .expand((widget) => [widget, const SizedBox(height: 8)])
                    .take(layer.length * 2 - 1), // Remove the last separator
              ],
            ),
          ),
          child: ShadButton.outline(
            onPressed: popoverController.toggle,
            child: const Text('Open popover'),
          ),
        ),
      ],
    );
  }
}

/// Custom popover example widget
class CustomPopoverExample extends StatefulWidget {
  const CustomPopoverExample({super.key});

  @override
  State<CustomPopoverExample> createState() => _CustomPopoverExampleState();
}

class _CustomPopoverExampleState extends State<CustomPopoverExample> {
  final popoverController = ShadPopoverController();

  @override
  void dispose() {
    popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Custom Popover',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Custom popover with different layouts and styling.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadPopover(
          controller: popoverController,
          popover: (context) => Container(
            width: 200,
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Quick Actions',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ListTile(
                  leading: const Icon(LucideIcons.pencil, size: 16),
                  title: const Text('Edit'),
                  onTap: () {
                    popoverController.toggle();
                  },
                ),
                ListTile(
                  leading: const Icon(LucideIcons.copy, size: 16),
                  title: const Text('Copy'),
                  onTap: () {
                    popoverController.toggle();
                  },
                ),
                ListTile(
                  leading: const Icon(LucideIcons.trash2, size: 16),
                  title: const Text('Delete'),
                  onTap: () {
                    popoverController.toggle();
                  },
                ),
              ],
            ),
          ),
          child: ShadButton(
            onPressed: popoverController.toggle,
            child: const Text('Quick Actions'),
          ),
        ),
      ],
    );
  }
}

/// Interactive popover example widget
class InteractivePopoverExample extends StatefulWidget {
  const InteractivePopoverExample({super.key});

  @override
  State<InteractivePopoverExample> createState() =>
      _InteractivePopoverExampleState();
}

class _InteractivePopoverExampleState extends State<InteractivePopoverExample> {
  final popoverController = ShadPopoverController();
  int counter = 0;

  @override
  void dispose() {
    popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Interactive Popover',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Interactive popover with dynamic content.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadPopover(
          controller: popoverController,
          popover: (context) => Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Counter: updated', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 12),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShadButton(
                      onPressed: () {
                        setState(() {
                          counter--;
                        });
                      },
                      child: const Text('-'),
                    ),
                    const SizedBox(width: 8),
                    ShadButton(
                      onPressed: () {
                        setState(() {
                          counter++;
                        });
                      },
                      child: const Text('+'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          child: ShadButton(
            onPressed: popoverController.toggle,
            child: const Text('Interactive Counter'),
          ),
        ),
      ],
    );
  }
}
