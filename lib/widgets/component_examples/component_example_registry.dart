import 'component_example_interface.dart';
import 'form/calendar_example.dart';
import 'form/button_example.dart';
import 'form/checkbox_example.dart';
import 'form/form_example.dart';
import 'form/icon_button_example.dart';
import 'form/input_example.dart';
import 'form/input_otp_example.dart';
import 'form/radio_group_example.dart';
import 'form/select_example.dart';
import 'form/switch_example.dart';
import 'form/slide_example.dart';
import 'form/textarea_example.dart';
import 'form/time_picker_example.dart';
import 'layout/accordion_example.dart';
import 'layout/card_example.dart';
import 'layout/resizable_example.dart';
import 'navigation/tabs_example.dart';
import 'navigation/menubar_example.dart';
import 'feedback/toast_example.dart';
import 'feedback/sonner_example.dart';
import 'feedback/alert_example.dart';
import 'feedback/dialog_example.dart';
import 'feedback/popover_example.dart';
import 'media/avatar_example.dart';
import 'media/badge_example.dart';
import 'navigation/menu_example.dart';
import 'data/progress_example.dart';
import 'data/table_example.dart';

/// Central registry for all component examples
/// This provides a single point of access to all component implementations
class ComponentExampleRegistry {
  static final Map<String, ComponentExample> _examples = {};
  static bool _isInitialized = false;

  /// Register a component example
  static void register(ComponentExample example) {
    _examples[example.componentName] = example;
  }

  /// Register all component examples at once
  /// This should be called once at app startup
  static void registerAll() {
    if (_isInitialized) return;

    // Register all component examples
    register(CalendarExample());
    register(ButtonExample());
    register(CheckboxExample());
    register(FormExample());
    register(IconButtonExample());
    register(InputExample());
    register(InputOTPExample());
    register(RadioGroupExample());
    register(SelectExample());
    register(SwitchExample());
    register(SlideExample());
    register(TextareaExample());
    register(TimePickerExample());
    register(TabsExample());
    register(MenubarExample());
    register(ToastExample());
    register(AccordionExample());
    register(CardExample());
    register(ResizableExample());
    register(AlertExample());
    register(DialogExample());
    register(PopoverExample());
    register(AvatarExample());
    register(BadgeExample());
    register(MenuExample());
    register(ProgressExample());
    register(SonnerExample());
    register(TableExample());

    _isInitialized = true;
  }

  /// Get a component example by name
  static ComponentExample? get(String componentName) {
    return _examples[componentName];
  }

  /// Check if a component example exists
  static bool hasExample(String componentName) {
    return _examples.containsKey(componentName);
  }

  /// Get all registered component names
  static List<String> get allComponentNames {
    return _examples.keys.toList()..sort();
  }

  /// Get all registered component examples
  static List<ComponentExample> get allExamples {
    return _examples.values.toList();
  }

  /// Get components by category
  static List<ComponentExample> getComponentsByCategory(String category) {
    return _examples.values
        .where((example) => example.category == category)
        .toList();
  }

  /// Get components by complexity
  static List<ComponentExample> getComponentsByComplexity(
      ComponentComplexity complexity) {
    return _examples.values
        .where((example) => example.complexity == complexity)
        .toList();
  }

  /// Search components by name, description, or tags
  static List<ComponentExample> searchComponents(String query) {
    final lowerQuery = query.toLowerCase();
    return _examples.values.where((example) {
      return example.componentName.toLowerCase().contains(lowerQuery) ||
          example.description.toLowerCase().contains(lowerQuery) ||
          example.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
    }).toList();
  }

  /// Clear all registered examples (useful for testing)
  static void clear() {
    _examples.clear();
    _isInitialized = false;
  }

  /// Get the count of registered examples
  static int get count => _examples.length;
}
