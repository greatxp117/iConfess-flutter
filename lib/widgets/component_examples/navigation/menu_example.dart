import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../component_example_interface.dart' as example_interface;

/// Menu component implementation using the new architecture
class MenuExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'Menu';

  @override
  String get description =>
      'A menu component that provides dropdown menus with nested items, separators, and various menu item types for navigation and actions.';

  @override
  String get category => 'Navigation';

  @override
  List<String> get tags => ['menu', 'dropdown', 'navigation', 'context'];

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.intermediate;

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
        'Basic Menu': example_interface.ComponentVariant(
          previewBuilder: (context) => const BasicMenuExample(),
          code: _getBasicCode(),
        ),
        'Application Menu': example_interface.ComponentVariant(
          previewBuilder: (context) => const ApplicationMenuExample(),
          code: _getApplicationCode(),
        ),
        'Context Menu': example_interface.ComponentVariant(
          previewBuilder: (context) => const ContextMenuExample(),
          code: _getContextCode(),
        ),
        'Custom Menu': example_interface.ComponentVariant(
          previewBuilder: (context) => const CustomMenuExample(),
          code: _getCustomCode(),
        ),
      };

  @override
  Widget buildPreview(BuildContext context, [String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.previewBuilder(context) ?? const BasicMenuExample();
  }

  @override
  String getCode([String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.code ?? _getBasicCode();
  }

  // Code for basic menu
  String _getBasicCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Basic Menu
ShadMenu(
  items: [
    const ShadContextMenuItem(child: Text('Edit')),
    const ShadContextMenuItem(child: Text('Copy')),
    const ShadContextMenuItem(child: Text('Delete')),
  ],
  child: ShadButton(
    child: const Text('Open Menu'),
  ),
)

// Basic Menu with Separators
ShadMenu(
  items: [
    const ShadContextMenuItem(child: Text('New File')),
    const ShadContextMenuItem(child: Text('Open File')),
    ShadSeparator.horizontal(),
    const ShadContextMenuItem(child: Text('Save')),
    const ShadContextMenuItem(child: Text('Save As...')),
    ShadSeparator.horizontal(),
    const ShadContextMenuItem(child: Text('Exit')),
  ],
  child: ShadButton(
    child: const Text('File Menu'),
  ),
)

// Basic Menu with Disabled Items
ShadMenu(
  items: [
    const ShadContextMenuItem(child: Text('Enabled Item')),
    const ShadContextMenuItem(
      enabled: false,
      child: Text('Disabled Item'),
    ),
    const ShadContextMenuItem(child: Text('Another Enabled Item')),
  ],
  child: ShadButton(
    child: const Text('Menu with Disabled Items'),
  ),
)

// Basic Menu with Icons
ShadMenu(
  items: [
    const ShadContextMenuItem(
      leading: Icon(LucideIcons.edit),
      child: Text('Edit'),
    ),
    const ShadContextMenuItem(
      leading: Icon(LucideIcons.copy),
      child: Text('Copy'),
    ),
    const ShadContextMenuItem(
      leading: Icon(LucideIcons.trash2),
      child: Text('Delete'),
    ),
  ],
  child: ShadButton(
    child: const Text('Actions'),
  ),
)''';
  }

  // Code for application menu
  String _getApplicationCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Application Menu Bar
class ApplicationMenuBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final divider = ShadSeparator.horizontal(
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: theme.colorScheme.surfaceContainerHighest,
    );
    
    return ShadMenubar(
      items: [
        ShadMenubarItem(
          items: [
            const ShadContextMenuItem(child: Text('New Tab')),
            const ShadContextMenuItem(child: Text('New Window')),
            const ShadContextMenuItem(
              enabled: false,
              child: Text('New Incognito Window'),
            ),
            divider,
            const ShadContextMenuItem(
              trailing: Icon(LucideIcons.chevronRight),
              items: [
                ShadContextMenuItem(child: Text('Email Link')),
                ShadContextMenuItem(child: Text('Messages')),
                ShadContextMenuItem(child: Text('Notes')),
              ],
              child: Text('Share'),
            ),
            divider,
            const ShadContextMenuItem(child: Text('Print...')),
          ],
          child: const Text('File'),
        ),
        ShadMenubarItem(
          items: [
            const ShadContextMenuItem(child: Text('Undo')),
            const ShadContextMenuItem(child: Text('Redo')),
            divider,
            ShadContextMenuItem(
              trailing: const Icon(LucideIcons.chevronRight),
              items: [
                const ShadContextMenuItem(child: Text('Search the web')),
                divider,
                const ShadContextMenuItem(child: Text('Find...')),
                const ShadContextMenuItem(child: Text('Find Next')),
                const ShadContextMenuItem(child: Text('Find Previous')),
              ],
              child: const Text('Find'),
            ),
            divider,
            const ShadContextMenuItem(child: Text('Cut')),
            const ShadContextMenuItem(child: Text('Copy')),
            const ShadContextMenuItem(child: Text('Paste')),
          ],
          child: const Text('Edit'),
        ),
        ShadMenubarItem(
          items: [
            const ShadContextMenuItem.inset(
              child: Text('Always Show Bookmarks Bar'),
            ),
            const ShadContextMenuItem(
              leading: Icon(LucideIcons.check),
              child: Text('Always Show Full URLs'),
            ),
            divider,
            const ShadContextMenuItem.inset(child: Text('Reload')),
            const ShadContextMenuItem.inset(
                enabled: false, child: Text('Force Reload')),
            divider,
            const ShadContextMenuItem.inset(
              child: Text('Toggle Full Screen'),
            ),
            divider,
            const ShadContextMenuItem.inset(child: Text('Hide Sidebar')),
          ],
          child: const Text('View'),
        ),
      ],
    );
  }
}

// Application Menu with Custom Styling
class CustomApplicationMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShadMenubar(
      items: [
        ShadMenubarItem(
          items: [
            const ShadContextMenuItem(
              leading: Icon(LucideIcons.file),
              child: Text('New Document'),
            ),
            const ShadContextMenuItem(
              leading: Icon(LucideIcons.folder),
              child: Text('Open Document'),
            ),
            ShadSeparator.horizontal(),
            const ShadContextMenuItem(
              leading: Icon(LucideIcons.save),
              child: Text('Save'),
            ),
            const ShadContextMenuItem(
              leading: Icon(LucideIcons.download),
              child: Text('Export'),
            ),
          ],
          child: const Text('Document'),
        ),
        ShadMenubarItem(
          items: [
            const ShadContextMenuItem(
              leading: Icon(LucideIcons.search),
              child: Text('Find'),
            ),
            const ShadContextMenuItem(
              leading: Icon(LucideIcons.replace),
              child: Text('Replace'),
            ),
            ShadSeparator.horizontal(),
            const ShadContextMenuItem(
              leading: Icon(LucideIcons.settings),
              child: Text('Preferences'),
            ),
          ],
          child: const Text('Tools'),
        ),
      ],
    );
  }
}''';
  }

  // Code for context menu
  String _getContextCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Context Menu
class ContextMenuExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShadMenu(
      items: [
        const ShadContextMenuItem(
          leading: Icon(LucideIcons.edit),
          child: Text('Edit'),
        ),
        const ShadContextMenuItem(
          leading: Icon(LucideIcons.copy),
          child: Text('Copy'),
        ),
        const ShadContextMenuItem(
          leading: Icon(LucideIcons.cut),
          child: Text('Cut'),
        ),
        ShadSeparator.horizontal(),
        const ShadContextMenuItem(
          leading: Icon(LucideIcons.trash2),
          child: Text('Delete'),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text('Right-click for context menu'),
      ),
    );
  }
}

// Context Menu with Submenus
class ContextMenuWithSubmenus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShadMenu(
      items: [
        const ShadContextMenuItem(
          leading: Icon(LucideIcons.edit),
          child: Text('Edit'),
        ),
        ShadContextMenuItem(
          trailing: const Icon(LucideIcons.chevronRight),
          items: [
            const ShadContextMenuItem(
              leading: Icon(LucideIcons.copy),
              child: Text('Copy'),
            ),
            const ShadContextMenuItem(
              leading: Icon(LucideIcons.cut),
              child: Text('Cut'),
            ),
            ShadSeparator.horizontal(),
            const ShadContextMenuItem(
              leading: Icon(LucideIcons.paste),
              child: Text('Paste'),
            ),
          ],
          child: const Text('Clipboard'),
        ),
        ShadContextMenuItem(
          trailing: const Icon(LucideIcons.chevronRight),
          items: [
            const ShadContextMenuItem(
              leading: Icon(LucideIcons.share),
              child: Text('Share via Email'),
            ),
            const ShadContextMenuItem(
              leading: Icon(LucideIcons.messageCircle),
              child: Text('Share via Message'),
            ),
            const ShadContextMenuItem(
              leading: Icon(LucideIcons.link),
              child: Text('Copy Link'),
            ),
          ],
          child: const Text('Share'),
        ),
        ShadSeparator.horizontal(),
        const ShadContextMenuItem(
          leading: Icon(LucideIcons.trash2),
          child: Text('Delete'),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text('Right-click for context menu with submenus'),
      ),
    );
  }
}

// Context Menu with Checkboxes
class ContextMenuWithCheckboxes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShadMenu(
      items: [
        const ShadContextMenuItem.inset(
          child: Text('Show Toolbar'),
        ),
        const ShadContextMenuItem(
          leading: Icon(LucideIcons.check),
          child: Text('Show Status Bar'),
        ),
        const ShadContextMenuItem.inset(
          child: Text('Show Sidebar'),
        ),
        ShadSeparator.horizontal(),
        const ShadContextMenuItem(
          leading: Icon(LucideIcons.check),
          child: Text('Auto-save'),
        ),
        const ShadContextMenuItem.inset(
          child: Text('Spell Check'),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text('Right-click for settings menu'),
      ),
    );
  }
}''';
  }

  // Code for custom menu
  String _getCustomCode() {
    return '''import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Custom Menu with Different Item Types
class CustomMenuExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final square = SizedBox.square(
      dimension: 16,
      child: Center(
        child: SizedBox.square(
          dimension: 8,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurface,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
    
    return ShadMenu(
      items: [
        const ShadContextMenuItem(
          leading: Icon(LucideIcons.user),
          child: Text('Profile'),
        ),
        const ShadContextMenuItem(
          leading: Icon(LucideIcons.settings),
          child: Text('Settings'),
        ),
        ShadSeparator.horizontal(),
        ShadContextMenuItem(
          leading: square,
          child: const Text('Custom Avatar'),
        ),
        const ShadContextMenuItem.inset(
          child: Text('Inset Item'),
        ),
        ShadSeparator.horizontal(),
        const ShadContextMenuItem(
          enabled: false,
          leading: Icon(LucideIcons.lock),
          child: Text('Locked Feature'),
        ),
      ],
      child: ShadButton(
        child: const Text('Custom Menu'),
      ),
    );
  }
}

// Custom Menu with Dynamic Items
class DynamicMenuExample extends StatefulWidget {
  @override
  State<DynamicMenuExample> createState() => _DynamicMenuExampleState();
}

class _DynamicMenuExampleState extends State<DynamicMenuExample> {
  bool showAdvanced = false;

  @override
  Widget build(BuildContext context) {
    final List<Widget> menuItems = [
      const ShadContextMenuItem(
        leading: Icon(LucideIcons.home),
        child: Text('Home'),
      ),
      const ShadContextMenuItem(
        leading: Icon(LucideIcons.user),
        child: Text('Profile'),
      ),
    ];

    if (showAdvanced) {
      menuItems.addAll([
        ShadSeparator.horizontal(),
        const ShadContextMenuItem(
          leading: Icon(LucideIcons.settings),
          child: Text('Advanced Settings'),
        ),
        const ShadContextMenuItem(
          leading: Icon(LucideIcons.code),
          child: Text('Developer Tools'),
        ),
      ]);
    }

    menuItems.addAll([
      ShadSeparator.horizontal(),
      ShadContextMenuItem(
        onTap: () {
          setState(() {
            showAdvanced = !showAdvanced;
          });
        },
        leading: Icon(showAdvanced ? LucideIcons.eyeOff : LucideIcons.eye),
        child: Text(showAdvanced ? 'Hide Advanced' : 'Show Advanced'),
      ),
    ]);

    return ShadMenu(
      items: menuItems,
      child: ShadButton(
        child: const Text('Dynamic Menu'),
      ),
    );
  }
}

// Custom Menu with Custom Styling
class StyledMenuExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShadMenu(
      items: [
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text(
            'Custom Header',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        ShadSeparator.horizontal(),
        const ShadContextMenuItem(
          leading: Icon(LucideIcons.star),
          child: Text('Favorite'),
        ),
        const ShadContextMenuItem(
          leading: Icon(LucideIcons.bookmark),
          child: Text('Bookmark'),
        ),
        ShadSeparator.horizontal(),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text(
            'Actions',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const ShadContextMenuItem(
          leading: Icon(LucideIcons.edit),
          child: Text('Edit'),
        ),
        const ShadContextMenuItem(
          leading: Icon(LucideIcons.trash2),
          child: Text('Delete'),
        ),
      ],
      child: ShadButton(
        child: const Text('Styled Menu'),
      ),
    );
  }
}''';
  }
}

/// Basic menu example widget
class BasicMenuExample extends StatelessWidget {
  const BasicMenuExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Basic Menu',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Simple dropdown menu with basic menu items.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadMenubar(
          items: [
            ShadMenubarItem(
              items: [
                const ShadContextMenuItem(child: Text('Edit')),
                const ShadContextMenuItem(child: Text('Copy')),
                const ShadContextMenuItem(child: Text('Delete')),
              ],
              child: const Text('Actions'),
            ),
          ],
        ),
      ],
    );
  }
}

/// Application menu example widget
class ApplicationMenuExample extends StatelessWidget {
  const ApplicationMenuExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final divider = ShadSeparator.horizontal(
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: theme.colorScheme.surfaceContainerHighest,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Application Menu',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Application-style menu bar with multiple menu categories.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadMenubar(
          items: [
            ShadMenubarItem(
              items: [
                const ShadContextMenuItem(child: Text('New Tab')),
                const ShadContextMenuItem(child: Text('New Window')),
                const ShadContextMenuItem(
                  enabled: false,
                  child: Text('New Incognito Window'),
                ),
                divider,
                const ShadContextMenuItem(
                  trailing: Icon(LucideIcons.chevronRight),
                  items: [
                    ShadContextMenuItem(child: Text('Email Link')),
                    ShadContextMenuItem(child: Text('Messages')),
                    ShadContextMenuItem(child: Text('Notes')),
                  ],
                  child: Text('Share'),
                ),
                divider,
                const ShadContextMenuItem(child: Text('Print...')),
              ],
              child: const Text('File'),
            ),
            ShadMenubarItem(
              items: [
                const ShadContextMenuItem(child: Text('Undo')),
                const ShadContextMenuItem(child: Text('Redo')),
                divider,
                const ShadContextMenuItem(child: Text('Cut')),
                const ShadContextMenuItem(child: Text('Copy')),
                const ShadContextMenuItem(child: Text('Paste')),
              ],
              child: const Text('Edit'),
            ),
            ShadMenubarItem(
              items: [
                const ShadContextMenuItem.inset(
                  child: Text('Always Show Bookmarks Bar'),
                ),
                const ShadContextMenuItem(
                  leading: Icon(LucideIcons.check),
                  child: Text('Always Show Full URLs'),
                ),
                divider,
                const ShadContextMenuItem.inset(child: Text('Reload')),
                const ShadContextMenuItem.inset(
                    enabled: false, child: Text('Force Reload')),
              ],
              child: const Text('View'),
            ),
          ],
        ),
      ],
    );
  }
}

/// Context menu example widget
class ContextMenuExample extends StatelessWidget {
  const ContextMenuExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Context Menu',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Context menu with icons, separators, and nested items.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadMenubar(
          items: [
            ShadMenubarItem(
              items: [
                const ShadContextMenuItem(
                  leading: Icon(LucideIcons.pencil),
                  child: Text('Edit'),
                ),
                const ShadContextMenuItem(
                  leading: Icon(LucideIcons.copy),
                  child: Text('Copy'),
                ),
                const ShadContextMenuItem(
                  leading: Icon(LucideIcons.scissors),
                  child: Text('Cut'),
                ),
                ShadSeparator.horizontal(),
                const ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash2),
                  child: Text('Delete'),
                ),
              ],
              child: const Text('Actions'),
            ),
          ],
        ),
      ],
    );
  }
}

/// Custom menu example widget
class CustomMenuExample extends StatelessWidget {
  const CustomMenuExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final square = SizedBox.square(
      dimension: 16,
      child: Center(
        child: SizedBox.square(
          dimension: 8,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurface,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Custom Menu',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Custom menu with different item types and styling.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadMenubar(
          items: [
            ShadMenubarItem(
              items: [
                const ShadContextMenuItem(
                  leading: Icon(LucideIcons.user),
                  child: Text('Profile'),
                ),
                const ShadContextMenuItem(
                  leading: Icon(LucideIcons.settings),
                  child: Text('Settings'),
                ),
                ShadSeparator.horizontal(),
                ShadContextMenuItem(
                  leading: square,
                  child: const Text('Custom Avatar'),
                ),
                const ShadContextMenuItem.inset(
                  child: Text('Inset Item'),
                ),
                ShadSeparator.horizontal(),
                const ShadContextMenuItem(
                  enabled: false,
                  leading: Icon(LucideIcons.lock),
                  child: Text('Locked Feature'),
                ),
              ],
              child: const Text('Custom Menu'),
            ),
          ],
        ),
      ],
    );
  }
}
