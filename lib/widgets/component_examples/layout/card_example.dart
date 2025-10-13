import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../component_example_interface.dart' as example_interface;

/// Card component implementation using the new architecture
class CardExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'Card';

  @override
  String get description =>
      'A flexible container that groups related content and actions in a visually distinct container with consistent styling and spacing.';

  @override
  String get category => 'Layout';

  @override
  List<String> get tags => ['container', 'content', 'layout', 'grouping'];

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.basic;

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
    'Project Card': example_interface.ComponentVariant(
      previewBuilder: (context) => const CardProject(),
      code: _getProjectCode(),
    ),
    'Notifications Card': example_interface.ComponentVariant(
      previewBuilder: (context) => const CardNotifications(),
      code: _getNotificationsCode(),
    ),
    'Basic Card': example_interface.ComponentVariant(
      previewBuilder: (context) => _buildBasicCard(),
      code: _getBasicCode(),
    ),
  };

  @override
  Widget buildPreview(BuildContext context, [String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.previewBuilder(context) ?? _buildBasicCard();
  }

  @override
  String getCode([String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.code ?? _getBasicCode();
  }

  // Basic card preview
  Widget _buildBasicCard() {
    return ShadCard(
      width: 300,
      title: const Text('Basic Card'),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ShadButton.outline(
            child: const Text('Cancel'),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          ShadButton(
            child: const Text('Save'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // Code for project card
  String _getProjectCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

const frameworks = {
  'next': 'Next.js',
  'react': 'React',
  'astro': 'Astro',
  'nuxt': 'Nuxt.js',
};

class CardProject extends StatelessWidget {
  const CardProject({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ShadCard(
      width: 350,
      title: Text('Create project', style: theme.textTheme.headlineSmall),
            footer: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ShadButton.outline(
            child: const Text('Cancel'),
            onPressed: () {},
          ),
          ShadButton(
            child: const Text('Deploy'),
            onPressed: () {},
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Name'),
            const SizedBox(height: 6),
            const ShadInput(placeholder: Text('Name of your project')),
            const SizedBox(height: 16),
            const Text('Framework'),
            const SizedBox(height: 6),
            ShadSelect<String>(
              placeholder: const Text('Select'),
              options: frameworks.entries
                  .map((e) => ShadOption(value: e.key, child: Text(e.value)))
                  .toList(),
              selectedOptionBuilder: (context, value) {
                return Text(frameworks[value]!);
              },
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}''';
  }

  // Code for notifications card
  String _getNotificationsCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

const notifications = [
  (
    title: "Your call has been confirmed.",
    description: "You have a meeting scheduled for tomorrow.",
  ),
  (
    title: "You have a new message!",
    description: "Check your inbox for the latest updates.",
  ),
  (
    title: "Your subscription is expiring soon!",
    description: "Renew your subscription to continue access.",
  ),
];

class CardNotifications extends StatefulWidget {
  const CardNotifications({super.key});

  @override
  State<CardNotifications> createState() => _CardNotificationsState();
}

class _CardNotificationsState extends State<CardNotifications> {
  final pushNotifications = ValueNotifier(false);

  @override
  void dispose() {
    pushNotifications.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ShadCard(
      width: 380,
      title: const Text('Notifications'),
            footer: ShadButton(
        width: double.infinity,
        leading: const Padding(
          padding: EdgeInsets.only(right: 8),
          child: Icon(LucideIcons.check),
        ),
        onPressed: () {},
        child: const Text('Mark all as read'),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: theme.colorScheme.outline),
            ),
            child: Row(
              children: [
                Icon(
                  LucideIcons.bellRing,
                  size: 24,
                  color: theme.colorScheme.onSurface,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Push Notifications',
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Send notifications to device.',
                          style: theme.textTheme.bodyMedium,
                        )
                      ],
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: pushNotifications,
                  builder: (context, value, child) {
                    return ShadSwitch(
                      value: value,
                      onChanged: (v) => pushNotifications.value = v,
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...notifications
              .map(
                (n) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: const BoxDecoration(
                        color: Color(0xFF0CA5E9),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(n.title, style: theme.textTheme.bodySmall),
                            const SizedBox(height: 4),
                            Text(n.description, style: theme.textTheme.bodyMedium),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
              .expand((widget) => [widget, const SizedBox(height: 16)])
              .take(notifications.length * 2 - 1), // Remove the last separator
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}''';
  }

  // Code for basic card
  String _getBasicCode() {
    return '''import 'package:shadcn_ui/shadcn_ui.dart';

// Basic Card with Title, Content, and Footer
ShadCard(
  width: 300,
  title: const Text('Basic Card'),
  content, and footer.'),
  child: const Padding(
    padding: EdgeInsets.symmetric(vertical: 16),
    child: Text('This is the main content of the card. You can put any widgets here.'),
  ),
  footer: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      ShadButton.outline(
        child: const Text('Cancel'),
        onPressed: () {},
      ),
      const SizedBox(width: 8),
      ShadButton(
        child: const Text('Save'),
        onPressed: () {},
      ),
    ],
  ),
)

// Card with Custom Styling
ShadCard(
  width: 400,
  child: Padding(
    padding: const EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Custom Card', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        const Text('This card has custom padding and styling.'),
        const SizedBox(height: 16),
        ShadButton(
          child: const Text('Action'),
          onPressed: () {},
        ),
      ],
    ),
  ),
)

// Card without Footer
ShadCard(
  title: const Text('Content Only'),
    child: const Padding(
    padding: EdgeInsets.symmetric(vertical: 16),
    child: Text('This card only has content, no footer actions.'),
  ),
)''';
  }
}

// Framework options for the project card
const frameworks = {
  'next': 'Next.js',
  'react': 'React',
  'astro': 'Astro',
  'nuxt': 'Nuxt.js',
};

/// Card example for creating a new project
class CardProject extends StatelessWidget {
  const CardProject({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ShadCard(
      width: 350,
      title: Text('Create project', style: theme.textTheme.headlineSmall),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ShadButton.outline(
            child: const Text('Cancel'),
            onPressed: () {},
          ),
          ShadButton(
            child: const Text('Deploy'),
            onPressed: () {},
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Name'),
            const SizedBox(height: 6),
            const ShadInput(placeholder: Text('Name of your project')),
            const SizedBox(height: 16),
            const Text('Framework'),
            const SizedBox(height: 6),
            ShadSelect<String>(
              placeholder: const Text('Select'),
              options: frameworks.entries
                  .map((e) => ShadOption(value: e.key, child: Text(e.value)))
                  .toList(),
              selectedOptionBuilder: (context, value) {
                return Text(frameworks[value]!);
              },
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}

// Notification data for the notifications card
const notifications = [
  (
    title: "Your call has been confirmed.",
    description: "You have a meeting scheduled for tomorrow.",
  ),
  (
    title: "You have a new message!",
    description: "Check your inbox for the latest updates.",
  ),
  (
    title: "Your subscription is expiring soon!",
    description: "Renew your subscription to continue access.",
  ),
];

/// Card example for displaying notifications
class CardNotifications extends StatefulWidget {
  const CardNotifications({super.key});

  @override
  State<CardNotifications> createState() => _CardNotificationsState();
}

class _CardNotificationsState extends State<CardNotifications> {
  final pushNotifications = ValueNotifier(false);

  @override
  void dispose() {
    pushNotifications.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ShadCard(
      width: 380,
      title: const Text('Notifications'),
      footer: ShadButton(
        width: double.infinity,
        leading: const Padding(
          padding: EdgeInsets.only(right: 8),
          child: Icon(LucideIcons.check),
        ),
        onPressed: () {},
        child: const Text('Mark all as read'),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: theme.colorScheme.outline),
            ),
            child: Row(
              children: [
                Icon(
                  LucideIcons.bellRing,
                  size: 24,
                  color: theme.colorScheme.onSurface,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Push Notifications',
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Send notifications to device.',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: pushNotifications,
                  builder: (context, value, child) {
                    return ShadSwitch(
                      value: value,
                      onChanged: (v) => pushNotifications.value = v,
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...notifications
              .map(
                (n) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: const BoxDecoration(
                        color: Color(0xFF0CA5E9),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(n.title, style: theme.textTheme.bodySmall),
                            const SizedBox(height: 4),
                            Text(
                              n.description,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .expand((widget) => [widget, const SizedBox(height: 16)])
              .take(notifications.length * 2 - 1), // Remove the last separator
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
