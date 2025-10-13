import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../component_example_interface.dart' as example_interface;

/// Form component implementation using the new architecture
class FormExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'Form';

  @override
  String get description =>
      'A form component that provides a container for form fields with validation, state management, and submission handling for collecting user input.';

  @override
  String get category => 'Form';

  @override
  List<String> get tags => ['input', 'validation', 'state', 'submission'];

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.intermediate;

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
    'Basic Form': example_interface.ComponentVariant(
      previewBuilder: (context) => const BasicFormExample(),
      code: _getBasicCode(),
    ),
    'Form with Validation': example_interface.ComponentVariant(
      previewBuilder: (context) => const ValidationFormExample(),
      code: _getValidationCode(),
    ),
    'Form with Multiple Fields': example_interface.ComponentVariant(
      previewBuilder: (context) => const MultipleFieldsFormExample(),
      code: _getMultipleFieldsCode(),
    ),
    'Form with Custom Fields': example_interface.ComponentVariant(
      previewBuilder: (context) => const CustomFieldsFormExample(),
      code: _getCustomFieldsCode(),
    ),
  };

  @override
  Widget buildPreview(BuildContext context, [String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.previewBuilder(context) ?? const BasicFormExample();
  }

  @override
  String getCode([String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.code ?? _getBasicCode();
  }

  // Code for basic form
  String _getBasicCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Basic Form
class BasicForm extends StatefulWidget {
  @override
  State<BasicForm> createState() => _BasicFormState();
}

class _BasicFormState extends State<BasicForm> {
  
  final formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context) {
    return ShadForm(
      
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ShadInputFormField(
            id: 'username',
            label: const Text('Username'),
            placeholder: const Text('Enter your username'),
            description: const Text('This is your public display name.'),
          ),
          const SizedBox(height: 16),
          ShadButton(
            child: const Text('Submit'),
            onPressed: () {
              
              if (formKey.currentState!.saveAndValidate()) {
                
                debugPrint('Form data submitted');
              }
            },
          ),
        ],
      ),
    );
  }
}

// Basic Form with Constrained Width
class ConstrainedForm extends StatefulWidget {
  @override
  State<ConstrainedForm> createState() => _ConstrainedFormState();
}

class _ConstrainedFormState extends State<ConstrainedForm> {
  final formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context) {
    return ShadForm(
      key: formKey,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 350),
        child: Column(
          children: [
            ShadInputFormField(
              id: 'name',
              label: const Text('Name'),
              placeholder: const Text('Enter your name'),
            ),
            const SizedBox(height: 16),
            ShadButton(
              child: const Text('Submit'),
              onPressed: () {
                if (formKey.currentState!.saveAndValidate()) {
                  // Handle form submission
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}''';
  }

  // Code for validation form
  String _getValidationCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Form with Validation
class ValidationForm extends StatefulWidget {
  @override
  State<ValidationForm> createState() => _ValidationFormState();
}

class _ValidationFormState extends State<ValidationForm> {
  final formKey = GlobalKey<ShadFormState>();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[^@]+@[^@]+.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ShadForm(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ShadInputFormField(
            id: 'email',
            label: const Text('Email'),
            placeholder: const Text('Enter your email'),
                         description: const Text("We'll never share your email with anyone else."),
            validator: _validateEmail,
          ),
          const SizedBox(height: 16),
          ShadInputFormField(
            id: 'password',
            label: const Text('Password'),
            placeholder: const Text('Enter your password'),
            obscureText: true,
            description: const Text('Must be at least 8 characters with uppercase and number.'),
            validator: _validatePassword,
          ),
          const SizedBox(height: 16),
          ShadButton(
            child: const Text('Submit'),
            onPressed: () {
              if (formKey.currentState!.saveAndValidate()) {
                debugPrint('Form submitted successfully');
                debugPrint('Email submitted');
              } else {
                debugPrint('Form validation failed');
              }
            },
          ),
        ],
      ),
    );
  }
}

// Real-time Validation
class RealTimeValidationForm extends StatefulWidget {
  @override
  State<RealTimeValidationForm> createState() => _RealTimeValidationFormState();
}

class _RealTimeValidationFormState extends State<RealTimeValidationForm> {
  final formKey = GlobalKey<ShadFormState>();
  String? emailError;

  void _validateEmail(String value) {
    setState(() {
      if (value.isEmpty) {
        emailError = 'Email is required';
      } else if (!RegExp(r'^[^@]+@[^@]+.[^@]+').hasMatch(value)) {
        emailError = 'Invalid email format';
      } else {
        emailError = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShadForm(
      key: formKey,
      child: Column(
        children: [
          ShadInputFormField(
            id: 'email',
            label: const Text('Email'),
            placeholder: const Text('Enter your email'),
            onChanged: _validateEmail,
            errorText: emailError,
          ),
          const SizedBox(height: 16),
          ShadButton(
            child: const Text('Submit'),
            onPressed: emailError == null ? () {
              if (formKey.currentState!.saveAndValidate()) {
                debugPrint('Form submitted');
              }
            } : null,
          ),
        ],
      ),
    );
  }
}''';
  }

  // Code for multiple fields form
  String _getMultipleFieldsCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Form with Multiple Fields
class MultipleFieldsForm extends StatefulWidget {
  @override
  State<MultipleFieldsForm> createState() => _MultipleFieldsFormState();
}

class _MultipleFieldsFormState extends State<MultipleFieldsForm> {
  final formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context) {
    return ShadForm(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Personal Information Section
          const Text(
            'Personal Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ShadInputFormField(
                  id: 'firstName',
                  label: const Text('First Name'),
                  placeholder: const Text('Enter first name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'First name is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ShadInputFormField(
                  id: 'lastName',
                  label: const Text('Last Name'),
                  placeholder: const Text('Enter last name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Last name is required';
                    }
                    return null;
                  },
                ),
              ),
            ],
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
              if (!RegExp(r'^[^@]+@[^@]+.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          ShadInputFormField(
            id: 'phone',
            label: const Text('Phone Number'),
            placeholder: const Text('Enter phone number'),
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                if (!RegExp(r'^[0-9-+() ]+').hasMatch(value)) {
                  return 'Please enter a valid phone number';
                }
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          
          // Address Section
          const Text(
            'Address',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ShadInputFormField(
            id: 'street',
            label: const Text('Street Address'),
            placeholder: const Text('Enter street address'),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ShadInputFormField(
                  id: 'city',
                  label: const Text('City'),
                  placeholder: const Text('Enter city'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ShadInputFormField(
                  id: 'state',
                  label: const Text('State'),
                  placeholder: const Text('Enter state'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ShadInputFormField(
                  id: 'zipCode',
                  label: const Text('ZIP Code'),
                  placeholder: const Text('Enter ZIP code'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Submit Button
          ShadButton(
            child: const Text('Submit'),
            onPressed: () {
              if (formKey.currentState!.saveAndValidate()) {
                debugPrint('Form submitted successfully');
                debugPrint('Form data submitted');
              } else {
                debugPrint('Form validation failed');
              }
            },
          ),
        ],
      ),
    );
  }
}

// Form with Field Groups
class GroupedForm extends StatefulWidget {
  @override
  State<GroupedForm> createState() => _GroupedFormState();
}

class _GroupedFormState extends State<GroupedForm> {
  final formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context) {
    return ShadForm(
      key: formKey,
      child: Column(
        children: [
          // Account Information Group
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Account Information',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ShadInputFormField(
                  id: 'username',
                  label: const Text('Username'),
                  placeholder: const Text('Choose a username'),
                ),
                const SizedBox(height: 16),
                ShadInputFormField(
                  id: 'password',
                  label: const Text('Password'),
                  placeholder: const Text('Create a password'),
                  obscureText: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Profile Information Group
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profile Information',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ShadInputFormField(
                  id: 'fullName',
                  label: const Text('Full Name'),
                  placeholder: const Text('Enter your full name'),
                ),
                const SizedBox(height: 16),
                ShadInputFormField(
                  id: 'bio',
                  label: const Text('Bio'),
                  placeholder: const Text('Tell us about yourself'),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          ShadButton(
            child: const Text('Create Account'),
            onPressed: () {
              if (formKey.currentState!.saveAndValidate()) {
                debugPrint('Account created successfully');
              }
            },
          ),
        ],
      ),
    );
  }
}''';
  }

  // Code for custom fields form
  String _getCustomFieldsCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Form with Custom Fields
class CustomFieldsForm extends StatefulWidget {
  @override
  State<CustomFieldsForm> createState() => _CustomFieldsFormState();
}

class _CustomFieldsFormState extends State<CustomFieldsForm> {
  final formKey = GlobalKey<ShadFormState>();
  bool agreeToTerms = false;
  String selectedCountry = 'US';
  DateTime? selectedDate;

  final List<String> countries = [
    'US', 'CA', 'UK', 'DE', 'FR', 'JP', 'AU'
  ];

  @override
  Widget build(BuildContext context) {
    return ShadForm(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Basic Input Fields
          ShadInputFormField(
            id: 'name',
            label: const Text('Full Name'),
            placeholder: const Text('Enter your full name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Name is required';
              }
              if (value.split(' ').length < 2) {
                return 'Please enter your full name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          
          // Custom Select Field
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Country', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              ShadSelect<String>(
                placeholder: const Text('Select a country'),
                options: countries.map((country) => 
                  ShadOption(value: country, child: Text(country))
                ).toList(),
                selectedOptionBuilder: (context, value) => Text(value),
                onChanged: (value) {
                  setState(() {
                    selectedCountry = value ?? 'US';
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Custom Date Field
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Date of Birth', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              ShadButton.outline(
                child: Text(selectedDate == null 
                  ? 'Select date' 
                  : 'Date selected'
                ),
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().subtract(const Duration(days: 6570)), // 18 years ago
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() {
                      selectedDate = date;
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Custom Checkbox Field
          Row(
            children: [
              ShadCheckbox(
                value: agreeToTerms,
                onChanged: (value) {
                  setState(() {
                    agreeToTerms = value ?? false;
                  });
                },
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      agreeToTerms = !agreeToTerms;
                    });
                  },
                  child: const Text(
                    'I agree to the Terms of Service and Privacy Policy',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Submit Button with Custom Validation
          ShadButton(
            child: const Text('Submit'),
            onPressed: agreeToTerms ? () {
              if (formKey.currentState!.saveAndValidate()) {
                // Custom validation
                if (selectedDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select your date of birth')),
                  );
                  return;
                }
                
                // Calculate age
                final age = DateTime.now().difference(selectedDate!).inDays ~/ 365;
                if (age < 18) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('You must be at least 18 years old')),
                  );
                  return;
                }
                
                debugPrint('Form submitted successfully');
                debugPrint('Name submitted');
                debugPrint('Country submitted');
                debugPrint('Date of Birth submitted');
                debugPrint('Agreed to Terms submitted');
              }
            } : null,
          ),
        ],
      ),
    );
  }
}

// Form with Conditional Fields
class ConditionalForm extends StatefulWidget {
  @override
  State<ConditionalForm> createState() => _ConditionalFormState();
}

class _ConditionalFormState extends State<ConditionalForm> {
  final formKey = GlobalKey<ShadFormState>();
  bool hasCompany = false;

  @override
  Widget build(BuildContext context) {
    return ShadForm(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ShadInputFormField(
            id: 'name',
            label: const Text('Full Name'),
            placeholder: const Text('Enter your full name'),
          ),
          const SizedBox(height: 16),
          
          // Conditional Company Field
          Row(
            children: [
              ShadCheckbox(
                value: hasCompany,
                onChanged: (value) {
                  setState(() {
                    hasCompany = value ?? false;
                  });
                },
              ),
              const SizedBox(width: 8),
              const Text('I have a company'),
            ],
          ),
          const SizedBox(height: 16),
          
          // Show company field only if checkbox is checked
          if (hasCompany) ...[
            ShadInputFormField(
              id: 'company',
              label: const Text('Company Name'),
              placeholder: const Text('Enter your company name'),
            ),
            const SizedBox(height: 16),
          ],
          
          ShadButton(
            child: const Text('Submit'),
            onPressed: () {
              if (formKey.currentState!.saveAndValidate()) {
                debugPrint('Form submitted');
                debugPrint('Has company submitted');
                if (hasCompany) {
                  debugPrint('Company submitted');
                }
              }
            },
          ),
        ],
      ),
    );
  }
}''';
  }
}

/// Basic form example widget
class BasicFormExample extends StatefulWidget {
  const BasicFormExample({super.key});

  @override
  State<BasicFormExample> createState() => _BasicFormExampleState();
}

class _BasicFormExampleState extends State<BasicFormExample> {
  final formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Basic Form',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Simple form with username input and submit button.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 350),
          child: ShadForm(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ShadInputFormField(
                  id: 'username',
                  label: const Text('Username'),
                  placeholder: const Text('Enter your username'),
                  description: const Text('This is your public display name.'),
                ),
                const SizedBox(height: 16),
                ShadButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    if (formKey.currentState!.saveAndValidate()) {
                      debugPrint('Form data submitted');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Validation form example widget
class ValidationFormExample extends StatefulWidget {
  const ValidationFormExample({super.key});

  @override
  State<ValidationFormExample> createState() => _ValidationFormExampleState();
}

class _ValidationFormExampleState extends State<ValidationFormExample> {
  final formKey = GlobalKey<ShadFormState>();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[^@]+@[^@]+.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Form with Validation',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Form with validation rules and error messages.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 350),
          child: ShadForm(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ShadInputFormField(
                  id: 'email',
                  label: const Text('Email'),
                  placeholder: const Text('Enter your email'),
                  description: const Text(
                    "We'll never share your email with anyone else.",
                  ),
                  validator: _validateEmail,
                ),
                const SizedBox(height: 16),
                ShadInputFormField(
                  id: 'password',
                  label: const Text('Password'),
                  placeholder: const Text('Enter your password'),
                  obscureText: true,
                  description: const Text('Must be at least 8 characters.'),
                  validator: _validatePassword,
                ),
                const SizedBox(height: 16),
                ShadButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    if (formKey.currentState!.saveAndValidate()) {
                      debugPrint('Form submitted successfully');
                    } else {
                      debugPrint('Form validation failed');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Multiple fields form example widget
class MultipleFieldsFormExample extends StatefulWidget {
  const MultipleFieldsFormExample({super.key});

  @override
  State<MultipleFieldsFormExample> createState() =>
      _MultipleFieldsFormExampleState();
}

class _MultipleFieldsFormExampleState extends State<MultipleFieldsFormExample> {
  final formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Form with Multiple Fields',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Complex form with various input types and field groups.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ShadForm(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Personal Information',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ShadInputFormField(
                        id: 'firstName',
                        label: const Text('First Name'),
                        placeholder: const Text('Enter first name'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ShadInputFormField(
                        id: 'lastName',
                        label: const Text('Last Name'),
                        placeholder: const Text('Enter last name'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ShadInputFormField(
                  id: 'email',
                  label: const Text('Email'),
                  placeholder: const Text('Enter your email'),
                ),
                const SizedBox(height: 16),
                ShadInputFormField(
                  id: 'phone',
                  label: const Text('Phone Number'),
                  placeholder: const Text('Enter phone number'),
                ),
                const SizedBox(height: 24),
                ShadButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    if (formKey.currentState!.saveAndValidate()) {
                      debugPrint('Form submitted successfully');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Custom fields form example widget
class CustomFieldsFormExample extends StatefulWidget {
  const CustomFieldsFormExample({super.key});

  @override
  State<CustomFieldsFormExample> createState() =>
      _CustomFieldsFormExampleState();
}

class _CustomFieldsFormExampleState extends State<CustomFieldsFormExample> {
  final formKey = GlobalKey<ShadFormState>();
  bool agreeToTerms = false;
  String selectedCountry = 'US';

  final List<String> countries = ['US', 'CA', 'UK', 'DE', 'FR'];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Form with Custom Fields',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Form with custom field types and advanced validation.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 350),
          child: ShadForm(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ShadInputFormField(
                  id: 'name',
                  label: const Text('Full Name'),
                  placeholder: const Text('Enter your full name'),
                ),
                const SizedBox(height: 16),

                // Custom Select Field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Country',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ShadSelect<String>(
                      placeholder: const Text('Select a country'),
                      options: countries
                          .map(
                            (country) => ShadOption(
                              value: country,
                              child: Text(country),
                            ),
                          )
                          .toList(),
                      selectedOptionBuilder: (context, value) => Text(value),
                      onChanged: (value) {
                        setState(() {
                          selectedCountry = value ?? 'US';
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Custom Checkbox Field
                Row(
                  children: [
                    ShadCheckbox(
                      value: agreeToTerms,
                      onChanged: (value) {
                        setState(() {
                          agreeToTerms = value;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            agreeToTerms = !agreeToTerms;
                          });
                        },
                        child: const Text(
                          'I agree to the Terms of Service',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                ShadButton(
                  onPressed: agreeToTerms
                      ? () {
                          if (formKey.currentState!.saveAndValidate()) {
                            debugPrint('Form submitted successfully');
                            debugPrint('Country submitted');
                            debugPrint('Agreed to Terms submitted');
                          }
                        }
                      : null,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
