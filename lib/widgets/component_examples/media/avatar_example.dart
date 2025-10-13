import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../component_example_interface.dart' as example_interface;

/// Avatar component implementation using the new architecture
class AvatarExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'Avatar';

  @override
  String get description =>
      'An image element with a fallback for representing the user.';

  @override
  String get category => 'Media & Content';

  @override
  List<String> get tags => ['image', 'user', 'profile', 'fallback'];

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.basic;

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
        'Basic': example_interface.ComponentVariant(
          previewBuilder: (context) => _buildBasicAvatars(),
          code: _getBasicCode(),
        ),
        'Sizes': example_interface.ComponentVariant(
          previewBuilder: (context) => _buildSizedAvatars(),
          code: _getSizesCode(),
        ),
        'With Status': example_interface.ComponentVariant(
          previewBuilder: (context) => _buildStatusAvatar(),
          code: _getStatusCode(),
        ),
        'Avatar Group': example_interface.ComponentVariant(
          previewBuilder: (context) => _buildAvatarGroup(),
          code: _getGroupCode(),
        ),
      };

  @override
  Widget buildPreview(BuildContext context, [String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.previewBuilder(context) ?? const SizedBox();
  }

  @override
  String getCode([String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.code ?? '';
  }

  Widget _buildBasicAvatars() {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShadAvatar(
          'https://images.unsplash.com/photo-1494790108755-2616b612b786?&w=128&h=128&dpr=2&q=80',
          placeholder: Text('SM'),
        ),
        SizedBox(width: 12),
        ShadAvatar(
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?&w=128&h=128&dpr=2&q=80',
          placeholder: Text('JD'),
        ),
        SizedBox(width: 12),
        ShadAvatar(
          '', // Empty URL to show fallback
          placeholder: Text('AB'),
        ),
      ],
    );
  }

  Widget _buildSizedAvatars() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Small avatar
        SizedBox(
          width: 32,
          height: 32,
          child: const ShadAvatar(
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?&w=64&h=64&dpr=2&q=80',
            placeholder: Text('S', style: TextStyle(fontSize: 12)),
          ),
        ),
        const SizedBox(width: 12),
        // Medium avatar (default)
        const ShadAvatar(
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?&w=128&h=128&dpr=2&q=80',
          placeholder: Text('M'),
        ),
        const SizedBox(width: 12),
        // Large avatar
        SizedBox(
          width: 64,
          height: 64,
          child: const ShadAvatar(
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?&w=128&h=128&dpr=2&q=80',
            placeholder: Text('L', style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusAvatar() {
    return Stack(
      children: [
        const ShadAvatar(
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?&w=128&h=128&dpr=2&q=80',
          placeholder: Text('ON'),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.green,
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarGroup() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ShadAvatar(
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?&w=128&h=128&dpr=2&q=80',
          placeholder: Text('U1'),
        ),
        Transform.translate(
          offset: const Offset(-8, 0),
          child: const ShadAvatar(
            'https://images.unsplash.com/photo-1494790108755-2616b612b786?&w=128&h=128&dpr=2&q=80',
            placeholder: Text('U2'),
          ),
        ),
        Transform.translate(
          offset: const Offset(-16, 0),
          child: const ShadAvatar(
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?&w=128&h=128&dpr=2&q=80',
            placeholder: Text('U3'),
          ),
        ),
        Transform.translate(
          offset: const Offset(-24, 0),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Center(
              child: Text(
                '+2',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getBasicCode() {
    return '''// Basic Avatar with Image
ShadAvatar(
  'https://images.unsplash.com/photo-1494790108755-2616b612b786?&w=128&h=128&dpr=2&q=80',
  placeholder: Text('SM'),
)

// Avatar with Fallback Text
ShadAvatar(
  '', // Empty or invalid URL
  placeholder: const Text('AB'),
)''';
  }

  String _getSizesCode() {
    return '''// Small Avatar
SizedBox(
  width: 32,
  height: 32,
  child: const ShadAvatar(
    'https://example.com/avatar.jpg',
    placeholder: Text('S', style: TextStyle(fontSize: 12)),
  ),
)

// Medium Avatar (Default)
ShadAvatar(
  'https://example.com/avatar.jpg',
  placeholder: Text('M'),
)

// Large Avatar
SizedBox(
  width: 64,
  height: 64,
  child: const ShadAvatar(
    'https://example.com/avatar.jpg',
    placeholder: Text('L', style: TextStyle(fontSize: 18)),
  ),
)''';
  }

  String _getStatusCode() {
    return '''// Avatar with Status Indicator
Stack(
  children: [
    const ShadAvatar(
      'https://example.com/avatar.jpg',
      placeholder: Text('ON'),
    ),
    Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: Colors.green, // Online status
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    ),
  ],
)''';
  }

  String _getGroupCode() {
    return '''// Avatar Group (Overlapping)
Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    const ShadAvatar(
      'https://example.com/avatar1.jpg',
      placeholder: Text('U1'),
    ),
    Transform.translate(
      offset: const Offset(-8, 0), // Overlap by 8px
      child: const ShadAvatar(
        'https://example.com/avatar2.jpg',
        placeholder: Text('U2'),
      ),
    ),
    Transform.translate(
      offset: const Offset(-16, 0), // Overlap by 16px total
      child: const ShadAvatar(
        'https://example.com/avatar3.jpg',
        placeholder: Text('U3'),
      ),
    ),
    // "More users" indicator
    Transform.translate(
      offset: const Offset(-24, 0),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: const Center(
          child: Text('+2', style: TextStyle(fontSize: 12)),
        ),
      ),
    ),
  ],
)''';
  }
}
