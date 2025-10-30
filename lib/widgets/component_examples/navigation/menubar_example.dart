import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../component_example_interface.dart' as example_interface;

class MenubarExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'Menubar';

  @override
  String get description => 'Horizontal menu bar with dropdown menus';

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.intermediate;

  @override
  String get category => 'Navigation';

  @override
  List<String> get tags => ['navigation', 'menubar', 'menu', 'dropdown'];

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
        'Application': example_interface.ComponentVariant(
          previewBuilder: (context) => const ApplicationMenubarExample(),
          code: _getApplicationCode(),
        ),
        'Simple': example_interface.ComponentVariant(
          previewBuilder: (context) => const SimpleMenubarExample(),
          code: _getSimpleCode(),
        ),
        'Custom Menubar': example_interface.ComponentVariant(
          previewBuilder: (context) => const CustomMenubarExample(),
          code: _getCustomCode(),
        ),
        'Context Menubar': example_interface.ComponentVariant(
          previewBuilder: (context) => const ContextMenubarExample(),
          code: _getContextCode(),
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

  String _getApplicationCode() {
    return '''class ApplicationMenubarExample extends StatelessWidget {
  const ApplicationMenubarExample({super.key});

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
    final divider = ShadSeparator.horizontal(
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: theme.colorScheme.surfaceContainerHighest,
    );
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Application Menubar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Application menu bar with dropdown menus and nested items.',
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
            ShadMenubarItem(items: [
              const ShadContextMenuItem.inset(child: Text('Andy')),
              ShadContextMenuItem(leading: square, child: const Text('Benoit')),
              const ShadContextMenuItem.inset(child: Text('Luis')),
              divider,
              const ShadContextMenuItem.inset(child: Text('Edit...')),
              divider,
              const ShadContextMenuItem.inset(child: Text('Add Profile...')),
            ], child: const Text('Profiles')),
          ],
        ),
      ],
    );
  }
}''';
  }

  String _getSimpleCode() {
    return '''class SimpleMenubarExample extends StatelessWidget {
  const SimpleMenubarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Simple Menubar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Simple menubar with basic menu items.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadMenubar(
          items: [
            ShadMenubarItem(
              items: [
                const ShadContextMenuItem(child: Text('New')),
                const ShadContextMenuItem(child: Text('Open')),
                const ShadContextMenuItem(child: Text('Save')),
                const ShadContextMenuItem(child: Text('Save As...')),
              ],
              child: const Text('File'),
            ),
            ShadMenubarItem(
              items: [
                const ShadContextMenuItem(child: Text('Undo')),
                const ShadContextMenuItem(child: Text('Redo')),
                const ShadContextMenuItem(child: Text('Cut')),
                const ShadContextMenuItem(child: Text('Copy')),
                const ShadContextMenuItem(child: Text('Paste')),
              ],
              child: const Text('Edit'),
            ),
            ShadMenubarItem(
              items: [
                const ShadContextMenuItem(child: Text('Zoom In')),
                const ShadContextMenuItem(child: Text('Zoom Out')),
                const ShadContextMenuItem(child: Text('Reset Zoom')),
              ],
              child: const Text('View'),
            ),
          ],
        ),
      ],
    );
  }
}''';
  }

  String _getCustomCode() {
    return '''class CustomMenubarExample extends StatelessWidget {
  const CustomMenubarExample({super.key});

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
          'Custom Menubar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Menubar with custom styling and icons.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: theme.colorScheme.outline),
          ),
          child: ShadMenubar(
            items: [
              ShadMenubarItem(
                items: [
                  const ShadContextMenuItem(
                    leading: Icon(LucideIcons.plus),
                    child: Text('Create New'),
                  ),
                  const ShadContextMenuItem(
                    leading: Icon(LucideIcons.folderOpen),
                    child: Text('Open Project'),
                  ),
                  divider,
                  const ShadContextMenuItem(
                    leading: Icon(LucideIcons.settings),
                    child: Text('Preferences'),
                  ),
                ],
                child: const Text('Project'),
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
                  divider,
                  const ShadContextMenuItem(
                    leading: Icon(LucideIcons.code),
                    child: Text('Format Code'),
                  ),
                ],
                child: const Text('Edit'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}''';
  }

  String _getContextCode() {
    return '''class ContextMenubarExample extends StatelessWidget {
  const ContextMenubarExample({super.key});

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
          'Context Menubar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Menubar with context-specific menu items.',
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
                  leading: Icon(LucideIcons.bell),
                  child: Text('Notifications'),
                ),
                divider,
                const ShadContextMenuItem(
                  leading: Icon(LucideIcons.logOut),
                  child: Text('Sign Out'),
                ),
              ],
              child: const Text('Account'),
            ),
            ShadMenubarItem(
              items: [
                const ShadContextMenuItem(
                  leading: Icon(LucideIcons.download),
                  child: Text('Download'),
                ),
                const ShadContextMenuItem(
                  leading: Icon(LucideIcons.upload),
                  child: Text('Upload'),
                ),
                divider,
                const ShadContextMenuItem(
                  leading: Icon(LucideIcons.share),
                  child: Text('Share'),
                ),
                const ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash),
                  child: Text('Delete'),
                ),
              ],
              child: const Text('Actions'),
            ),
            ShadMenubarItem(
              items: [
                const ShadContextMenuItem(
                  leading: Icon(LucideIcons.questionMark),
                  child: Text('Help'),
                ),
                const ShadContextMenuItem(
                  leading: Icon(LucideIcons.info),
                  child: Text('About'),
                ),
              ],
              child: const Text('Help'),
            ),
          ],
        ),
      ],
    );
  }
}''';
  }
}

// Widget implementations
class ApplicationMenubarExample extends StatelessWidget {
  const ApplicationMenubarExample({super.key});

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
    final divider = ShadSeparator.horizontal(
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: theme.colorScheme.surfaceContainerHighest,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Application Menubar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Application menu bar with dropdown menus and nested items.',
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
            ShadMenubarItem(items: [
              const ShadContextMenuItem.inset(child: Text('Andy')),
              ShadContextMenuItem(leading: square, child: const Text('Benoit')),
              const ShadContextMenuItem.inset(child: Text('Luis')),
              divider,
              const ShadContextMenuItem.inset(child: Text('Edit...')),
              divider,
              const ShadContextMenuItem.inset(child: Text('Add Profile...')),
            ], child: const Text('Profiles')),
          ],
        ),
      ],
    );
  }
}

class SimpleMenubarExample extends StatelessWidget {
  const SimpleMenubarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Simple Menubar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Simple menubar with basic menu items.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ShadMenubar(
          items: [
            ShadMenubarItem(
              items: [
                const ShadContextMenuItem(child: Text('New')),
                const ShadContextMenuItem(child: Text('Open')),
                const ShadContextMenuItem(child: Text('Save')),
                const ShadContextMenuItem(child: Text('Save As...')),
              ],
              child: const Text('File'),
            ),
            ShadMenubarItem(
              items: [
                const ShadContextMenuItem(child: Text('Undo')),
                const ShadContextMenuItem(child: Text('Redo')),
                const ShadContextMenuItem(child: Text('Cut')),
                const ShadContextMenuItem(child: Text('Copy')),
                const ShadContextMenuItem(child: Text('Paste')),
              ],
              child: const Text('Edit'),
            ),
            ShadMenubarItem(
              items: [
                const ShadContextMenuItem(child: Text('Zoom In')),
                const ShadContextMenuItem(child: Text('Zoom Out')),
                const ShadContextMenuItem(child: Text('Reset Zoom')),
              ],
              child: const Text('View'),
            ),
          ],
        ),
      ],
    );
  }
}

class CustomMenubarExample extends StatelessWidget {
  const CustomMenubarExample({super.key});

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
          'Custom Menubar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Menubar with custom styling and icons.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: theme.colorScheme.outline),
          ),
          child: ShadMenubar(
            items: [
              ShadMenubarItem(
                items: [
                  const ShadContextMenuItem(
                    leading: Icon(LucideIcons.plus),
                    child: Text('Create New'),
                  ),
                  const ShadContextMenuItem(
                    leading: Icon(LucideIcons.folderOpen),
                    child: Text('Open Project'),
                  ),
                  divider,
                  const ShadContextMenuItem(
                    leading: Icon(LucideIcons.settings),
                    child: Text('Preferences'),
                  ),
                ],
                child: const Text('Project'),
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
                  divider,
                  const ShadContextMenuItem(
                    leading: Icon(LucideIcons.code),
                    child: Text('Format Code'),
                  ),
                ],
                child: const Text('Edit'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ContextMenubarExample extends StatelessWidget {
  const ContextMenubarExample({super.key});

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
          'Context Menubar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Menubar with context-specific menu items.',
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
                  leading: Icon(LucideIcons.bell),
                  child: Text('Notifications'),
                ),
                divider,
                const ShadContextMenuItem(
                  leading: Icon(LucideIcons.logOut),
                  child: Text('Sign Out'),
                ),
              ],
              child: const Text('Account'),
            ),
            ShadMenubarItem(
              items: [
                const ShadContextMenuItem(
                  leading: Icon(LucideIcons.download),
                  child: Text('Download'),
                ),
                const ShadContextMenuItem(
                  leading: Icon(LucideIcons.upload),
                  child: Text('Upload'),
                ),
                divider,
                const ShadContextMenuItem(
                  leading: Icon(LucideIcons.share),
                  child: Text('Share'),
                ),
                const ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash),
                  child: Text('Delete'),
                ),
              ],
              child: const Text('Actions'),
            ),
            ShadMenubarItem(
              items: [
                const ShadContextMenuItem(
                  leading: Icon(LucideIcons.fileQuestionMark, size: 16),
                  child: Text('Help'),
                ),
                const ShadContextMenuItem(
                  leading: Icon(LucideIcons.info),
                  child: Text('About'),
                ),
              ],
              child: const Text('Help'),
            ),
          ],
        ),
      ],
    );
  }
}
