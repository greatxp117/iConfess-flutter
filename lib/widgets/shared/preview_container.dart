import 'package:flutter/material.dart';

/// Reusable container for displaying component previews
class PreviewContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BoxDecoration? decoration;

  const PreviewContainer({
    super.key,
    required this.child,
    this.padding,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(24),
      decoration:
          decoration ??
          BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(8),
          ),
      child: Center(child: child),
    );
  }
}
