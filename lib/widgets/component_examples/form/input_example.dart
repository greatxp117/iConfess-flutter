import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../component_example_interface.dart' as example_interface;

/// Input component implementation using the new architecture
class InputExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'Input';

  @override
  String get description =>
      'A text input component that provides various configurations for text entry, including basic input, password fields, form integration, and custom styling.';

  @override
  String get category => 'Form';

  @override
  List<String> get tags => ['input', 'text', 'form', 'validation'];

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.basic;

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
    'Basic Input': example_interface.ComponentVariant(
      previewBuilder: (context) => const BasicInputExample(),
      code: _getBasicCode(),
    ),
    'Password Input': example_interface.ComponentVariant(
      previewBuilder: (context) => const PasswordInputExample(),
      code: _getPasswordCode(),
    ),
    'Form Field Input': example_interface.ComponentVariant(
      previewBuilder: (context) => const FormFieldInputExample(),
      code: _getFormFieldCode(),
    ),
    'Input with Icons': example_interface.ComponentVariant(
      previewBuilder: (context) => const InputWithIconsExample(),
      code: _getInputWithIconsCode(),
    ),
  };

  @override
  Widget buildPreview(BuildContext context, [String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.previewBuilder(context) ?? const BasicInputExample();
  }

  @override
  String getCode([String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.code ?? _getBasicCode();
  }

  // Code for basic input
  String _getBasicCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Basic Input
ConstrainedBox(
  constraints: const BoxConstraints(maxWidth: 320),
  child: const ShadInput(
    placeholder: Text('Email'),
    keyboardType: TextInputType.emailAddress,
  ),
)

// Basic Input with Controller
class BasicInputExample extends StatefulWidget {
  @override
  State<BasicInputExample> createState() => _BasicInputExampleState();
}

class _BasicInputExampleState extends State<BasicInputExample> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      controller: _controller,
      placeholder: const Text('Enter your name'),
      onChanged: (value) {
        print('Input value changed');
      },
    );
  }
}

// Basic Input with Different Keyboard Types
ShadInput(
  placeholder: const Text('Enter your email'),
  keyboardType: TextInputType.emailAddress,
)

ShadInput(
  placeholder: const Text('Enter your phone number'),
  keyboardType: TextInputType.phone,
)

ShadInput(
  placeholder: const Text('Enter your age'),
  keyboardType: TextInputType.number,
)

// Basic Input with Max Length
ShadInput(
  placeholder: const Text('Enter your username'),
  maxLength: 20,
)''';
  }

  // Code for password input
  String _getPasswordCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Password Input with Toggle
class PasswordInput extends StatefulWidget {
  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      placeholder: const Text('Password'),
      obscureText: obscure,
      leading: const Padding(
        padding: EdgeInsets.all(4.0),
        child: Icon(LucideIcons.lock),
      ),
      trailing: ShadIconButton(
        icon: Icon(obscure ? LucideIcons.eyeOff : LucideIcons.eye),
        onPressed: () {
          setState(() => obscure = !obscure);
        },
      ),
    );
  }
}

// Password Input with Validation
class PasswordInputWithValidation extends StatefulWidget {
  @override
  State<PasswordInputWithValidation> createState() => _PasswordInputWithValidationState();
}

class _PasswordInputWithValidationState extends State<PasswordInputWithValidation> {
  bool obscure = true;
  String? errorText;

  void _validatePassword(String value) {
    setState(() {
      if (value.isEmpty) {
        errorText = null;
      } else if (value.length < 8) {
        errorText = 'Password must be at least 8 characters';
      } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
        errorText = 'Password must contain at least one uppercase letter';
      } else if (!RegExp(r'[0-9]').hasMatch(value)) {
        errorText = 'Password must contain at least one number';
      } else {
        errorText = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      placeholder: const Text('Password'),
      obscureText: obscure,
      leading: const Icon(LucideIcons.lock),
      trailing: ShadIconButton(
        icon: Icon(obscure ? LucideIcons.eyeOff : LucideIcons.eye),
        onPressed: () {
          setState(() => obscure = !obscure);
        },
      ),
      onChanged: _validatePassword,
      errorText: errorText,
    );
  }
}

// Password Input with Strength Indicator
class PasswordInputWithStrength extends StatefulWidget {
  @override
  State<PasswordInputWithStrength> createState() => _PasswordInputWithStrengthState();
}

class _PasswordInputWithStrengthState extends State<PasswordInputWithStrength> {
  bool obscure = true;
  String password = '';
  double strength = 0.0;

  void _calculateStrength(String value) {
    setState(() {
      password = value;
      double score = 0.0;
      
      if (value.length >= 8) score += 0.25;
      if (RegExp(r'[A-Z]').hasMatch(value)) score += 0.25;
      if (RegExp(r'[a-z]').hasMatch(value)) score += 0.25;
      if (RegExp(r'[0-9]').hasMatch(value)) score += 0.25;
      
      strength = score;
    });
  }

  Color _getStrengthColor() {
    if (strength <= 0.25) return Colors.red;
    if (strength <= 0.5) return Colors.orange;
    if (strength <= 0.75) return Colors.yellow;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShadInput(
          placeholder: const Text('Password'),
          obscureText: obscure,
          leading: const Icon(LucideIcons.lock),
          trailing: ShadIconButton(
            icon: Icon(obscure ? LucideIcons.eyeOff : LucideIcons.eye),
            onPressed: () {
              setState(() => obscure = !obscure);
            },
          ),
          onChanged: _calculateStrength,
        ),
        if (password.isNotEmpty) ...[
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: strength,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(_getStrengthColor()),
          ),
        ],
      ],
    );
  }
}''';
  }

  // Code for form field input
  String _getFormFieldCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Form Field Input
ShadInputFormField(
  id: 'username',
  label: const Text('Username'),
  placeholder: const Text('Enter your username'),
    validator: (v) {
    if (v.length < 2) {
      return 'Username must be at least 2 characters.';
    }
    return null;
  },
)

// Form Field Input with Email Validation
ShadInputFormField(
  id: 'email',
  label: const Text('Email'),
  placeholder: const Text('Enter your email'),
    keyboardType: TextInputType.emailAddress,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[^@]+@[^@]+.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  },
)

// Form Field Input with Phone Validation
ShadInputFormField(
  id: 'phone',
  label: const Text('Phone Number'),
  placeholder: const Text('Enter your phone number'),
  keyboardType: TextInputType.phone,
  validator: (value) {
    if (value != null && value.isNotEmpty) {
      if (!RegExp(r'^[0-9-+() ]+').hasMatch(value)) {
        return 'Please enter a valid phone number';
      }
    }
    return null;
  },
)

// Form Field Input with Custom Error Styling
ShadInputFormField(
  id: 'website',
  label: const Text('Website'),
  placeholder: const Text('Enter your website URL'),
  validator: (value) {
    if (value != null && value.isNotEmpty) {
      if (!Uri.tryParse(value)?.hasAbsolutePath ?? false) {
        return 'Please enter a valid URL';
      }
    }
    return null;
  },
)

// Form Field Input with Required Indicator
ShadInputFormField(
  id: 'fullName',
  label: const Text('Full Name *'),
  placeholder: const Text('Enter your full name'),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    if (value.split(' ').length < 2) {
      return 'Please enter your full name';
    }
    return null;
  },
)''';
  }

  // Code for input with icons
  String _getInputWithIconsCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Input with Leading Icon
ShadInput(
  placeholder: const Text('Search...'),
  leading: const Icon(LucideIcons.search),
)

// Input with Trailing Icon
ShadInput(
  placeholder: const Text('Clear me'),
  trailing: ShadIconButton(
    icon: const Icon(LucideIcons.x),
    onPressed: () {
      // Clear input
    },
  ),
)

// Input with Both Icons
ShadInput(
  placeholder: const Text('Enter amount'),
  leading: const Icon(LucideIcons.dollarSign),
  trailing: const Icon(LucideIcons.info),
)

// Input with Custom Leading Widget
ShadInput(
  placeholder: const Text('Enter your username'),
  leading: Container(
    padding: const EdgeInsets.all(8),
    child: const Text('@'),
  ),
)

// Input with Loading Trailing Icon
class InputWithLoadingIcon extends StatefulWidget {
  @override
  State<InputWithLoadingIcon> createState() => _InputWithLoadingIconState();
}

class _InputWithLoadingIconState extends State<InputWithLoadingIcon> {
  bool isLoading = false;

  void _handleSearch(String value) {
    setState(() {
      isLoading = true;
    });
    
    // Simulate search
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      placeholder: const Text('Search...'),
      leading: const Icon(LucideIcons.search),
      trailing: isLoading 
        ? const SizedBox.square(
            dimension: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : ShadIconButton(
            icon: const Icon(LucideIcons.x),
            onPressed: () {
              // Clear input
            },
          ),
      onChanged: _handleSearch,
    );
  }
}

// Input with Multiple Trailing Icons
ShadInput(
  placeholder: const Text('Enter text'),
  trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      ShadIconButton(
        icon: const Icon(LucideIcons.eye),
        onPressed: () {
          // View action
        },
      ),
      ShadIconButton(
        icon: const Icon(LucideIcons.copy),
        onPressed: () {
          // Copy action
        },
      ),
    ],
  ),
)

// Input with Conditional Icons
class InputWithConditionalIcons extends StatefulWidget {
  @override
  State<InputWithConditionalIcons> createState() => _InputWithConditionalIconsState();
}

class _InputWithConditionalIconsState extends State<InputWithConditionalIcons> {
  String inputValue = '';

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      placeholder: const Text('Enter your email'),
      leading: const Icon(LucideIcons.mail),
      trailing: inputValue.isNotEmpty
        ? ShadIconButton(
            icon: const Icon(LucideIcons.check),
            onPressed: () {
              // Validate email
            },
          )
        : null,
      onChanged: (value) {
        setState(() {
          inputValue = value;
        });
      },
    );
  }
}''';
  }
}

/// Basic input example widget
class BasicInputExample extends StatelessWidget {
  const BasicInputExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Basic Input',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Basic text input with placeholder and keyboard type.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: const ShadInput(
            placeholder: Text('Email'),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
      ],
    );
  }
}

/// Password input example widget
class PasswordInputExample extends StatefulWidget {
  const PasswordInputExample({super.key});

  @override
  State<PasswordInputExample> createState() => _PasswordInputExampleState();
}

class _PasswordInputExampleState extends State<PasswordInputExample> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Password Input',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Password input with visibility toggle and lock icon.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: ShadInput(
            placeholder: const Text('Password'),
            obscureText: obscure,
            leading: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(LucideIcons.lock),
            ),
            trailing: ShadIconButton(
              icon: Icon(obscure ? LucideIcons.eyeOff : LucideIcons.eye),
              onPressed: () {
                setState(() => obscure = !obscure);
              },
            ),
          ),
        ),
      ],
    );
  }
}

/// Form field input example widget
class FormFieldInputExample extends StatelessWidget {
  const FormFieldInputExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Form Field Input',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Input with form validation, labels, and descriptions.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: ShadInputFormField(
            id: 'username',
            label: const Text('Username'),
            placeholder: const Text('Enter your username'),
            validator: (v) {
              if (v.length < 2) {
                return 'Username must be at least 2 characters.';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}

/// Input with icons example widget
class InputWithIconsExample extends StatelessWidget {
  const InputWithIconsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Input with Icons',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Input with leading and trailing icons.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: const ShadInput(
            placeholder: Text('Search...'),
            leading: Icon(LucideIcons.search),
            trailing: Icon(LucideIcons.x),
          ),
        ),
      ],
    );
  }
}
