/// Component categories and organization system for the Shadcn UI template.
///
/// This file defines the structure and categorization of all available
/// components for better organization and navigation.
library;

enum ComponentComplexity { basic, intermediate, advanced }

enum ComponentStatus { implemented, planned, inProgress }

/// Enhanced component data structure with categorization and metadata
class ComponentData {
  final String name;
  final String description;
  final String category;
  final ComponentComplexity complexity;
  final ComponentStatus status;

  const ComponentData({
    required this.name,
    required this.description,
    required this.category,
    this.complexity = ComponentComplexity.basic,
    this.status = ComponentStatus.planned,
  });
}

/// Central registry of all component categories and their components
class ComponentCategories {
  static const Map<String, List<ComponentData>> categories = {
    'Form Elements': [
      ComponentData(
        name: 'Button',
        description:
            'Displays a button or a component that looks like a button.',
        category: 'Form Elements',
        complexity: ComponentComplexity.basic,
        status: ComponentStatus.implemented,
      ),
      ComponentData(
        name: 'IconButton',
        description: 'A button that displays an icon instead of text.',
        category: 'Form Elements',
        complexity: ComponentComplexity.basic,
        status: ComponentStatus.implemented,
      ),
      ComponentData(
        name: 'Input',
        description:
            'Displays a form input field or a component that looks like an input field.',
        category: 'Form Elements',
        complexity: ComponentComplexity.basic,
        status: ComponentStatus.implemented,
      ),
      ComponentData(
        name: 'InputOTP',
        description: 'A one-time password input field with individual slots.',
        category: 'Form Elements',
        complexity: ComponentComplexity.intermediate,
        status: ComponentStatus.implemented,
      ),
      ComponentData(
        name: 'Form',
        description:
            'A container for form fields with validation and state management.',
        category: 'Form Elements',
        complexity: ComponentComplexity.intermediate,
        status: ComponentStatus.implemented,
      ),
      ComponentData(
        name: 'Checkbox',
        description:
            'A control that allows the user to toggle between checked and not checked.',
        category: 'Form Elements',
        complexity: ComponentComplexity.basic,
        status: ComponentStatus.implemented,
      ),
      ComponentData(
        name: 'Radio Group',
        description:
            'A set of checkboxes where only one can be selected at a time.',
        category: 'Form Elements',
        complexity: ComponentComplexity.intermediate,
        status: ComponentStatus.implemented,
      ),
      ComponentData(
        name: 'Select',
        description: 'A dropdown selection component with searchable options.',
        category: 'Form Elements',
        complexity: ComponentComplexity.intermediate,
        status: ComponentStatus.implemented,
      ),
      ComponentData(
        name: 'Label',
        description: 'A text label associated with form controls.',
        category: 'Form Elements',
        complexity: ComponentComplexity.basic,
        status: ComponentStatus.planned,
      ),
      ComponentData(
        name: 'Input OTP',
        description:
            'A specialized input for one-time passwords and verification codes.',
        category: 'Form Elements',
        complexity: ComponentComplexity.advanced,
        status: ComponentStatus.planned,
      ),
      ComponentData(
        name: 'Time Picker',
        description:
            'A component for selecting time with hour and minute inputs.',
        category: 'Form Elements',
        complexity: ComponentComplexity.intermediate,
        status: ComponentStatus.implemented,
      ),
      ComponentData(
        name: 'Textarea',
        description: 'A multi-line text input field for longer text content.',
        category: 'Form Elements',
        complexity: ComponentComplexity.basic,
        status: ComponentStatus.implemented,
      ),
      ComponentData(
        name: 'Switch',
        description: 'A toggle control for boolean values.',
        category: 'Form Elements',
        complexity: ComponentComplexity.basic,
        status: ComponentStatus.implemented,
      ),
      ComponentData(
        name: 'Slide',
        description: 'A draggable slider for value selection within a range.',
        category: 'Form Elements',
        complexity: ComponentComplexity.basic,
        status: ComponentStatus.implemented,
      ),
    ],
    'Layout & Structure': [
      ComponentData(
        name: 'Card',
        description: 'Displays a card with header, content, and footer.',
        category: 'Layout & Structure',
        complexity: ComponentComplexity.basic,
        status: ComponentStatus.implemented,
      ),
      ComponentData(
        name: 'Accordion',
        description:
            'A vertically stacked set of interactive headings that reveal content.',
        category: 'Layout & Structure',
        complexity: ComponentComplexity.intermediate,
        status: ComponentStatus.implemented,
      ),
      ComponentData(
        name: 'Data Table',
        description:
            'A table component for displaying structured data with sorting and filtering.',
        category: 'Layout & Structure',
        complexity: ComponentComplexity.advanced,
        status: ComponentStatus.planned,
      ),
      ComponentData(
        name: 'Aspect Ratio',
        description:
            'A container that maintains a specific width-to-height ratio.',
        category: 'Layout & Structure',
        complexity: ComponentComplexity.basic,
        status: ComponentStatus.planned,
      ),
      ComponentData(
        name: 'Scroll-area',
        description:
            'A container with custom scrollbars for consistent cross-platform scrolling.',
        category: 'Layout & Structure',
        complexity: ComponentComplexity.intermediate,
        status: ComponentStatus.planned,
      ),
      ComponentData(
        name: 'Collapsible',
        description:
            'An expandable/collapsible content area with smooth animations.',
        category: 'Layout & Structure',
        complexity: ComponentComplexity.intermediate,
        status: ComponentStatus.planned,
      ),
      ComponentData(
        name: 'Resizable',
        description: 'A container that can be resized by dragging its edges.',
        category: 'Layout & Structure',
        complexity: ComponentComplexity.advanced,
        status: ComponentStatus.implemented,
      ),
    ],
    'Navigation': [
      ComponentData(
        name: 'Breadcrumb',
        description:
            'Shows the current page location within a navigational hierarchy.',
        category: 'Navigation',
        complexity: ComponentComplexity.basic,
        status: ComponentStatus.planned,
      ),
      ComponentData(
        name: 'Pagination',
        description:
            'Navigation component for splitting content across multiple pages.',
        category: 'Navigation',
        complexity: ComponentComplexity.intermediate,
        status: ComponentStatus.planned,
      ),
      ComponentData(
        name: 'Dropdown Menu',
        description: 'A menu that appears when clicking a trigger element.',
        category: 'Navigation',
        complexity: ComponentComplexity.intermediate,
        status: ComponentStatus.planned,
      ),
      ComponentData(
        name: 'Navigation Menu',
        description:
            'A comprehensive navigation component with nested menu support.',
        category: 'Navigation',
        complexity: ComponentComplexity.advanced,
        status: ComponentStatus.planned,
      ),
      ComponentData(
        name: 'Tabs',
        description:
            'A set of layered sections of content—known as tab panels—that are displayed one at a time.',
        category: 'Navigation',
        complexity: ComponentComplexity.intermediate,
        status: ComponentStatus.implemented,
      ),
      ComponentData(
        name: 'Menubar',
        description: 'A horizontal menu bar with dropdown menus.',
        category: 'Navigation',
        complexity: ComponentComplexity.advanced,
        status: ComponentStatus.implemented,
      ),
    ],
    'Feedback & Overlays': [
      ComponentData(
        name: 'Alert',
        description: 'Displays a callout for user attention.',
        category: 'Feedback & Overlays',
        complexity: ComponentComplexity.basic,
        status: ComponentStatus.implemented,
      ),
      ComponentData(
        name: 'Dialog',
        description:
            'A modal dialog that interrupts the user with important content.',
        category: 'Feedback & Overlays',
        complexity: ComponentComplexity.intermediate,
        status: ComponentStatus.implemented,
      ),
      ComponentData(
        name: 'Alert Dialog',
        description:
            'A modal dialog that alerts users with important information.',
        category: 'Feedback & Overlays',
        complexity: ComponentComplexity.intermediate,
        status: ComponentStatus.planned,
      ),
      ComponentData(
        name: 'Sheet',
        description:
            'A sliding panel that appears from the edge of the screen.',
        category: 'Feedback & Overlays',
        complexity: ComponentComplexity.intermediate,
        status: ComponentStatus.planned,
      ),
      ComponentData(
        name: 'Hover Card',
        description:
            'A rich content preview that appears when hovering over a trigger.',
        category: 'Feedback & Overlays',
        complexity: ComponentComplexity.intermediate,
        status: ComponentStatus.planned,
      ),
      ComponentData(
        name: 'Context Menu',
        description: 'A menu that appears when right-clicking on an element.',
        category: 'Feedback & Overlays',
        complexity: ComponentComplexity.intermediate,
        status: ComponentStatus.planned,
      ),
      ComponentData(
        name: 'Tooltip',
        description:
            'A popup that displays information related to an element when the element receives keyboard focus or the mouse hovers over it.',
        category: 'Feedback & Overlays',
        complexity: ComponentComplexity.basic,
        status: ComponentStatus.planned,
      ),
      ComponentData(
        name: 'Popover',
        description: 'A floating panel that appears over other content.',
        category: 'Feedback & Overlays',
        complexity: ComponentComplexity.intermediate,
        status: ComponentStatus.implemented,
      ),
      ComponentData(
        name: 'Toast',
        description: 'A succinct message that is displayed temporarily.',
        category: 'Feedback & Overlays',
        complexity: ComponentComplexity.intermediate,
        status: ComponentStatus.implemented,
      ),
      ComponentData(
        name: 'Sonner',
        description: 'A toast notification system with advanced features.',
        category: 'Feedback & Overlays',
        complexity: ComponentComplexity.intermediate,
        status: ComponentStatus.implemented,
      ),
    ],
    'Data & Visualization': [
      ComponentData(
        name: 'Progress',
        description:
            'Displays an indicator showing the completion progress of a task.',
        category: 'Data & Visualization',
        complexity: ComponentComplexity.basic,
        status: ComponentStatus.implemented,
      ),
      ComponentData(
        name: 'Chart',
        description:
            'Data visualization components for displaying charts and graphs.',
        category: 'Data & Visualization',
        complexity: ComponentComplexity.advanced,
        status: ComponentStatus.planned,
      ),
      ComponentData(
        name: 'Calendar',
        description: 'A calendar component for date selection and scheduling.',
        category: 'Data & Visualization',
        complexity: ComponentComplexity.advanced,
        status: ComponentStatus.implemented,
      ),
      ComponentData(
        name: 'Date Picker',
        description: 'A form input for selecting dates with calendar popup.',
        category: 'Data & Visualization',
        complexity: ComponentComplexity.intermediate,
        status: ComponentStatus.planned,
      ),
      ComponentData(
        name: 'Table',
        description:
            'A structured table component for displaying tabular data.',
        category: 'Data & Visualization',
        complexity: ComponentComplexity.intermediate,
        status: ComponentStatus.implemented,
      ),
    ],
    'Media & Content': [
      ComponentData(
        name: 'Avatar',
        description:
            'An image element with a fallback for representing the user.',
        category: 'Media & Content',
        complexity: ComponentComplexity.basic,
        status: ComponentStatus.implemented,
      ),
      ComponentData(
        name: 'Badge',
        description: 'Displays a badge or a component that looks like a badge.',
        category: 'Media & Content',
        complexity: ComponentComplexity.basic,
        status: ComponentStatus.implemented,
      ),
      ComponentData(
        name: 'Carousel',
        description:
            'A slideshow component for cycling through images or content.',
        category: 'Media & Content',
        complexity: ComponentComplexity.intermediate,
        status: ComponentStatus.planned,
      ),
      ComponentData(
        name: 'Separator',
        description: 'Visually or semantically separates content.',
        category: 'Media & Content',
        complexity: ComponentComplexity.basic,
        status: ComponentStatus.implemented,
      ),
    ],
    'Advanced': [
      ComponentData(
        name: 'Command',
        description:
            'A command palette interface for quick actions and navigation.',
        category: 'Advanced',
        complexity: ComponentComplexity.advanced,
        status: ComponentStatus.planned,
      ),
      ComponentData(
        name: 'Combobox',
        description:
            'A combination of a dropdown and input field with search functionality.',
        category: 'Advanced',
        complexity: ComponentComplexity.advanced,
        status: ComponentStatus.planned,
      ),
    ],
  };

  /// Get all components across all categories
  static List<ComponentData> get allComponents {
    return categories.values.expand((components) => components).toList();
  }

  /// Get implementation progress statistics
  static Map<String, int> getImplementationStats() {
    final stats = <String, int>{
      'total': allComponents.length,
      'implemented': 0,
      'inProgress': 0,
      'planned': 0,
    };

    for (final component in allComponents) {
      switch (component.status) {
        case ComponentStatus.implemented:
          stats['implemented'] = stats['implemented']! + 1;
          break;
        case ComponentStatus.inProgress:
          stats['inProgress'] = stats['inProgress']! + 1;
          break;
        case ComponentStatus.planned:
          stats['planned'] = stats['planned']! + 1;
          break;
      }
    }

    return stats;
  }
}
