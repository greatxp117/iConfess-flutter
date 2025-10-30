import 'package:flutter/material.dart';

/// Abstract interface for component examples
/// This provides a consistent contract for all component implementations
abstract class ComponentExample {
  /// The name of the component (e.g., 'Button', 'Input', 'Card')
  String get componentName;

  /// Description of what the component does
  String get description;

  /// Available variants of this component
  Map<String, ComponentVariant> get variants;

  /// Builds the preview widget for the component
  /// [context] - The build context
  /// [variantKey] - Optional variant key, defaults to first variant
  Widget buildPreview(BuildContext context, [String? variantKey]);

  /// Returns the code example for the component
  /// [variantKey] - Optional variant key, defaults to first variant
  String getCode([String? variantKey]);

  /// Returns the category this component belongs to
  String get category;

  /// Returns tags associated with this component
  List<String> get tags;

  /// Returns the complexity level of this component
  ComponentComplexity get complexity;
}

/// Represents a variant of a component (different states, configurations)
class ComponentVariant {
  final Widget Function(BuildContext) previewBuilder;
  final String code;
  final String? documentation;
  final Map<String, dynamic>? metadata;

  const ComponentVariant({
    required this.previewBuilder,
    required this.code,
    this.documentation,
    this.metadata,
  });
}

/// Complexity levels for components
enum ComponentComplexity { basic, intermediate, advanced }
