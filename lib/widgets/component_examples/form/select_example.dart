import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../component_example_interface.dart' as example_interface;

class SelectExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'Select';

  @override
  String get description => 'Dropdown selection component with various options';

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.intermediate;

  @override
  String get category => 'Form';

  @override
  List<String> get tags => ['form', 'select', 'dropdown', 'input'];

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
        'Basic': example_interface.ComponentVariant(
          previewBuilder: (context) => const BasicSelectExample(),
          code: _getBasicCode(),
        ),
        'Grouped': example_interface.ComponentVariant(
          previewBuilder: (context) => const GroupedSelectExample(),
          code: _getGroupedCode(),
        ),
        'Form Field': example_interface.ComponentVariant(
          previewBuilder: (context) => const FormFieldSelectExample(),
          code: _getFormFieldCode(),
        ),
        'With Search': example_interface.ComponentVariant(
          previewBuilder: (context) => const SearchSelectExample(),
          code: _getSearchCode(),
        ),
        'Multiple': example_interface.ComponentVariant(
          previewBuilder: (context) => const MultipleSelectExample(),
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
    return '''final fruits = {
  'apple': 'Apple',
  'banana': 'Banana',
  'blueberry': 'Blueberry',
  'grapes': 'Grapes',
  'pineapple': 'Pineapple',
};

class BasicSelectExample extends StatelessWidget {
  const BasicSelectExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Basic Select',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A basic select with grouped fruit options.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 180),
          child: ShadSelect<String>(
            placeholder: const Text('Select a fruit'),
            options: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 6, 6, 6),
                child: Text(
                  'Fruits',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              ...fruits.entries
                  .map((e) => ShadOption(value: e.key, child: Text(e.value))),
            ],
            selectedOptionBuilder: (context, value) => Text(fruits[value]!),
            onChanged: print,
          ),
        ),
      ],
    );
  }
}''';
  }

  String _getGroupedCode() {
    return '''final timezones = {
  'North America': {
    'est': 'Eastern Standard Time (EST)',
    'cst': 'Central Standard Time (CST)',
    'mst': 'Mountain Standard Time (MST)',
    'pst': 'Pacific Standard Time (PST)',
  },
  'Europe & Africa': {
    'gmt': 'Greenwich Mean Time (GMT)',
    'cet': 'Central European Time (CET)',
    'eet': 'Eastern European Time (EET)',
  },
};

List<Widget> getTimezonesWidgets(ThemeData theme) {
  final widgets = <Widget>[];
  for (final zone in timezones.entries) {
    widgets.add(
      Padding(
        padding: const EdgeInsets.fromLTRB(32, 6, 6, 6),
        child: Text(
          zone.key,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.start,
        ),
      ),
    );
    widgets.addAll(zone.value.entries
        .map((e) => ShadOption(value: e.key, child: Text(e.value))));
  }
  return widgets;
}

class GroupedSelectExample extends StatelessWidget {
  const GroupedSelectExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Grouped Select',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A select with grouped timezone options by region.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 280),
          child: ShadSelect<String>(
            placeholder: const Text('Select a timezone'),
            options: getTimezonesWidgets(theme),
            selectedOptionBuilder: (context, value) {
              final timezone = timezones.entries
                  .firstWhere((element) => element.value.containsKey(value))
                  .value[value];
              return Text(timezone!);
            },
          ),
        ),
      ],
    );
  }
}''';
  }

  String _getFormFieldCode() {
    return '''final verifiedEmails = [
  'm@example.com',
  'm@google.com',
  'm@support.com',
];

class FormFieldSelectExample extends StatelessWidget {
  const FormFieldSelectExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Form Field Select',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A select integrated as a form field with validation.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ShadSelectFormField<String>(
            id: 'email',
            minWidth: 350,
            initialValue: null,
            options: verifiedEmails
                .map((email) => ShadOption(value: email, child: Text(email)))
                .toList(),
            selectedOptionBuilder: (context, value) => value == 'none'
                ? const Text('Select a verified email to display')
                : Text(value),
            placeholder: const Text('Select a verified email to display'),
            validator: (v) {
              if (v == null) {
                return 'Please select an email to display';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}''';
  }

  String _getSearchCode() {
    return '''const frameworks = {
  'nextjs': 'Next.js',
  'svelte': 'SvelteKit',
  'nuxtjs': 'Nuxt.js',
  'remix': 'Remix',
  'astro': 'Astro',
};

class SearchSelectExample extends StatefulWidget {
  const SearchSelectExample({super.key});

  @override
  State<SearchSelectExample> createState() => _SearchSelectExampleState();
}

class _SearchSelectExampleState extends State<SearchSelectExample> {
  var searchValue = '';

  Map<String, String> get filteredFrameworks => {
    for (final framework in frameworks.entries)
      if (framework.value.toLowerCase().contains(searchValue.toLowerCase()))
        framework.key: framework.value
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Search Select',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A select with search functionality for filtering options.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadSelect<String>.withSearch(
          minWidth: 180,
          maxWidth: 300,
          placeholder: const Text('Select framework...'),
          onSearchChanged: (value) => setState(() => searchValue = value),
          searchPlaceholder: const Text('Search framework'),
          options: [
            if (filteredFrameworks.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text('No framework found'),
              ),
            ...frameworks.entries.map(
              (framework) {
                return Offstage(
                  offstage: !filteredFrameworks.containsKey(framework.key),
                  child: ShadOption(
                    value: framework.key,
                    child: Text(framework.value),
                  ),
                );
              },
            )
          ],
          selectedOptionBuilder: (context, value) => Text(frameworks[value]!),
        ),
      ],
    );
  }
}''';
  }

  String _getMultipleCode() {
    return '''final fruits = {
  'apple': 'Apple',
  'banana': 'Banana',
  'blueberry': 'Blueberry',
  'grapes': 'Grapes',
  'pineapple': 'Pineapple',
};

class MultipleSelectExample extends StatelessWidget {
  const MultipleSelectExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Multiple Select',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A select with multiple selection capability.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ShadSelect<String>.multiple(
            minWidth: 340,
            onChanged: print,
            allowDeselection: true,
            closeOnSelect: false,
            placeholder: const Text('Select multiple fruits'),
            options: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 6, 6, 6),
                child: Text(
                  'Fruits',
                  style: theme.textTheme.titleLarge,
                  textAlign: TextAlign.start,
                ),
              ),
              ...fruits.entries.map(
                (e) => ShadOption(
                  value: e.key,
                  child: Text(e.value),
                ),
              ),
            ],
            selectedOptionsBuilder: (context, values) =>
                Text(values.map((v) => v[0].toUpperCase() + v.substring(1)).join(', ')),
          ),
        ),
      ],
    );
  }
}''';
  }
}

// Sample data
final fruits = {
  'apple': 'Apple',
  'banana': 'Banana',
  'blueberry': 'Blueberry',
  'grapes': 'Grapes',
  'pineapple': 'Pineapple',
};

final timezones = {
  'North America': {
    'est': 'Eastern Standard Time (EST)',
    'cst': 'Central Standard Time (CST)',
    'mst': 'Mountain Standard Time (MST)',
    'pst': 'Pacific Standard Time (PST)',
  },
  'Europe & Africa': {
    'gmt': 'Greenwich Mean Time (GMT)',
    'cet': 'Central European Time (CET)',
    'eet': 'Eastern European Time (EET)',
  },
};

final verifiedEmails = [
  'm@example.com',
  'm@google.com',
  'm@support.com',
];

const frameworks = {
  'nextjs': 'Next.js',
  'svelte': 'SvelteKit',
  'nuxtjs': 'Nuxt.js',
  'remix': 'Remix',
  'astro': 'Astro',
};

// Helper functions
List<Widget> getTimezonesWidgets(ThemeData theme) {
  final widgets = <Widget>[];
  for (final zone in timezones.entries) {
    widgets.add(
      Padding(
        padding: const EdgeInsets.fromLTRB(32, 6, 6, 6),
        child: Text(
          zone.key,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.start,
        ),
      ),
    );
    widgets.addAll(zone.value.entries
        .map((e) => ShadOption(value: e.key, child: Text(e.value))));
  }
  return widgets;
}

// Widget implementations
class BasicSelectExample extends StatelessWidget {
  const BasicSelectExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Basic Select',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A basic select with grouped fruit options.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 180),
          child: ShadSelect<String>(
            placeholder: const Text('Select a fruit'),
            options: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 6, 6, 6),
                child: Text(
                  'Fruits',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              ...fruits.entries
                  .map((e) => ShadOption(value: e.key, child: Text(e.value))),
            ],
            selectedOptionBuilder: (context, value) => Text(fruits[value]!),
            onChanged: print,
          ),
        ),
      ],
    );
  }
}

class GroupedSelectExample extends StatelessWidget {
  const GroupedSelectExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Grouped Select',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A select with grouped timezone options by region.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 280),
          child: ShadSelect<String>(
            placeholder: const Text('Select a timezone'),
            options: getTimezonesWidgets(theme),
            selectedOptionBuilder: (context, value) {
              final timezone = timezones.entries
                  .firstWhere((element) => element.value.containsKey(value))
                  .value[value];
              return Text(timezone!);
            },
          ),
        ),
      ],
    );
  }
}

class FormFieldSelectExample extends StatelessWidget {
  const FormFieldSelectExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Form Field Select',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A select integrated as a form field with validation.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ShadSelectFormField<String>(
            id: 'email',
            minWidth: 350,
            initialValue: null,
            options: verifiedEmails
                .map((email) => ShadOption(value: email, child: Text(email)))
                .toList(),
            selectedOptionBuilder: (context, value) => value == 'none'
                ? const Text('Select a verified email to display')
                : Text(value),
            placeholder: const Text('Select a verified email to display'),
            validator: (v) {
              if (v == null) {
                return 'Please select an email to display';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}

class SearchSelectExample extends StatefulWidget {
  const SearchSelectExample({super.key});

  @override
  State<SearchSelectExample> createState() => _SearchSelectExampleState();
}

class _SearchSelectExampleState extends State<SearchSelectExample> {
  var searchValue = '';

  Map<String, String> get filteredFrameworks => {
        for (final framework in frameworks.entries)
          if (framework.value.toLowerCase().contains(searchValue.toLowerCase()))
            framework.key: framework.value
      };

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Search Select',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A select with search functionality for filtering options.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadSelect<String>.withSearch(
          minWidth: 180,
          maxWidth: 300,
          placeholder: const Text('Select framework...'),
          onSearchChanged: (value) => setState(() => searchValue = value),
          searchPlaceholder: const Text('Search framework'),
          options: [
            if (filteredFrameworks.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text('No framework found'),
              ),
            ...frameworks.entries.map(
              (framework) {
                return Offstage(
                  offstage: !filteredFrameworks.containsKey(framework.key),
                  child: ShadOption(
                    value: framework.key,
                    child: Text(framework.value),
                  ),
                );
              },
            )
          ],
          selectedOptionBuilder: (context, value) => Text(frameworks[value]!),
        ),
      ],
    );
  }
}

class MultipleSelectExample extends StatelessWidget {
  const MultipleSelectExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Multiple Select',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A select with multiple selection capability.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ShadSelect<String>.multiple(
            minWidth: 340,
            onChanged: print,
            allowDeselection: true,
            closeOnSelect: false,
            placeholder: const Text('Select multiple fruits'),
            options: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 6, 6, 6),
                child: Text(
                  'Fruits',
                  style: theme.textTheme.titleLarge,
                  textAlign: TextAlign.start,
                ),
              ),
              ...fruits.entries.map(
                (e) => ShadOption(
                  value: e.key,
                  child: Text(e.value),
                ),
              ),
            ],
            selectedOptionsBuilder: (context, values) => Text(values
                .map((v) => v[0].toUpperCase() + v.substring(1))
                .join(', ')),
          ),
        ),
      ],
    );
  }
}
