import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../component_example_interface.dart' as example_interface;

class TabsExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'Tabs';

  @override
  String get description => 'Organize content into multiple panels';

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.intermediate;

  @override
  String get category => 'Navigation';

  @override
  List<String> get tags => ['navigation', 'tabs', 'panels', 'content'];

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
    'Account': example_interface.ComponentVariant(
      previewBuilder: (context) => const AccountTabsExample(),
      code: _getAccountCode(),
    ),
    'Settings': example_interface.ComponentVariant(
      previewBuilder: (context) => const SettingsTabsExample(),
      code: _getSettingsCode(),
    ),
    'Documentation': example_interface.ComponentVariant(
      previewBuilder: (context) => const DocumentationTabsExample(),
      code: _getDocumentationCode(),
    ),
    'Custom Tabs': example_interface.ComponentVariant(
      previewBuilder: (context) => const CustomTabsExample(),
      code: _getCustomCode(),
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

  String _getAccountCode() {
    return '''class AccountTabsExample extends StatelessWidget {
  const AccountTabsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Account Tabs',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A tabbed interface for account and password management.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadTabs<String>(
          value: 'account',
          tabBarConstraints: const BoxConstraints(maxWidth: 400),
          contentConstraints: const BoxConstraints(maxWidth: 400),
          tabs: [
            ShadTab(
              value: 'account',
              content: ShadCard(
                title: const Text('Account'),
                description: const Text(
                    "Make changes to your account here. Click save when you're done."),
                footer: const ShadButton(child: Text('Save changes')),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16),
                    ShadInputFormField(
                      label: const Text('Name'),
                      initialValue: 'Ale',
                    ),
                    const SizedBox(height: 8),
                    ShadInputFormField(
                      label: const Text('Username'),
                      initialValue: 'nank1ro',
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              child: const Text('Account'),
            ),
            ShadTab(
              value: 'password',
              content: ShadCard(
                title: const Text('Password'),
                description: const Text(
                    "Change your password here. After saving, you'll be logged out."),
                footer: const ShadButton(child: Text('Save password')),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    ShadInputFormField(
                      label: const Text('Current password'),
                      obscureText: true,
                    ),
                    const SizedBox(height: 8),
                    ShadInputFormField(
                      label: const Text('New password'),
                      obscureText: true,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              child: const Text('Password'),
            ),
          ],
        ),
      ],
    );
  }
}''';
  }

  String _getSettingsCode() {
    return '''class SettingsTabsExample extends StatelessWidget {
  const SettingsTabsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Settings Tabs',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A tabbed interface for application settings.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadTabs<String>(
          value: 'general',
          tabBarConstraints: const BoxConstraints(maxWidth: 400),
          contentConstraints: const BoxConstraints(maxWidth: 400),
          tabs: [
            ShadTab(
              value: 'general',
              content: ShadCard(
                title: const Text('General'),
                                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16),
                    ShadSwitchFormField(
                      id: 'notifications',
                      initialValue: true,
                      inputLabel: const Text('Enable notifications'),
                      onChanged: (v) {},
                    ),
                    const SizedBox(height: 8),
                    ShadSwitchFormField(
                      id: 'darkMode',
                      initialValue: false,
                      inputLabel: const Text('Dark mode'),
                      onChanged: (v) {},
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              child: const Text('General'),
            ),
            ShadTab(
              value: 'privacy',
              content: ShadCard(
                title: const Text('Privacy'),
                                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    ShadSwitchFormField(
                      id: 'analytics',
                      initialValue: false,
                      inputLabel: const Text('Allow analytics'),
                      onChanged: (v) {},
                    ),
                    const SizedBox(height: 8),
                    ShadSwitchFormField(
                      id: 'cookies',
                      initialValue: true,
                      inputLabel: const Text('Accept cookies'),
                      onChanged: (v) {},
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              child: const Text('Privacy'),
            ),
          ],
        ),
      ],
    );
  }
}''';
  }

  String _getDocumentationCode() {
    return '''class DocumentationTabsExample extends StatelessWidget {
  const DocumentationTabsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Documentation Tabs',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A tabbed interface for documentation sections.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadTabs<String>(
          value: 'overview',
          tabBarConstraints: const BoxConstraints(maxWidth: 400),
          contentConstraints: const BoxConstraints(maxWidth: 400),
          tabs: [
            ShadTab(
              value: 'overview',
              content: ShadCard(
                title: const Text('Overview'),
                                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'This component provides a way to organize content into multiple panels. Use it when you have related content that can be grouped into categories.',
                  ),
                ),
              ),
              child: const Text('Overview'),
            ),
            ShadTab(
              value: 'examples',
              content: ShadCard(
                title: const Text('Examples'),
                                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'ShadTabs<String>(\n  value: \'account\',\n  tabs: [\n    ShadTab(\n      value: \'account\',\n      content: YourContent(),\n      child: Text(\'Account\'),\n    ),\n  ],\n)',
                    style: TextStyle(fontFamily: 'monospace'),
                  ),
                ),
              ),
              child: const Text('Examples'),
            ),
          ],
        ),
      ],
    );
  }
}''';
  }

  String _getCustomCode() {
    return '''class CustomTabsExample extends StatelessWidget {
  const CustomTabsExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Custom Tabs',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A tabbed interface with custom styling and content.',
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
          child: ShadTabs<String>(
            value: 'design',
            tabBarConstraints: const BoxConstraints(maxWidth: 350),
            contentConstraints: const BoxConstraints(maxWidth: 350),
            tabs: [
              ShadTab(
                value: 'design',
                content: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Design System',
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Our comprehensive design system provides consistent components and patterns.',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                child: const Text('Design'),
              ),
              ShadTab(
                value: 'components',
                content: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Components',
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Reusable UI components built with accessibility and performance in mind.',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                child: const Text('Components'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}''';
  }
}

// Widget implementations
class AccountTabsExample extends StatelessWidget {
  const AccountTabsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Account Tabs',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A tabbed interface for account and password management.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadTabs<String>(
          value: 'account',
          tabBarConstraints: const BoxConstraints(maxWidth: 400),
          contentConstraints: const BoxConstraints(maxWidth: 400),
          tabs: [
            ShadTab(
              value: 'account',
              content: ShadCard(
                title: const Text('Account'),
                description: const Text(
                  "Make changes to your account here. Click save when you're done.",
                ),
                footer: const ShadButton(child: Text('Save changes')),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16),
                    ShadInputFormField(
                      label: const Text('Name'),
                      initialValue: 'Ale',
                    ),
                    const SizedBox(height: 8),
                    ShadInputFormField(
                      label: const Text('Username'),
                      initialValue: 'nank1ro',
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              child: const Text('Account'),
            ),
            ShadTab(
              value: 'password',
              content: ShadCard(
                title: const Text('Password'),
                description: const Text(
                  "Change your password here. After saving, you'll be logged out.",
                ),
                footer: const ShadButton(child: Text('Save password')),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    ShadInputFormField(
                      label: const Text('Current password'),
                      obscureText: true,
                    ),
                    const SizedBox(height: 8),
                    ShadInputFormField(
                      label: const Text('New password'),
                      obscureText: true,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              child: const Text('Password'),
            ),
          ],
        ),
      ],
    );
  }
}

class SettingsTabsExample extends StatelessWidget {
  const SettingsTabsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Settings Tabs',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A tabbed interface for application settings.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadTabs<String>(
          value: 'general',
          tabBarConstraints: const BoxConstraints(maxWidth: 400),
          contentConstraints: const BoxConstraints(maxWidth: 400),
          tabs: [
            ShadTab(
              value: 'general',
              content: ShadCard(
                title: const Text('General'),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16),
                    ShadSwitchFormField(
                      id: 'notifications',
                      initialValue: true,
                      inputLabel: const Text('Enable notifications'),
                      onChanged: (v) {},
                    ),
                    const SizedBox(height: 8),
                    ShadSwitchFormField(
                      id: 'darkMode',
                      initialValue: false,
                      inputLabel: const Text('Dark mode'),
                      onChanged: (v) {},
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              child: const Text('General'),
            ),
            ShadTab(
              value: 'privacy',
              content: ShadCard(
                title: const Text('Privacy'),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    ShadSwitchFormField(
                      id: 'analytics',
                      initialValue: false,
                      inputLabel: const Text('Allow analytics'),
                      onChanged: (v) {},
                    ),
                    const SizedBox(height: 8),
                    ShadSwitchFormField(
                      id: 'cookies',
                      initialValue: true,
                      inputLabel: const Text('Accept cookies'),
                      onChanged: (v) {},
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              child: const Text('Privacy'),
            ),
          ],
        ),
      ],
    );
  }
}

class DocumentationTabsExample extends StatelessWidget {
  const DocumentationTabsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Documentation Tabs',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A tabbed interface for documentation sections.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadTabs<String>(
          value: 'overview',
          tabBarConstraints: const BoxConstraints(maxWidth: 400),
          contentConstraints: const BoxConstraints(maxWidth: 400),
          tabs: [
            ShadTab(
              value: 'overview',
              content: ShadCard(
                title: const Text('Overview'),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'This component provides a way to organize content into multiple panels. Use it when you have related content that can be grouped into categories.',
                  ),
                ),
              ),
              child: const Text('Overview'),
            ),
            ShadTab(
              value: 'examples',
              content: ShadCard(
                title: const Text('Examples'),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'ShadTabs<String>(\n  value: \'account\',\n  tabs: [\n    ShadTab(\n      value: \'account\',\n      content: YourContent(),\n      child: Text(\'Account\'),\n    ),\n  ],\n)',
                    style: TextStyle(fontFamily: 'monospace'),
                  ),
                ),
              ),
              child: const Text('Examples'),
            ),
          ],
        ),
      ],
    );
  }
}

class CustomTabsExample extends StatelessWidget {
  const CustomTabsExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Custom Tabs',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A tabbed interface with custom styling and content.',
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
          child: ShadTabs<String>(
            value: 'design',
            tabBarConstraints: const BoxConstraints(maxWidth: 350),
            contentConstraints: const BoxConstraints(maxWidth: 350),
            tabs: [
              ShadTab(
                value: 'design',
                content: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Design System',
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Our comprehensive design system provides consistent components and patterns.',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                child: const Text('Design'),
              ),
              ShadTab(
                value: 'components',
                content: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Components',
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Reusable UI components built with accessibility and performance in mind.',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                child: const Text('Components'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
