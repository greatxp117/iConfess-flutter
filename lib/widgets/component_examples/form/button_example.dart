import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../component_example_interface.dart' as example_interface;

/// Button component implementation using the new architecture
class ButtonExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'Button';

  @override
  String get description =>
      'A button component that triggers an action or event, such as submitting a form, opening a dialog, canceling an action, or performing a delete operation.';

  @override
  String get category => 'Form';

  @override
  List<String> get tags => ['interactive', 'action', 'submit', 'form'];

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.basic;

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
        'Basic Variants': example_interface.ComponentVariant(
          previewBuilder: (context) => _buildBasicVariants(),
          code: _getBasicCode(),
        ),
        'With Icons': example_interface.ComponentVariant(
          previewBuilder: (context) => _buildIconButtons(),
          code: _getIconCode(),
        ),
        'Disabled States': example_interface.ComponentVariant(
          previewBuilder: (context) => _buildDisabledButtons(),
          code: _getDisabledCode(),
        ),
        'Loading States': example_interface.ComponentVariant(
          previewBuilder: (context) => _buildLoadingButtons(),
          code: _getLoadingCode(),
        ),
      };

  @override
  Widget buildPreview(BuildContext context, [String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.previewBuilder(context) ?? _buildBasicVariants();
  }

  @override
  String getCode([String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.code ?? _getBasicCode();
  }

  // Basic variants preview
  Widget _buildBasicVariants() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Primary button row
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShadButton(
              onPressed: () {},
              child: const Text('Primary'),
            ),
            const SizedBox(width: 12),
            ShadButton.outline(
              onPressed: () {},
              child: const Text('Outline'),
            ),
            const SizedBox(width: 12),
            ShadButton.secondary(
              onPressed: () {},
              child: const Text('Secondary'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Additional variants row
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShadButton.destructive(
              onPressed: () {},
              child: const Text('Destructive'),
            ),
            const SizedBox(width: 12),
            ShadButton.ghost(
              onPressed: () {},
              child: const Text('Ghost'),
            ),
          ],
        ),
      ],
    );
  }

  // Icon buttons preview
  Widget _buildIconButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Button with icon and text
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShadButton(
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.download, size: 16),
                  SizedBox(width: 8),
                  Text('Download'),
                ],
              ),
            ),
            const SizedBox(width: 12),
            ShadButton.outline(
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.upload, size: 16),
                  SizedBox(width: 8),
                  Text('Upload'),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Icon-only buttons
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShadButton.outline(
              onPressed: () {},
              child: const Icon(Icons.settings, size: 16),
            ),
            const SizedBox(width: 12),
            ShadButton.ghost(
              onPressed: () {},
              child: const Icon(Icons.more_vert, size: 16),
            ),
            const SizedBox(width: 12),
            ShadButton.secondary(
              onPressed: () {},
              child: const Icon(Icons.edit, size: 16),
            ),
          ],
        ),
      ],
    );
  }

  // Disabled buttons preview
  Widget _buildDisabledButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Disabled primary and outline
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShadButton(
              onPressed: null, // Disabled
              child: const Text('Disabled'),
            ),
            const SizedBox(width: 12),
            ShadButton.outline(
              onPressed: null, // Disabled
              child: const Text('Disabled Outline'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Disabled secondary and destructive
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShadButton.secondary(
              onPressed: null, // Disabled
              child: const Text('Disabled Secondary'),
            ),
            const SizedBox(width: 12),
            ShadButton.destructive(
              onPressed: null, // Disabled
              child: const Text('Disabled Destructive'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Disabled ghost and icon button
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShadButton.ghost(
              onPressed: null, // Disabled
              child: const Text('Disabled Ghost'),
            ),
            const SizedBox(width: 12),
            ShadButton.outline(
              onPressed: null, // Disabled
              child: const Icon(Icons.settings, size: 16),
            ),
          ],
        ),
      ],
    );
  }

  // Loading buttons preview
  Widget _buildLoadingButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Loading primary button
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShadButton(
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text('Loading...'),
                ],
              ),
            ),
            const SizedBox(width: 12),
            ShadButton.outline(
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text('Processing'),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Loading icon button
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShadButton.secondary(
              onPressed: () {},
              child: const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            ),
            const SizedBox(width: 12),
            ShadButton.ghost(
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text('Saving'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Code for basic variants
  String _getBasicCode() {
    return '''import 'package:shadcn_ui/shadcn_ui.dart';

// Primary Button
ShadButton(
  onPressed: () {
    // Handle button press
  },
  child: const Text('Primary'),
)

// Outline Button
ShadButton.outline(
  onPressed: () {},
  child: const Text('Outline'),
)

// Secondary Button
ShadButton.secondary(
  onPressed: () {},
  child: const Text('Secondary'),
)

// Destructive Button
ShadButton.destructive(
  onPressed: () {},
  child: const Text('Destructive'),
)

// Ghost Button
ShadButton.ghost(
  onPressed: () {},
  child: const Text('Ghost'),
)''';
  }

  // Code for icon buttons
  String _getIconCode() {
    return '''import 'package:shadcn_ui/shadcn_ui.dart';

// Button with Icon and Text
ShadButton(
  onPressed: () {},
  child: const Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.download, size: 16),
      SizedBox(width: 8),
      Text('Download'),
    ],
  ),
)

// Button with Icon and Text (Outline)
ShadButton.outline(
  onPressed: () {},
  child: const Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.upload, size: 16),
      SizedBox(width: 8),
      Text('Upload'),
    ],
  ),
)

// Icon Only Button
ShadButton.outline(
  onPressed: () {},
  child: const Icon(Icons.settings, size: 16),
)

// Ghost Icon Button
ShadButton.ghost(
  onPressed: () {},
  child: const Icon(Icons.more_vert, size: 16),
)

// Secondary Icon Button
ShadButton.secondary(
  onPressed: () {},
  child: const Icon(Icons.edit, size: 16),
)''';
  }

  // Code for disabled buttons
  String _getDisabledCode() {
    return '''import 'package:shadcn_ui/shadcn_ui.dart';

// Disabled Primary Button
ShadButton(
  onPressed: null, // null makes it disabled
  child: const Text('Disabled'),
)

// Disabled Outline Button
ShadButton.outline(
  onPressed: null,
  child: const Text('Disabled Outline'),
)

// Disabled Secondary Button
ShadButton.secondary(
  onPressed: null,
  child: const Text('Disabled Secondary'),
)

// Disabled Destructive Button
ShadButton.destructive(
  onPressed: null,
  child: const Text('Disabled Destructive'),
)

// Disabled Ghost Button
ShadButton.ghost(
  onPressed: null,
  child: const Text('Disabled Ghost'),
)

// Disabled Icon Button
ShadButton.outline(
  onPressed: null,
  child: const Icon(Icons.settings, size: 16),
)''';
  }

  // Code for loading buttons
  String _getLoadingCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Loading Primary Button
ShadButton(
  onPressed: () {},
  child: const Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
      SizedBox(width: 8),
      Text('Loading...'),
    ],
  ),
)

// Loading Outline Button
ShadButton.outline(
  onPressed: () {},
  child: const Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
      SizedBox(width: 8),
      Text('Processing'),
    ],
  ),
)

// Loading Icon Button
ShadButton.secondary(
  onPressed: () {},
  child: const SizedBox(
    width: 16,
    height: 16,
    child: CircularProgressIndicator(
      strokeWidth: 2,
    ),
  ),
)

// Loading Ghost Button
ShadButton.ghost(
  onPressed: () {},
  child: const Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
      SizedBox(width: 8),
      Text('Saving'),
    ],
  ),
)''';
  }
}
