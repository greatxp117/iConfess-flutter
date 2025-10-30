import 'package:flutter/material.dart';
import '../../widgets/component_examples/component_example_interface.dart'
    as example_interface;
import '../../widgets/component_examples/component_example_registry.dart';
import '../../widgets/component_categories.dart';

/// View model for the component detail screen
/// Handles business logic and state management
class ComponentDetailViewModel extends ChangeNotifier {
  final String componentName;
  example_interface.ComponentExample? _example;
  String _selectedTab = 'Preview';
  String? _selectedVariant;
  bool _isLoading = true;

  ComponentDetailViewModel({required this.componentName}) {
    _loadComponentData();
  }

  /// Load component data from registry
  void _loadComponentData() {
    _isLoading = true;
    notifyListeners();

    // Get component example from registry
    _example = ComponentExampleRegistry.get(componentName);

    // Set default variant if available
    if (_example != null && _example!.variants.isNotEmpty) {
      _selectedVariant = _example!.variants.keys.first;
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Get component data from categories
  ComponentData? get componentData {
    return ComponentCategories.allComponents.firstWhere(
      (c) => c.name == componentName,
    );
  }

  /// Get the component example
  example_interface.ComponentExample? get example => _example;

  /// Get selected tab
  String get selectedTab => _selectedTab;

  /// Get selected variant
  String? get selectedVariant => _selectedVariant;

  /// Check if component has variants
  bool get hasVariants => (_example?.variants.length ?? 0) > 1;

  /// Get available variants
  Map<String, example_interface.ComponentVariant> get variants =>
      _example?.variants ?? {};

  /// Check if data is loading
  bool get isLoading => _isLoading;

  /// Get current code
  String get currentCode {
    if (_example == null) return '';
    return _example!.getCode(_selectedVariant);
  }

  /// Select a tab
  void selectTab(String tab) {
    if (_selectedTab != tab) {
      _selectedTab = tab;
      notifyListeners();
    }
  }

  /// Select a variant
  void selectVariant(String variant) {
    if (_selectedVariant != variant) {
      _selectedVariant = variant;
      notifyListeners();
    }
  }
}
