import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../component_example_interface.dart' as example_interface;

/// Checkbox component implementation using the new architecture
class CheckboxExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'Checkbox';

  @override
  String get description =>
      'A checkbox component that allows users to make binary choices or select multiple options from a list with clear visual feedback.';

  @override
  String get category => 'Form';

  @override
  List<String> get tags => ['selection', 'form', 'input', 'control'];

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.basic;

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
    'Basic States': example_interface.ComponentVariant(
      previewBuilder: (context) => _buildBasicStates(),
      code: _getBasicCode(),
    ),
    'With Labels': example_interface.ComponentVariant(
      previewBuilder: (context) => _buildWithLabels(),
      code: _getLabelsCode(),
    ),
    'Disabled States': example_interface.ComponentVariant(
      previewBuilder: (context) => _buildDisabledStates(),
      code: _getDisabledCode(),
    ),
    'Interactive Examples': example_interface.ComponentVariant(
      previewBuilder: (context) => _buildInteractiveExamples(),
      code: _getInteractiveCode(),
    ),
  };

  @override
  Widget buildPreview(BuildContext context, [String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.previewBuilder(context) ?? _buildBasicStates();
  }

  @override
  String getCode([String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.code ?? _getBasicCode();
  }

  // Basic states preview
  Widget _buildBasicStates() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Checked checkbox
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShadCheckbox(
              value: true,
              onChanged: (value) {},
            ),
            const SizedBox(width: 8),
            const Text('Checked'),
          ],
        ),
        const SizedBox(height: 16),
        // Unchecked checkbox
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShadCheckbox(
              value: false,
              onChanged: (value) {},
            ),
            const SizedBox(width: 8),
            const Text('Unchecked'),
          ],
        ),
        const SizedBox(height: 16),
        // Custom indeterminate-style checkbox
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Center(
                child: Container(
                  width: 8,
                  height: 2,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text('Indeterminate state (custom)'),
          ],
        ),
      ],
    );
  }

  // With labels preview
  Widget _buildWithLabels() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Checked checkbox with label
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShadCheckbox(
              value: true,
              onChanged: (value) {},
            ),
            const SizedBox(width: 8),
            const Text('Accept terms and conditions'),
          ],
        ),
        const SizedBox(height: 16),
        // Unchecked checkbox with label
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShadCheckbox(
              value: false,
              onChanged: (value) {},
            ),
            const SizedBox(width: 8),
            const Text('Subscribe to newsletter'),
          ],
        ),
        const SizedBox(height: 16),
        // Another checkbox with label
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShadCheckbox(
              value: true,
              onChanged: (value) {},
            ),
            const SizedBox(width: 8),
            const Text('Send me marketing emails'),
          ],
        ),
      ],
    );
  }

  // Disabled states preview
  Widget _buildDisabledStates() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Disabled checkbox (checked)
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShadCheckbox(
              value: true,
              onChanged: null, // Disabled
            ),
            const SizedBox(width: 8),
            Text(
              'Disabled (checked)',
              style: TextStyle(color: Colors.grey.shade500),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Disabled checkbox (unchecked)
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShadCheckbox(
              value: false,
              onChanged: null, // Disabled
            ),
            const SizedBox(width: 8),
            Text(
              'Disabled (unchecked)',
              style: TextStyle(color: Colors.grey.shade500),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Disabled custom indeterminate checkbox
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey.shade100,
              ),
              child: Center(
                child: Container(
                  width: 8,
                  height: 2,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Disabled (indeterminate)',
              style: TextStyle(color: Colors.grey.shade500),
            ),
          ],
        ),
      ],
    );
  }

  // Interactive examples preview
  Widget _buildInteractiveExamples() {
    return const _InteractiveCheckboxExamples();
  }

  // Code for basic states
  String _getBasicCode() {
    return '''import 'package:shadcn_ui/shadcn_ui.dart';

// Checked Checkbox
ShadCheckbox(
  value: true,
  onChanged: (bool? value) {
    // Handle checkbox state change
    print('Checkbox value: \$value');
  },
)

// Unchecked Checkbox
ShadCheckbox(
  value: false,
  onChanged: (bool? value) {
    // Handle state change
  },
)

// Indeterminate Checkbox (three-state)
ShadCheckbox(
  value: null, // null represents indeterminate
  tristate: true, // Allow three states
  onChanged: (bool? value) {
    // value can be true, false, or null
  },
)

// Basic Checkbox with Label
Row(
  children: [
    ShadCheckbox(
      value: false,
      onChanged: (bool? value) {
        // Handle state change
      },
    ),
    const SizedBox(width: 8),
    const Text('Accept terms and conditions'),
  ],
)''';
  }

  // Code for with labels
  String _getLabelsCode() {
    return '''import 'package:shadcn_ui/shadcn_ui.dart';

// Checkbox with Label
Row(
  children: [
    ShadCheckbox(
      value: true,
      onChanged: (bool? value) {
        // Handle state change
      },
    ),
    const SizedBox(width: 8),
    const Text('Accept terms and conditions'),
  ],
)

// Clickable Label Checkbox
class CheckboxWithLabel extends StatefulWidget {
  final String label;
  final bool initialValue;
  final ValueChanged<bool>? onChanged;

  const CheckboxWithLabel({
    Key? key,
    required this.label,
    this.initialValue = false,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CheckboxWithLabel> createState() => _CheckboxWithLabelState();
}

class _CheckboxWithLabelState extends State<CheckboxWithLabel> {
  late bool value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  void _handleChanged(bool newValue) {
    setState(() {
      value = newValue;
    });
    widget.onChanged?.call(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleChanged(!value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ShadCheckbox(
            value: value,
            onChanged: (newValue) => _handleChanged(newValue ?? false),
          ),
          const SizedBox(width: 8),
          Text(widget.label),
        ],
      ),
    );
  }
}

// Usage
CheckboxWithLabel(
  label: 'Subscribe to newsletter',
  initialValue: false,
  onChanged: (value) {
    print('Newsletter subscription: \$value');
  },
)''';
  }

  // Code for disabled states
  String _getDisabledCode() {
    return '''import 'package:shadcn_ui/shadcn_ui.dart';

// Disabled Checked Checkbox
ShadCheckbox(
  value: true,
  onChanged: null, // null makes it disabled
)

// Disabled Unchecked Checkbox
ShadCheckbox(
  value: false,
  onChanged: null, // null makes it disabled
)

// Disabled Indeterminate Checkbox
ShadCheckbox(
  value: null,
  tristate: true,
  onChanged: null, // null makes it disabled
)

// Disabled Checkbox with Label
Row(
  children: [
    ShadCheckbox(
      value: true,
      onChanged: null, // Disabled
    ),
    const SizedBox(width: 8),
    Text(
      'Disabled option',
      style: TextStyle(color: Colors.grey.shade500),
    ),
  ],
)

// Conditionally Disabled Checkbox
ShadCheckbox(
  value: isChecked,
  onChanged: isEnabled ? (value) {
    setState(() {
      isChecked = value ?? false;
    });
  } : null, // Disabled when isEnabled is false
)''';
  }

  // Code for interactive examples
  String _getInteractiveCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Stateful Checkbox Example
class CheckboxWidget extends StatefulWidget {
  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShadCheckbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value ?? false;
            });
          },
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            setState(() {
              isChecked = !isChecked;
            });
          },
          child: const Text('Toggle me'),
        ),
      ],
    );
  }
}

// Multiple Checkboxes with Select All
class CheckboxList extends StatefulWidget {
  final List<String> options;
  final List<String> selected;
  final ValueChanged<List<String>>? onChanged;

  const CheckboxList({
    Key? key,
    required this.options,
    required this.selected,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CheckboxList> createState() => _CheckboxListState();
}

class _CheckboxListState extends State<CheckboxList> {
  late Set<String> selectedSet;

  @override
  void initState() {
    super.initState();
    selectedSet = Set.from(widget.selected);
  }

  void _handleChanged(String option, bool? isSelected) {
    setState(() {
      if (isSelected == true) {
        selectedSet.add(option);
      } else {
        selectedSet.remove(option);
      }
    });
    widget.onChanged?.call(selectedSet.toList());
  }

  void _handleSelectAll(bool? value) {
    setState(() {
      if (value == true) {
        selectedSet.addAll(widget.options);
      } else {
        selectedSet.clear();
      }
    });
    widget.onChanged?.call(selectedSet.toList());
  }

  @override
  Widget build(BuildContext context) {
    final allSelected = selectedSet.length == widget.options.length;
    final someSelected = selectedSet.isNotEmpty && !allSelected;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Select All checkbox
        Row(
          children: [
            ShadCheckbox(
              value: allSelected ? true : (someSelected ? null : false),
              tristate: true,
              onChanged: _handleSelectAll,
            ),
            const SizedBox(width: 8),
            const Text('Select All'),
          ],
        ),
        const SizedBox(height: 16),
        // Individual checkboxes
        ...widget.options.map((option) {
          final isSelected = selectedSet.contains(option);
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                ShadCheckbox(
                  value: isSelected,
                  onChanged: (value) => _handleChanged(option, value),
                ),
                const SizedBox(width: 8),
                Text(option),
              ],
            ),
          );
        }),
      ],
    );
  }
}

// Usage
CheckboxList(
  options: ['Option 1', 'Option 2', 'Option 3'],
  selected: ['Option 1'],
  onChanged: (selected) {
    print('Selected options: \$selected');
  },
)''';
  }
}

/// Interactive checkbox examples widget
class _InteractiveCheckboxExamples extends StatefulWidget {
  const _InteractiveCheckboxExamples();

  @override
  State<_InteractiveCheckboxExamples> createState() =>
      _InteractiveCheckboxExamplesState();
}

class _InteractiveCheckboxExamplesState
    extends State<_InteractiveCheckboxExamples> {
  bool isChecked = false;
  final Set<String> selectedOptions = {'Option 1'};
  final List<String> options = ['Option 1', 'Option 2', 'Option 3'];

  void _handleOptionChanged(String option, bool? value) {
    setState(() {
      if (value == true) {
        selectedOptions.add(option);
      } else {
        selectedOptions.remove(option);
      }
    });
  }

  void _handleSelectAll(bool? value) {
    setState(() {
      if (value == true) {
        selectedOptions.addAll(options);
      } else {
        selectedOptions.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final allSelected = selectedOptions.length == options.length;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Single interactive checkbox
        Row(
          children: [
            ShadCheckbox(
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value;
                });
              },
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                setState(() {
                  isChecked = !isChecked;
                });
              },
              child: const Text('Toggle me'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Select all checkbox
        Row(
          children: [
            ShadCheckbox(
              value: allSelected,
              onChanged: _handleSelectAll,
            ),
            const SizedBox(width: 8),
            const Text('Select All'),
          ],
        ),
        const SizedBox(height: 16),
        // Individual options
        ...options.map((option) {
          final isSelected = selectedOptions.contains(option);
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                ShadCheckbox(
                  value: isSelected,
                  onChanged: (value) => _handleOptionChanged(option, value),
                ),
                const SizedBox(width: 8),
                Text(option),
              ],
            ),
          );
        }),
      ],
    );
  }
}
