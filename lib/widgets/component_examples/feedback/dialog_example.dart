import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../component_example_interface.dart' as example_interface;

/// Dialog component implementation using the new architecture
class DialogExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'Dialog';

  @override
  String get description =>
      'A modal dialog that interrupts the user with important content and waits for a response, providing a consistent design system implementation.';

  @override
  String get category => 'Feedback';

  @override
  List<String> get tags => ['modal', 'overlay', 'interaction', 'confirmation'];

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.intermediate;

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
    'Basic Dialog': example_interface.ComponentVariant(
      previewBuilder: (context) => _buildBasicDialog(context),
      code: _getBasicCode(),
    ),
    'Alert Dialog': example_interface.ComponentVariant(
      previewBuilder: (context) => _buildAlertDialog(context),
      code: _getAlertCode(),
    ),
    'Form Dialog': example_interface.ComponentVariant(
      previewBuilder: (context) => _buildFormDialog(context),
      code: _getFormCode(),
    ),
    'Confirmation Dialog': example_interface.ComponentVariant(
      previewBuilder: (context) => _buildConfirmationDialog(context),
      code: _getConfirmationCode(),
    ),
  };

  @override
  Widget buildPreview(BuildContext context, [String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.previewBuilder(context) ?? _buildBasicDialog(context);
  }

  @override
  String getCode([String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.code ?? _getBasicCode();
  }

  // Basic dialog preview
  Widget _buildBasicDialog(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShadButton.outline(
          child: const Text('Open Basic Dialog'),
          onPressed: () {
            showShadDialog(
              context: context,
              builder: (context) => ShadDialog(
                title: const Text('Basic Dialog'),
                description: const Text(
                  'This is a basic dialog with title, description, and action buttons.',
                ),
                actions: [
                  ShadButton.outline(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  ShadButton(
                    child: const Text('Confirm'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // Alert dialog preview
  Widget _buildAlertDialog(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShadButton.outline(
          child: const Text('Open Alert Dialog'),
          onPressed: () {
            showShadDialog(
              context: context,
              builder: (context) => ShadDialog.alert(
                title: const Text('Are you absolutely sure?'),
                description: const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
                  ),
                ),
                actions: [
                  ShadButton.outline(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  ShadButton(
                    child: const Text('Continue'),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // Form dialog preview
  Widget _buildFormDialog(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShadButton.outline(
          child: const Text('Open Form Dialog'),
          onPressed: () {
            showShadDialog(
              context: context,
              builder: (context) => ShadDialog(
                title: const Text('Edit Profile'),
                description: const Text(
                  'Make changes to your profile here. Click save when you\'re done',
                ),
                actions: [
                  ShadButton.outline(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const ShadButton(child: Text('Save changes')),
                ],
                child: Container(
                  width: 375,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text('Name'),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: ShadInput(
                              placeholder: Text('Enter your name'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Text('Username'),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: ShadInput(
                              placeholder: Text('Enter username'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // Confirmation dialog preview
  Widget _buildConfirmationDialog(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShadButton.outline(
          child: const Text('Open Confirmation Dialog'),
          onPressed: () {
            showShadDialog(
              context: context,
              builder: (context) => ShadDialog.alert(
                title: const Text('Delete Item'),
                description: const Text(
                  'Are you sure you want to delete this item? This action cannot be undone.',
                ),
                actions: [
                  ShadButton.outline(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  ShadButton.destructive(
                    child: const Text('Delete'),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // Code for basic dialog
  String _getBasicCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Basic Dialog
ShadButton.outline(
  child: const Text('Open Dialog'),
  onPressed: () {
    showShadDialog(
      context: context,
      builder: (context) => ShadDialog(
        title: const Text('Basic Dialog'),
        description, and action buttons.'),
        actions: [
          ShadButton.outline(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ShadButton(
            child: const Text('Confirm'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  },
)

// Dialog with Custom Content
showShadDialog(
  context: context,
  builder: (context) => ShadDialog(
    title: const Text('Custom Content'),
        actions: [
      ShadButton.outline(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      ),
      ShadButton(
        child: const Text('Save'),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ],
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Custom content goes here'),
          SizedBox(height: 8),
          Text('You can put any widgets in this area'),
        ],
      ),
    ),
  ),
)''';
  }

  // Code for alert dialog
  String _getAlertCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Alert Dialog
ShadButton.outline(
  child: const Text('Show Alert'),
  onPressed: () {
    showShadDialog(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: const Text('Are you absolutely sure?'),
        description: const Text(
          'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
        ),
        actions: [
          ShadButton.outline(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          ShadButton(
            child: const Text('Continue'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  },
)

// Alert Dialog with Destructive Action
showShadDialog(
  context: context,
  builder: (context) => ShadDialog.alert(
    title: const Text('Delete Account'),
        actions: [
      ShadButton.outline(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(false),
      ),
      ShadButton.destructive(
        child: const Text('Delete'),
        onPressed: () => Navigator.of(context).pop(true),
      ),
    ],
  ),
)

// Alert Dialog with Custom Styling
showShadDialog(
  context: context,
  builder: (context) => ShadDialog.alert(
    title: const Text('Warning'),
    description: const Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text('This is a warning message with custom padding.'),
    ),
    actions: [
      ShadButton.outline(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      ),
      ShadButton(
        child: const Text('Proceed'),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ],
  ),
)''';
  }

  // Code for form dialog
  String _getFormCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Form Dialog
ShadButton.outline(
  child: const Text('Edit Profile'),
  onPressed: () {
    showShadDialog(
      context: context,
      builder: (context) => ShadDialog(
        title: const Text('Edit Profile'),
                actions: [
          ShadButton.outline(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const ShadButton(child: Text('Save changes')),
        ],
        child: Container(
          width: 375,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text('Name'),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: ShadInput(placeholder: Text('Enter your name')),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text('Username'),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: ShadInput(placeholder: Text('Enter username')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  },
)

// Form Dialog with Validation
class FormDialogExample extends StatefulWidget {
  @override
  State<FormDialogExample> createState() => _FormDialogExampleState();
}

class _FormDialogExampleState extends State<FormDialogExample> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _showFormDialog() {
    showShadDialog(
      context: context,
      builder: (context) => ShadDialog(
        title: const Text('Add User'),
                actions: [
          ShadButton.outline(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ShadButton(
            child: const Text('Add'),
            onPressed: () {
              // Validate and save
              if (nameController.text.isNotEmpty && emailController.text.isNotEmpty) {
                Navigator.of(context).pop({
                  'name': nameController.text,
                  'email': emailController.text,
                });
              }
            },
          ),
        ],
        child: Container(
          width: 400,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ShadInput(
                controller: nameController,
                placeholder: const Text('Enter name'),
              ),
              const SizedBox(height: 16),
              ShadInput(
                controller: emailController,
                placeholder: const Text('Enter email'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShadButton.outline(
      child: const Text('Add User'),
      onPressed: _showFormDialog,
    );
  }
}''';
  }

  // Code for confirmation dialog
  String _getConfirmationCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Confirmation Dialog
ShadButton.outline(
  child: const Text('Delete Item'),
  onPressed: () {
    showShadDialog(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: const Text('Delete Item'),
                actions: [
          ShadButton.outline(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          ShadButton.destructive(
            child: const Text('Delete'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  },
)

// Confirmation Dialog with Result Handling
Future<bool?> _showConfirmationDialog(BuildContext context) {
  return showShadDialog<bool>(
    context: context,
    builder: (context) => ShadDialog.alert(
      title: const Text('Confirm Action'),
            actions: [
        ShadButton.outline(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        ShadButton(
          child: const Text('Confirm'),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );
}

// Usage with Result Handling
ShadButton.outline(
  child: const Text('Perform Action'),
  onPressed: () async {
    final confirmed = await _showConfirmationDialog(context);
    if (confirmed == true) {
      // Perform the action
      print('Action confirmed');
    } else {
      // Action cancelled
      print('Action cancelled');
    }
  },
)

// Confirmation Dialog with Custom Actions
showShadDialog(
  context: context,
  builder: (context) => ShadDialog.alert(
    title: const Text('Save Changes'),
        actions: [
      ShadButton.outline(
        child: const Text("Don't Save"),
        onPressed: () => Navigator.of(context).pop('dont_save'),
      ),
      ShadButton.outline(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(context).pop('cancel'),
      ),
      ShadButton(
        child: const Text('Save'),
        onPressed: () => Navigator.of(context).pop('save'),
      ),
    ],
  ),
)''';
  }
}
