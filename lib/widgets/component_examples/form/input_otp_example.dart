import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../component_example_interface.dart' as example_interface;

/// InputOTP component implementation using the new architecture
class InputOTPExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'InputOTP';

  @override
  String get description =>
      'A one-time password input component that provides individual input slots for entering verification codes, PINs, or other short numeric/alphanumeric codes.';

  @override
  String get category => 'Form';

  @override
  List<String> get tags => ['otp', 'verification', 'pin', 'code', 'input'];

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.intermediate;

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
        'Basic OTP': example_interface.ComponentVariant(
          previewBuilder: (context) => const BasicInputOTPExample(),
          code: _getBasicCode(),
        ),
        'Numeric OTP': example_interface.ComponentVariant(
          previewBuilder: (context) => const NumericInputOTPExample(),
          code: _getNumericCode(),
        ),
        'Form Field OTP': example_interface.ComponentVariant(
          previewBuilder: (context) => const FormFieldInputOTPExample(),
          code: _getFormFieldCode(),
        ),
        'Custom OTP': example_interface.ComponentVariant(
          previewBuilder: (context) => const CustomInputOTPExample(),
          code: _getCustomCode(),
        ),
      };

  @override
  Widget buildPreview(BuildContext context, [String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.previewBuilder(context) ?? const BasicInputOTPExample();
  }

  @override
  String getCode([String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.code ?? _getBasicCode();
  }

  // Code for basic OTP
  String _getBasicCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Basic OTP Input
ShadInputOTP(
  onChanged: (value) {
    // Handle OTP value changes here
  },
  maxLength: 6,
  children: const [
    ShadInputOTPGroup(
      children: [
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
      ],
    ),
    Icon(size: 24, LucideIcons.dot),
    ShadInputOTPGroup(
      children: [
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
      ],
    ),
  ],
)

// Basic OTP with State Management
class BasicOTPExample extends StatefulWidget {
  @override
  State<BasicOTPExample> createState() => _BasicOTPExampleState();
}

class _BasicOTPExampleState extends State<BasicOTPExample> {
  String otpValue = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShadInputOTP(
          onChanged: (value) {
            setState(() {
              otpValue = value;
            });
          },
          maxLength: 6,
          children: const [
            ShadInputOTPGroup(
              children: [
                ShadInputOTPSlot(),
                ShadInputOTPSlot(),
                ShadInputOTPSlot(),
              ],
            ),
            Icon(size: 24, LucideIcons.dot),
            ShadInputOTPGroup(
              children: [
                ShadInputOTPSlot(),
                ShadInputOTPSlot(),
                ShadInputOTPSlot(),
              ],
            ),
          ],
        ),
        if (otpValue.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            'OTP entered',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ],
    );
  }
}

// Basic OTP with Different Separators
ShadInputOTP(
  onChanged: (value) => print('OTP changed'),
  maxLength: 6,
  children: const [
    ShadInputOTPGroup(
      children: [
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
      ],
    ),
    Text('-', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    ShadInputOTPGroup(
      children: [
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
      ],
    ),
  ],
)

// Basic OTP with Custom Styling
ShadInputOTP(
  onChanged: (value) => print('OTP changed'),
  maxLength: 6,
  children: const [
    ShadInputOTPGroup(
      children: [
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
      ],
    ),
    SizedBox(width: 16),
    ShadInputOTPGroup(
      children: [
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
      ],
    ),
  ],
)''';
  }

  // Code for numeric OTP
  String _getNumericCode() {
    return '''import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Numeric OTP Input
ShadInputOTP(
  onChanged: (value) => print('OTP changed'),
  maxLength: 4,
  keyboardType: TextInputType.number,
  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
  ],
  children: const [
    ShadInputOTPGroup(
      children: [
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
      ],
    ),
  ],
)

// Numeric OTP with State Management
class NumericOTPExample extends StatefulWidget {
  @override
  State<NumericOTPExample> createState() => _NumericOTPExampleState();
}

class _NumericOTPExampleState extends State<NumericOTPExample> {
  String otpValue = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShadInputOTP(
          onChanged: (value) {
            setState(() {
              otpValue = value;
            });
          },
          maxLength: 4,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          children: const [
            ShadInputOTPGroup(
              children: [
                ShadInputOTPSlot(),
                ShadInputOTPSlot(),
                ShadInputOTPSlot(),
                ShadInputOTPSlot(),
              ],
            ),
          ],
        ),
        if (otpValue.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            'OTP entered',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ],
    );
  }
}

// Numeric OTP with Auto-submit
class NumericOTPWithAutoSubmit extends StatefulWidget {
  @override
  State<NumericOTPWithAutoSubmit> createState() => _NumericOTPWithAutoSubmitState();
}

class _NumericOTPWithAutoSubmitState extends State<NumericOTPWithAutoSubmit> {
  String otpValue = '';

  void _handleOTPChange(String value) {
    setState(() {
      otpValue = value;
    });
    
    // Auto-submit when all digits are entered
    if (value.length == 4) {
      _submitOTP(value);
    }
  }

  void _submitOTP(String otp) {
    print('Submitting OTP');
    // Handle OTP submission
  }

  @override
  Widget build(BuildContext context) {
    return ShadInputOTP(
      onChanged: _handleOTPChange,
      maxLength: 4,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      children: const [
        ShadInputOTPGroup(
          children: [
            ShadInputOTPSlot(),
            ShadInputOTPSlot(),
            ShadInputOTPSlot(),
            ShadInputOTPSlot(),
          ],
        ),
      ],
    );
  }
}

// Numeric OTP with Custom Formatters
ShadInputOTP(
  onChanged: (value) => print('OTP changed'),
  maxLength: 6,
  keyboardType: TextInputType.number,
  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(6),
  ],
  children: const [
    ShadInputOTPGroup(
      children: [
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
      ],
    ),
    Icon(size: 24, LucideIcons.dot),
    ShadInputOTPGroup(
      children: [
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
      ],
    ),
  ],
)''';
  }

  // Code for form field OTP
  String _getFormFieldCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Form Field OTP Input
ShadInputOTPFormField(
  id: 'otp',
  maxLength: 6,
  label: const Text('OTP'),
    validator: (value) {
    if (value.contains(' ')) {
      return 'Fill the whole OTP code';
    }
    return null;
  },
  children: const [
    ShadInputOTPGroup(
      children: [
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
      ],
    ),
    Icon(size: 24, LucideIcons.dot),
    ShadInputOTPGroup(
      children: [
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
      ],
    ),
  ],
)

// Form Field OTP with Custom Validation
ShadInputOTPFormField(
  id: 'otp',
  maxLength: 6,
  label: const Text('Verification Code'),
    validator: (value) {
    if (value == null || value.isEmpty) {
      return 'OTP is required';
    }
    if (value.length < 6) {
      return 'Please enter the complete 6-digit code';
    }
    if (value.contains(' ')) {
      return 'Please fill all slots';
    }
    return null;
  },
  children: const [
    ShadInputOTPGroup(
      children: [
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
      ],
    ),
    Icon(size: 24, LucideIcons.dot),
    ShadInputOTPGroup(
      children: [
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
      ],
    ),
  ],
)

// Form Field OTP with Form Integration
class OTPFormExample extends StatefulWidget {
  @override
  State<OTPFormExample> createState() => _OTPFormExampleState();
}

class _OTPFormExampleState extends State<OTPFormExample> {
  final formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context) {
    return ShadForm(
      key: formKey,
      child: Column(
        children: [
          ShadInputOTPFormField(
            id: 'otp',
            maxLength: 6,
            label: const Text('OTP'),
                        validator: (value) {
              if (value.contains(' ')) {
                return 'Fill the whole OTP code';
              }
              return null;
            },
            children: const [
              ShadInputOTPGroup(
                children: [
                  ShadInputOTPSlot(),
                  ShadInputOTPSlot(),
                  ShadInputOTPSlot(),
                ],
              ),
              Icon(size: 24, LucideIcons.dot),
              ShadInputOTPGroup(
                children: [
                  ShadInputOTPSlot(),
                  ShadInputOTPSlot(),
                  ShadInputOTPSlot(),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ShadButton(
            child: const Text('Verify OTP'),
            onPressed: () {
              if (formKey.currentState!.saveAndValidate()) {
                debugPrint('OTP submitted');
              }
            },
          ),
        ],
      ),
    );
  }
}

// Form Field OTP with Resend Functionality
class OTPFormWithResend extends StatefulWidget {
  @override
  State<OTPFormWithResend> createState() => _OTPFormWithResendState();
}

class _OTPFormWithResendState extends State<OTPFormWithResend> {
  final formKey = GlobalKey<ShadFormState>();
  bool canResend = true;
  int resendCountdown = 0;

  void _startResendCountdown() {
    setState(() {
      canResend = false;
      resendCountdown = 30;
    });
    
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        resendCountdown--;
      });
      
      if (resendCountdown <= 0) {
        setState(() {
          canResend = true;
        });
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShadForm(
      key: formKey,
      child: Column(
        children: [
          ShadInputOTPFormField(
            id: 'otp',
            maxLength: 6,
            label: const Text('OTP'),
                        validator: (value) {
              if (value.contains(' ')) {
                return 'Fill the whole OTP code';
              }
              return null;
            },
            children: const [
              ShadInputOTPGroup(
                children: [
                  ShadInputOTPSlot(),
                  ShadInputOTPSlot(),
                  ShadInputOTPSlot(),
                ],
              ),
              Icon(size: 24, LucideIcons.dot),
              ShadInputOTPGroup(
                children: [
                  ShadInputOTPSlot(),
                  ShadInputOTPSlot(),
                  ShadInputOTPSlot(),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ShadButton(
                  child: const Text('Verify OTP'),
                  onPressed: () {
                    if (formKey.currentState!.saveAndValidate()) {
                      debugPrint('OTP submitted');
                    }
                  },
                ),
              ),
              const SizedBox(width: 16),
              TextButton(
                onPressed: canResend ? _startResendCountdown : null,
                child: Text(
                  canResend ? 'Resend OTP' : 'Resend in countdown',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}''';
  }

  // Code for custom OTP
  String _getCustomCode() {
    return '''import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Custom OTP with Different Layout
ShadInputOTP(
  onChanged: (value) => print('OTP changed'),
  maxLength: 8,
  children: const [
    ShadInputOTPGroup(
      children: [
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
      ],
    ),
    SizedBox(height: 16),
    ShadInputOTPGroup(
      children: [
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
      ],
    ),
  ],
)

// Custom OTP with Different Separators
ShadInputOTP(
  onChanged: (value) => print('OTP changed'),
  maxLength: 6,
  children: const [
    ShadInputOTPSlot(),
    Text('-'),
    ShadInputOTPSlot(),
    Text('-'),
    ShadInputOTPSlot(),
    Text('-'),
    ShadInputOTPSlot(),
    Text('-'),
    ShadInputOTPSlot(),
    Text('-'),
    ShadInputOTPSlot(),
  ],
)

// Custom OTP with Icons
ShadInputOTP(
  onChanged: (value) => print('OTP changed'),
  maxLength: 6,
  children: const [
    ShadInputOTPGroup(
      children: [
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
      ],
    ),
    Icon(LucideIcons.star, size: 16),
    ShadInputOTPGroup(
      children: [
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
      ],
    ),
  ],
)

// Custom OTP with Conditional Styling
class CustomOTPExample extends StatefulWidget {
  @override
  State<CustomOTPExample> createState() => _CustomOTPExampleState();
}

class _CustomOTPExampleState extends State<CustomOTPExample> {
  String otpValue = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShadInputOTP(
          onChanged: (value) {
            setState(() {
              otpValue = value;
            });
          },
          maxLength: 6,
          children: const [
            ShadInputOTPGroup(
              children: [
                ShadInputOTPSlot(),
                ShadInputOTPSlot(),
                ShadInputOTPSlot(),
              ],
            ),
            Icon(size: 24, LucideIcons.dot),
            ShadInputOTPGroup(
              children: [
                ShadInputOTPSlot(),
                ShadInputOTPSlot(),
                ShadInputOTPSlot(),
              ],
            ),
          ],
        ),
        if (otpValue.isNotEmpty) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: otpValue.length == 6 ? Colors.green.shade50 : Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: otpValue.length == 6 ? Colors.green : Colors.orange,
              ),
            ),
            child: Text(
              otpValue.length == 6 ? 'Complete!' : 'More digits remaining',
              style: TextStyle(
                color: otpValue.length == 6 ? Colors.green : Colors.orange,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// Custom OTP with Auto-focus
class CustomOTPWithAutoFocus extends StatefulWidget {
  @override
  State<CustomOTPWithAutoFocus> createState() => _CustomOTPWithAutoFocusState();
}

class _CustomOTPWithAutoFocusState extends State<CustomOTPWithAutoFocus> {
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadInputOTP(
      onChanged: (value) {
        // Auto-focus next slot
        if (value.length < 6) {
          _focusNodes[value.length].requestFocus();
        }
      },
      maxLength: 6,
      children: [
        ShadInputOTPGroup(
          children: [
            ShadInputOTPSlot(focusNode: _focusNodes[0]),
            ShadInputOTPSlot(focusNode: _focusNodes[1]),
            ShadInputOTPSlot(focusNode: _focusNodes[2]),
          ],
        ),
        const Icon(size: 24, LucideIcons.dot),
        ShadInputOTPGroup(
          children: [
            ShadInputOTPSlot(focusNode: _focusNodes[3]),
            ShadInputOTPSlot(focusNode: _focusNodes[4]),
            ShadInputOTPSlot(focusNode: _focusNodes[5]),
          ],
        ),
      ],
    );
  }
}''';
  }
}

/// Basic OTP example widget
class BasicInputOTPExample extends StatefulWidget {
  const BasicInputOTPExample({super.key});

  @override
  State<BasicInputOTPExample> createState() => _BasicInputOTPExampleState();
}

class _BasicInputOTPExampleState extends State<BasicInputOTPExample> {
  String otpValue = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Basic Input OTP',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'OTP input with grouped slots and dot separator.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadInputOTP(
          onChanged: (v) {
            setState(() {
              otpValue = v;
            });
          },
          maxLength: 6,
          children: const [
            ShadInputOTPGroup(
              children: [
                ShadInputOTPSlot(),
                ShadInputOTPSlot(),
                ShadInputOTPSlot(),
              ],
            ),
            Icon(size: 24, LucideIcons.dot),
            ShadInputOTPGroup(
              children: [
                ShadInputOTPSlot(),
                ShadInputOTPSlot(),
                ShadInputOTPSlot(),
              ],
            ),
          ],
        ),
        if (otpValue.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            'OTP entered',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ],
    );
  }
}

/// Numeric OTP example widget
class NumericInputOTPExample extends StatefulWidget {
  const NumericInputOTPExample({super.key});

  @override
  State<NumericInputOTPExample> createState() => _NumericInputOTPExampleState();
}

class _NumericInputOTPExampleState extends State<NumericInputOTPExample> {
  String otpValue = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Numeric Input OTP',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Numeric-only OTP input with formatters.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadInputOTP(
          onChanged: (v) {
            setState(() {
              otpValue = v;
            });
          },
          maxLength: 4,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          children: const [
            ShadInputOTPGroup(
              children: [
                ShadInputOTPSlot(),
                ShadInputOTPSlot(),
                ShadInputOTPSlot(),
                ShadInputOTPSlot(),
              ],
            ),
          ],
        ),
        if (otpValue.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            'OTP entered',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ],
    );
  }
}

/// Form field OTP example widget
class FormFieldInputOTPExample extends StatelessWidget {
  const FormFieldInputOTPExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Form Field Input OTP',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'OTP input with form validation and labels.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadInputOTPFormField(
          id: 'otp',
          maxLength: 6,
          label: const Text('OTP'),
          validator: (v) {
            if (v.contains(' ')) {
              return 'Fill the whole OTP code';
            }
            return null;
          },
          children: const [
            ShadInputOTPGroup(
              children: [
                ShadInputOTPSlot(),
                ShadInputOTPSlot(),
                ShadInputOTPSlot(),
              ],
            ),
            Icon(size: 24, LucideIcons.dot),
            ShadInputOTPGroup(
              children: [
                ShadInputOTPSlot(),
                ShadInputOTPSlot(),
                ShadInputOTPSlot(),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// Custom OTP example widget
class CustomInputOTPExample extends StatefulWidget {
  const CustomInputOTPExample({super.key});

  @override
  State<CustomInputOTPExample> createState() => _CustomInputOTPExampleState();
}

class _CustomInputOTPExampleState extends State<CustomInputOTPExample> {
  String otpValue = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Custom Input OTP',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Custom OTP input with different layouts and styling.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadInputOTP(
          onChanged: (v) {
            setState(() {
              otpValue = v;
            });
          },
          maxLength: 6,
          children: const [
            ShadInputOTPSlot(),
            Text('-'),
            ShadInputOTPSlot(),
            Text('-'),
            ShadInputOTPSlot(),
            Text('-'),
            ShadInputOTPSlot(),
            Text('-'),
            ShadInputOTPSlot(),
            Text('-'),
            ShadInputOTPSlot(),
          ],
        ),
        if (otpValue.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            'OTP entered',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ],
    );
  }
}
