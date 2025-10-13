// ignore_for_file: undefined_identifier
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../component_example_interface.dart' as example_interface;

/// Progress component implementation using the new architecture
class ProgressExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'Progress';

  @override
  String get description =>
      'A progress component that provides visual feedback about the completion status of a task or process, including linear progress bars, circular indicators, and step progress.';

  @override
  String get category => 'Data';

  @override
  List<String> get tags => ['progress', 'loading', 'indicator', 'bar'];

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.basic;

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
        'Basic Progress': example_interface.ComponentVariant(
          previewBuilder: (context) => const BasicProgressExample(),
          code: _getBasicCode(),
        ),
        'Animated Progress': example_interface.ComponentVariant(
          previewBuilder: (context) => const AnimatedProgressExample(),
          code: _getAnimatedCode(),
        ),
        'Custom Progress': example_interface.ComponentVariant(
          previewBuilder: (context) => const CustomProgressExample(),
          code: _getCustomCode(),
        ),
        'Step Progress': example_interface.ComponentVariant(
          previewBuilder: (context) => const StepProgressExample(),
          code: _getStepCode(),
        ),
      };

  @override
  Widget buildPreview(BuildContext context, [String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.previewBuilder(context) ?? const BasicProgressExample();
  }

  @override
  String getCode([String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.code ?? _getBasicCode();
  }

  // Code for basic progress
  String _getBasicCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Basic Progress Bar
ShadProgress(value: 0.6) // 60% complete

// Progress with Different Values
ShadProgress(value: 0.3) // 30% complete
ShadProgress(value: 0.75) // 75% complete
ShadProgress(value: 1.0) // 100% complete

// Progress with Label
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('Loading... 75%'),
    SizedBox(height: 8),
    ShadProgress(value: 0.75),
  ],
)

// Progress with Custom Width
Container(
  width: 300,
  child: ShadProgress(value: 0.45),
)

// Progress with Description
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('Upload Progress', style: TextStyle(fontWeight: FontWeight.bold)),
    SizedBox(height: 4),
    Text('45% complete'),
    SizedBox(height: 8),
    ShadProgress(value: 0.45),
  ],
)

// Multiple Progress Bars
Column(
  children: [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('File 1: 60%'),
        SizedBox(height: 4),
        ShadProgress(value: 0.6),
      ],
    ),
    SizedBox(height: 16),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('File 2: 30%'),
        SizedBox(height: 4),
        ShadProgress(value: 0.3),
      ],
    ),
    SizedBox(height: 16),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('File 3: 90%'),
        SizedBox(height: 4),
        ShadProgress(value: 0.9),
      ],
    ),
  ],
)''';
  }

  // Code for animated progress
  String _getAnimatedCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Animated Progress Example
class AnimatedProgressExample extends StatefulWidget {
  @override
  State<AnimatedProgressExample> createState() => _AnimatedProgressExampleState();
}

class _AnimatedProgressExampleState extends State<AnimatedProgressExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Column(
          children: [
            Text('Progress: updating'),
            SizedBox(height: 8),
            ShadProgress(value: _animation.value),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// Animated Progress with State Management
class StatefulProgressExample extends StatefulWidget {
  @override
  State<StatefulProgressExample> createState() => _StatefulProgressExampleState();
}

class _StatefulProgressExampleState extends State<StatefulProgressExample> {
  double progress = 0.0;
  bool isLoading = false;

  Future<void> _startProgress() async {
    setState(() {
      isLoading = true;
      progress = 0.0;
    });

    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      if (mounted) {
        setState(() {
          progress = i / 100;
        });
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShadProgress(value: progress),
        SizedBox(height: 16),
        Text('Progress: updating'),
        SizedBox(height: 16),
        ShadButton(
          onPressed: isLoading ? null : _startProgress,
          child: Text(isLoading ? 'Loading...' : 'Start Progress'),
        ),
      ],
    );
  }
}

// Indeterminate Progress
class IndeterminateProgressExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(4),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
        ),
      ),
    );
  }
}

// Animated Progress with Different Speeds
class VariableSpeedProgressExample extends StatefulWidget {
  @override
  State<VariableSpeedProgressExample> createState() => _VariableSpeedProgressExampleState();
}

class _VariableSpeedProgressExampleState extends State<VariableSpeedProgressExample>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double speed = 1.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.repeat();
  }

  void _changeSpeed(double newSpeed) {
    setState(() {
      speed = newSpeed;
      _controller.duration = Duration(seconds: (3 / newSpeed).round());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Column(
              children: [
                Text('Progress: updating'),
                SizedBox(height: 8),
                ShadProgress(value: _animation.value),
              ],
            );
          },
        ),
        SizedBox(height: 16),
        Text('Speed: updating'),
        Slider(
          value: speed,
          min: 0.5,
          max: 3.0,
          divisions: 5,
          onChanged: _changeSpeed,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}''';
  }

  // Code for custom progress
  String _getCustomCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Circular Progress
class CircularProgressExample extends StatelessWidget {
  final double value;
  final String? label;

  const CircularProgressExample({
    Key? key,
    required this.value,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: value,
            strokeWidth: 8,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
          ),
          if (label != null)
            Text(
              label!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}

// Custom Styled Progress
class CustomStyledProgress extends StatelessWidget {
  final double value;
  final Color? color;
  final double height;

  const CustomStyledProgress({
    Key? key,
    required this.value,
    this.color,
    this.height = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(height / 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(height / 2),
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation<Color>(color ?? Colors.blue.shade600),
        ),
      ),
    );
  }
}

// Progress with Gradient
class GradientProgressExample extends StatelessWidget {
  final double value;

  const GradientProgressExample({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(6),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.transparent),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade400, Colors.purple.shade600],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Progress with Icons
class IconProgressExample extends StatelessWidget {
  final double value;
  final IconData icon;

  const IconProgressExample({
    Key? key,
    required this.value,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20),
        SizedBox(width: 8),
        Expanded(
          child: ShadProgress(value: value),
        ),
        SizedBox(width: 8),
        Text('Progress updating'),
      ],
    );
  }
}

// Progress with Status
class StatusProgressExample extends StatelessWidget {
  final double value;
  final String status;

  const StatusProgressExample({
    Key? key,
    required this.value,
    required this.status,
  }) : super(key: key);

  Color _getStatusColor() {
    if (value >= 1.0) return Colors.green;
    if (value >= 0.7) return Colors.blue;
    if (value >= 0.4) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(status),
            Text('Progress updating'),
          ],
        ),
        SizedBox(height: 8),
        ShadProgress(value: value),
      ],
    );
  }
}''';
  }

  // Code for step progress
  String _getStepCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Step Progress Indicator
class StepProgressExample extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<String> stepLabels;

  const StepProgressExample({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
    required this.stepLabels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(totalSteps, (index) {
            final isCompleted = index < currentStep;
            final isCurrent = index == currentStep;
            
            return Expanded(
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isCompleted || isCurrent
                          ? Colors.blue.shade600
                          : Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: isCompleted
                          ? const Icon(Icons.check, color: Colors.white, size: 16)
                          : Text(
                              'Step',
                              style: TextStyle(
                                color: isCurrent ? Colors.white : Colors.grey.shade600,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  if (index < totalSteps - 1)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: index < currentStep
                            ? Colors.blue.shade600
                            : Colors.grey.shade300,
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
        SizedBox(height: 8),
        Row(
          children: stepLabels.asMap().entries.map((entry) {
            final index = entry.key;
            final label = entry.value;
            return Expanded(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: index <= currentStep
                      ? Colors.black87
                      : Colors.grey.shade600,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// Interactive Step Progress
class InteractiveStepProgress extends StatefulWidget {
  @override
  State<InteractiveStepProgress> createState() => _InteractiveStepProgressState();
}

class _InteractiveStepProgressState extends State<InteractiveStepProgress> {
  int currentStep = 0;
  final List<String> steps = ['Setup', 'Configure', 'Test', 'Deploy'];

  void _nextStep() {
    if (currentStep < steps.length - 1) {
      setState(() {
        currentStep++;
      });
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StepProgressExample(
          currentStep: currentStep,
          totalSteps: steps.length,
          stepLabels: steps,
        ),
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ShadButton(
              onPressed: currentStep > 0 ? _previousStep : null,
              child: const Text('Previous'),
            ),
            ShadButton(
              onPressed: currentStep < steps.length - 1 ? _nextStep : null,
              child: const Text('Next'),
            ),
          ],
        ),
      ],
    );
  }
}

// Step Progress with Status
class StatusStepProgress extends StatelessWidget {
  final int currentStep;
  final List<({String label, String status})> steps;

  const StatusStepProgress({
    Key? key,
    required this.currentStep,
    required this.steps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(steps.length, (index) {
            final isCompleted = index < currentStep;
            final isCurrent = index == currentStep;
            final step = steps[index];
            
            return Expanded(
              child: Column(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isCompleted || isCurrent
                          ? Colors.blue.shade600
                          : Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: isCompleted
                          ? const Icon(Icons.check, color: Colors.white, size: 16)
                          : Text(
                              'Step',
                              style: TextStyle(
                                color: isCurrent ? Colors.white : Colors.grey.shade600,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    step.label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  Text(
                    step.status,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        SizedBox(height: 8),
        Row(
          children: List.generate(steps.length - 1, (index) {
            return Expanded(
              child: Container(
                height: 2,
                color: index < currentStep
                    ? Colors.blue.shade600
                    : Colors.grey.shade300,
              ),
            );
          }),
        ),
      ],
    );
  }
}''';
  }
}

/// Basic progress example widget
class BasicProgressExample extends StatelessWidget {
  const BasicProgressExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Basic Progress',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Basic linear progress bar with different values.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Loading... 75%', style: TextStyle(fontSize: 14)),
                const SizedBox(height: 8),
                const SizedBox(
                  width: 300,
                  child: ShadProgress(value: 0.75),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Upload Progress 45%',
                    style: TextStyle(fontSize: 14)),
                const SizedBox(height: 8),
                const SizedBox(
                  width: 300,
                  child: ShadProgress(value: 0.45),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Completed 100%',
                    style: TextStyle(fontSize: 14, color: Colors.green)),
                const SizedBox(height: 8),
                const SizedBox(
                  width: 300,
                  child: ShadProgress(value: 1.0),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// Animated progress example widget
class AnimatedProgressExample extends StatefulWidget {
  const AnimatedProgressExample({super.key});

  @override
  State<AnimatedProgressExample> createState() =>
      _AnimatedProgressExampleState();
}

class _AnimatedProgressExampleState extends State<AnimatedProgressExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Animated Progress',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Animated progress bar with smooth transitions.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Column(
              children: [
                Text('Progress: updating'),
                const SizedBox(height: 8),
                const SizedBox(
                  width: 300,
                  child: ShadProgress(value: 0.0),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

/// Custom progress example widget
class CustomProgressExample extends StatelessWidget {
  const CustomProgressExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Custom Progress',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Custom progress indicators with different styles.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            // Circular progress
            SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: 0.7,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey.shade200,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
                  ),
                  const Text(
                    '70%',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Custom styled progress
            Container(
              width: 300,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(6),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: 0.6,
                  backgroundColor: Colors.transparent,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.purple.shade600),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Step progress example widget
class StepProgressExample extends StatefulWidget {
  const StepProgressExample({super.key});

  @override
  State<StepProgressExample> createState() => _StepProgressExampleState();
}

class _StepProgressExampleState extends State<StepProgressExample> {
  int currentStep = 1;
  final List<String> steps = ['Setup', 'Configure', 'Test', 'Deploy'];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Step Progress',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Multi-step progress indicator.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Row(
          children: List.generate(steps.length, (index) {
            final isCompleted = index < currentStep;
            final isCurrent = index == currentStep;

            return Expanded(
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isCompleted || isCurrent
                          ? Colors.blue.shade600
                          : Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: isCompleted
                          ? const Icon(Icons.check,
                              color: Colors.white, size: 16)
                          : Text(
                              'Step',
                              style: TextStyle(
                                color: isCurrent
                                    ? Colors.white
                                    : Colors.grey.shade600,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  if (index < steps.length - 1)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: index < currentStep
                            ? Colors.blue.shade600
                            : Colors.grey.shade300,
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        Row(
          children: steps.asMap().entries.map((entry) {
            final index = entry.key;
            final label = entry.value;
            return Expanded(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: index <= currentStep
                      ? Colors.black87
                      : Colors.grey.shade600,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
