import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../component_example_interface.dart' as example_interface;

class SlideExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'Slide';

  @override
  String get description => 'Draggable slider for value selection';

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.basic;

  @override
  String get category => 'Form';

  @override
  List<String> get tags => ['form', 'slider', 'range', 'value'];

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
        'Basic': example_interface.ComponentVariant(
          previewBuilder: (context) => const BasicSlideExample(),
          code: _getBasicCode(),
        ),
        'Range Slider': example_interface.ComponentVariant(
          previewBuilder: (context) => const RangeSlideExample(),
          code: _getRangeCode(),
        ),
        'Custom Slider': example_interface.ComponentVariant(
          previewBuilder: (context) => const CustomSlideExample(),
          code: _getCustomCode(),
        ),
        'Multiple Sliders': example_interface.ComponentVariant(
          previewBuilder: (context) => const MultipleSlidersExample(),
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
    return '''class BasicSlideExample extends StatelessWidget {
  const BasicSlideExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Basic Slider',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A basic slider with initial value and maximum range.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ShadSlider(
            initialValue: 33,
            max: 100,
          ),
        ),
      ],
    );
  }
}''';
  }

  String _getRangeCode() {
    return '''class RangeSlideExample extends StatefulWidget {
  const RangeSlideExample({super.key});

  @override
  State<RangeSlideExample> createState() => _RangeSlideExampleState();
}

class _RangeSlideExampleState extends State<RangeSlideExample> {
  double value = 50;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Range Slider',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A slider with min and max value constraints.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            children: [
              Text('Value: changed'),
              const SizedBox(height: 8),
              ShadSlider(
                initialValue: value,
                min: 0,
                max: 100,
                onChanged: (newValue) => setState(() => value = newValue),
              ),
            ],
          ),
        ),
      ],
    );
  }
}''';
  }

  String _getCustomCode() {
    return '''class CustomSlideExample extends StatefulWidget {
  const CustomSlideExample({super.key});

  @override
  State<CustomSlideExample> createState() => _CustomSlideExampleState();
}

class _CustomSlideExampleState extends State<CustomSlideExample> {
  double volume = 75;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Custom Slider',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A slider with custom styling and labels.',
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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Volume'),
                    Text('Volume changed'),
                  ],
                ),
                const SizedBox(height: 8),
                ShadSlider(
                  initialValue: volume,
                  min: 0,
                  max: 100,
                  onChanged: (newValue) => setState(() => volume = newValue),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}''';
  }

  String _getMultipleCode() {
    return '''class MultipleSlidersExample extends StatefulWidget {
  const MultipleSlidersExample({super.key});

  @override
  State<MultipleSlidersExample> createState() => _MultipleSlidersExampleState();
}

class _MultipleSlidersExampleState extends State<MultipleSlidersExample> {
  final Map<String, double> settings = {
    'Brightness': 80,
    'Contrast': 60,
    'Saturation': 70,
    'Sharpness': 45,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Multiple Sliders',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Multiple sliders for different settings.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            children: settings.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(entry.key),
                        Text('Value changed'),
                      ],
                    ),
                    const SizedBox(height: 4),
                    ShadSlider(
                      initialValue: entry.value,
                      min: 0,
                      max: 100,
                      onChanged: (newValue) =>
                          setState(() => settings[entry.key] = newValue),
                    ),
                  ],
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
class BasicSlideExample extends StatelessWidget {
  const BasicSlideExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Basic Slider',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A basic slider with initial value and maximum range.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ShadSlider(
            initialValue: 33,
            max: 100,
          ),
        ),
      ],
    );
  }
}

class RangeSlideExample extends StatefulWidget {
  const RangeSlideExample({super.key});

  @override
  State<RangeSlideExample> createState() => _RangeSlideExampleState();
}

class _RangeSlideExampleState extends State<RangeSlideExample> {
  double value = 50;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Range Slider',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A slider with min and max value constraints.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            children: [
              Text('Value: changed'),
              const SizedBox(height: 8),
              ShadSlider(
                initialValue: value,
                min: 0,
                max: 100,
                onChanged: (newValue) => setState(() => value = newValue),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomSlideExample extends StatefulWidget {
  const CustomSlideExample({super.key});

  @override
  State<CustomSlideExample> createState() => _CustomSlideExampleState();
}

class _CustomSlideExampleState extends State<CustomSlideExample> {
  double volume = 75;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Custom Slider',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A slider with custom styling and labels.',
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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Volume'),
                    Text('Volume changed'),
                  ],
                ),
                const SizedBox(height: 8),
                ShadSlider(
                  initialValue: volume,
                  min: 0,
                  max: 100,
                  onChanged: (newValue) => setState(() => volume = newValue),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MultipleSlidersExample extends StatefulWidget {
  const MultipleSlidersExample({super.key});

  @override
  State<MultipleSlidersExample> createState() => _MultipleSlidersExampleState();
}

class _MultipleSlidersExampleState extends State<MultipleSlidersExample> {
  final Map<String, double> settings = {
    'Brightness': 80,
    'Contrast': 60,
    'Saturation': 70,
    'Sharpness': 45,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Multiple Sliders',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Multiple sliders for different settings.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            children: settings.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(entry.key),
                        Text('Value changed'),
                      ],
                    ),
                    const SizedBox(height: 4),
                    ShadSlider(
                      initialValue: entry.value,
                      min: 0,
                      max: 100,
                      onChanged: (newValue) =>
                          setState(() => settings[entry.key] = newValue),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
