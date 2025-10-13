import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../component_example_interface.dart' as example_interface;

/// IconButton component implementation using the new architecture
class IconButtonExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'IconButton';

  @override
  String get description =>
      'A clickable icon button component that provides various styling variants for actions represented by icons rather than text.';

  @override
  String get category => 'Form';

  @override
  List<String> get tags => ['button', 'icon', 'action', 'interaction'];

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.basic;

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
        'Primary': example_interface.ComponentVariant(
          previewBuilder: (context) => const PrimaryIconButtonExample(),
          code: _getPrimaryCode(),
        ),
        'Secondary': example_interface.ComponentVariant(
          previewBuilder: (context) => const SecondaryIconButtonExample(),
          code: _getSecondaryCode(),
        ),
        'Destructive': example_interface.ComponentVariant(
          previewBuilder: (context) => const DestructiveIconButtonExample(),
          code: _getDestructiveCode(),
        ),
        'Outline': example_interface.ComponentVariant(
          previewBuilder: (context) => const OutlineIconButtonExample(),
          code: _getOutlineCode(),
        ),
        'Ghost': example_interface.ComponentVariant(
          previewBuilder: (context) => const GhostIconButtonExample(),
          code: _getGhostCode(),
        ),
        'Loading': example_interface.ComponentVariant(
          previewBuilder: (context) => const LoadingIconButtonExample(),
          code: _getLoadingCode(),
        ),
      };

  @override
  Widget buildPreview(BuildContext context, [String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.previewBuilder(context) ?? const PrimaryIconButtonExample();
  }

  @override
  String getCode([String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.code ?? _getPrimaryCode();
  }

  // Code for primary icon button
  String _getPrimaryCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Primary Icon Button
ShadIconButton(
  onPressed: () {},
  icon: const Icon(LucideIcons.rocket),
)

// Primary Icon Button with Custom Icon
ShadIconButton(
  onPressed: () {
    // Handle button press
  },
  icon: const Icon(
    LucideIcons.plus,
    size: 20,
  ),
)

// Primary Icon Button with Tooltip
Tooltip(
  message: 'Add new item',
  child: ShadIconButton(
    onPressed: () {
      // Handle button press
    },
    icon: const Icon(LucideIcons.plus),
  ),
)

// Primary Icon Button with Disabled State
ShadIconButton(
  onPressed: isDisabled ? null : () {
    // Handle button press
  },
  icon: const Icon(LucideIcons.rocket),
)''';
  }

  // Code for secondary icon button
  String _getSecondaryCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Secondary Icon Button
ShadIconButton.secondary(
  onPressed: () {},
  icon: const Icon(LucideIcons.settings),
)

// Secondary Icon Button with Custom Icon
ShadIconButton.secondary(
  onPressed: () {
    // Handle button press
  },
  icon: const Icon(
    LucideIcons.pencil,
    size: 18,
  ),
)

// Secondary Icon Button with Tooltip
Tooltip(
  message: 'Edit settings',
  child: ShadIconButton.secondary(
    onPressed: () {
      // Handle button press
    },
    icon: const Icon(LucideIcons.settings),
  ),
)

// Secondary Icon Button with Disabled State
ShadIconButton.secondary(
  onPressed: isDisabled ? null : () {
    // Handle button press
  },
  icon: const Icon(LucideIcons.settings),
)''';
  }

  // Code for destructive icon button
  String _getDestructiveCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Destructive Icon Button
ShadIconButton.destructive(
  onPressed: () {},
  icon: const Icon(LucideIcons.trash2),
)

// Destructive Icon Button with Confirmation
ShadIconButton.destructive(
  onPressed: () {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Perform delete action
              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  },
  icon: const Icon(LucideIcons.trash2),
)

// Destructive Icon Button with Tooltip
Tooltip(
  message: 'Delete item',
  child: ShadIconButton.destructive(
    onPressed: () {
      // Handle delete action
    },
    icon: const Icon(LucideIcons.trash2),
  ),
)

// Destructive Icon Button with Disabled State
ShadIconButton.destructive(
  onPressed: isDisabled ? null : () {
    // Handle delete action
  },
  icon: const Icon(LucideIcons.trash2),
)''';
  }

  // Code for outline icon button
  String _getOutlineCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Outline Icon Button
ShadIconButton.outline(
  onPressed: () {},
  icon: const Icon(LucideIcons.pencil),
)

// Outline Icon Button with Custom Icon
ShadIconButton.outline(
  onPressed: () {
    // Handle button press
  },
  icon: const Icon(
    LucideIcons.download,
    size: 20,
  ),
)

// Outline Icon Button with Tooltip
Tooltip(
  message: 'Download file',
  child: ShadIconButton.outline(
    onPressed: () {
      // Handle download action
    },
    icon: const Icon(LucideIcons.download),
  ),
)

// Outline Icon Button with Disabled State
ShadIconButton.outline(
  onPressed: isDisabled ? null : () {
    // Handle button press
  },
  icon: const Icon(LucideIcons.pencil),
)''';
  }

  // Code for ghost icon button
  String _getGhostCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Ghost Icon Button
ShadIconButton.ghost(
  onPressed: () {},
  icon: const Icon(LucideIcons.heart),
)

// Ghost Icon Button with Custom Icon
ShadIconButton.ghost(
  onPressed: () {
    // Handle button press
  },
  icon: const Icon(
    LucideIcons.bookmark,
    size: 18,
  ),
)

// Ghost Icon Button with Tooltip
Tooltip(
  message: 'Add to favorites',
  child: ShadIconButton.ghost(
    onPressed: () {
      // Handle favorite action
    },
    icon: const Icon(LucideIcons.heart),
  ),
)

// Ghost Icon Button with Disabled State
ShadIconButton.ghost(
  onPressed: isDisabled ? null : () {
    // Handle button press
  },
  icon: const Icon(LucideIcons.heart),
)''';
  }

  // Code for loading icon button
  String _getLoadingCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Loading Icon Button
ShadIconButton(
  onPressed: isLoading ? null : () {
    // Handle button press
  },
  icon: isLoading 
    ? SizedBox.square(
        dimension: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      )
    : const Icon(LucideIcons.rocket),
)

// Loading Icon Button with State Management
class LoadingIconButtonExample extends StatefulWidget {
  @override
  State<LoadingIconButtonExample> createState() => _LoadingIconButtonExampleState();
}

class _LoadingIconButtonExampleState extends State<LoadingIconButtonExample> {
  bool isLoading = false;

  Future<void> _handlePress() async {
    setState(() {
      isLoading = true;
    });
    
    // Simulate async operation
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShadIconButton(
      onPressed: isLoading ? null : _handlePress,
      icon: isLoading 
        ? SizedBox.square(
            dimension: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          )
        : const Icon(LucideIcons.rocket),
    );
  }
}

// Loading Icon Button with Different Sizes
ShadIconButton(
  onPressed: isLoading ? null : () {
    // Handle button press
  },
  icon: isLoading 
    ? SizedBox.square(
        dimension: 20,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      )
    : const Icon(LucideIcons.rocket, size: 20),
)''';
  }
}

/// Primary icon button example widget
class PrimaryIconButtonExample extends StatelessWidget {
  const PrimaryIconButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Primary Icon Button',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Default primary icon button with solid background.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadIconButton(
          onPressed: () {},
          icon: const Icon(LucideIcons.rocket),
        ),
      ],
    );
  }
}

/// Secondary icon button example widget
class SecondaryIconButtonExample extends StatelessWidget {
  const SecondaryIconButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Secondary Icon Button',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Secondary variant icon button with different styling.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadIconButton.secondary(
          icon: const Icon(LucideIcons.settings),
          onPressed: () {},
        ),
      ],
    );
  }
}

/// Destructive icon button example widget
class DestructiveIconButtonExample extends StatelessWidget {
  const DestructiveIconButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Destructive Icon Button',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Destructive variant icon button for dangerous actions.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadIconButton.destructive(
          icon: const Icon(LucideIcons.trash2),
          onPressed: () {},
        ),
      ],
    );
  }
}

/// Outline icon button example widget
class OutlineIconButtonExample extends StatelessWidget {
  const OutlineIconButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Outline Icon Button',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Outline variant icon button with border.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadIconButton.outline(
          icon: const Icon(LucideIcons.pencil),
          onPressed: () {},
        ),
      ],
    );
  }
}

/// Ghost icon button example widget
class GhostIconButtonExample extends StatelessWidget {
  const GhostIconButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Ghost Icon Button',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Ghost variant icon button with minimal styling.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadIconButton.ghost(
          icon: const Icon(LucideIcons.heart),
          onPressed: () {},
        ),
      ],
    );
  }
}

/// Loading icon button example widget
class LoadingIconButtonExample extends StatelessWidget {
  const LoadingIconButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Loading Icon Button',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Icon button with loading indicator.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadIconButton(
          icon: SizedBox.square(
            dimension: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
