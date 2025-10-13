import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../component_example_interface.dart' as example_interface;

/// Accordion component implementation using the new architecture
class AccordionExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'Accordion';

  @override
  String get description =>
      'A vertically stacked set of interactive headings that reveal content.';

  @override
  String get category => 'Layout & Structure';

  @override
  List<String> get tags => ['collapsible', 'expandable', 'content'];

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.intermediate;

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
    'Basic': example_interface.ComponentVariant(
      previewBuilder: (context) => _buildBasicAccordion(),
      code: _getBasicCode(),
    ),
    'Multiple': example_interface.ComponentVariant(
      previewBuilder: (context) => _buildMultipleAccordion(),
      code: _getMultipleCode(),
    ),
    'Custom Styling': example_interface.ComponentVariant(
      previewBuilder: (context) => _buildCustomAccordion(),
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

  Widget _buildBasicAccordion() {
    return SizedBox(
      width: 500,
      child: ShadAccordion<String>(
        children: [
          ShadAccordionItem(
            value: 'item-1',
            title: const Text('Is it accessible?'),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Yes. It adheres to the WAI-ARIA design pattern and can be navigated using the keyboard.',
              ),
            ),
          ),
          ShadAccordionItem(
            value: 'item-2',
            title: const Text('Is it styled?'),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Yes. It comes with default styles that match the other components aesthetic.',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMultipleAccordion() {
    return SizedBox(
      width: 500,
      child: ShadAccordion<String>(
        children: [
          ShadAccordionItem(
            value: 'item-1',
            title: const Text('What is Flutter?'),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Flutter is Google\'s UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase.',
              ),
            ),
          ),
          ShadAccordionItem(
            value: 'item-2',
            title: const Text('What is shadcn/ui?'),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'shadcn/ui is a collection of reusable components built using Radix UI and Tailwind CSS. It provides a set of accessible and customizable components.',
              ),
            ),
          ),
          ShadAccordionItem(
            value: 'item-3',
            title: const Text('How do they work together?'),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'shadcn_ui for Flutter brings the design system and components from shadcn/ui to Flutter, providing a consistent and beautiful UI experience.',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomAccordion() {
    return SizedBox(
      width: 500,
      child: ShadAccordion<String>(
        children: [
          ShadAccordionItem(
            value: 'item-1',
            title: const Text('Custom Styled Section'),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'This accordion section has custom styling with a colored background and rounded corners.',
              ),
            ),
          ),
          ShadAccordionItem(
            value: 'item-2',
            title: const Text('Another Custom Section'),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Each section can have its own unique styling and content.',
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getBasicCode() {
    return '''// Basic Accordion
SizedBox(
  width: 500,
  child: ShadAccordion<String>(
    children: [
      ShadAccordionItem(
        value: 'item-1',
        title: const Text('Is it accessible?'),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Yes. It adheres to the WAI-ARIA design pattern and can be navigated using the keyboard.',
          ),
        ),
      ),
      ShadAccordionItem(
        value: 'item-2',
        title: const Text('Is it styled?'),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Yes. It comes with default styles that match the other components aesthetic.',
          ),
        ),
      ),
    ],
  ),
)''';
  }

  String _getMultipleCode() {
    return '''// Multiple Accordion
SizedBox(
  width: 500,
  child: ShadAccordion<String>(
    children: [
      ShadAccordionItem(
        value: 'item-1',
        title: const Text('What is Flutter?'),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            "Flutter is Google's UI toolkit for building beautiful, natively compiled applications.",
          ),
        ),
      ),
      ShadAccordionItem(
        value: 'item-2',
        title: const Text('What is shadcn/ui?'),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'shadcn/ui is a collection of reusable components built using Radix UI and Tailwind CSS.',
          ),
        ),
      ),
    ],
  ),
)''';
  }

  String _getCustomCode() {
    return '''// Custom Styled Accordion
SizedBox(
  width: 500,
  child: ShadAccordion<String>(
    children: [
      ShadAccordionItem(
        value: 'item-1',
        title: const Text('Custom Styled Section'),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'This accordion section has custom styling with a colored background.',
          ),
        ),
      ),
    ],
  ),
)''';
  }
}
