# 🎨 Shadcn UI Flutter Template

A modern, responsive Flutter application template showcasing the **shadcn/ui** design system components. Built with clean architecture, responsive design, and best practices in mind.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

## ✨ Features

- 🎨 **Complete Shadcn UI Library** - 30+ beautiful, accessible components based on the popular shadcn/ui design system
- 📱 **Responsive Design** - Adaptive layouts for mobile, tablet, and desktop with breakpoint management
- 🌙 **Dark/Light Theme** - Built-in theme switching with persistent state using singleton pattern
- 🧩 **Interactive Component Showcase** - Live preview and copy-paste code examples for all components
- 🎯 **Clean Architecture** - Well-organized code structure with component registry and categorization
- 🚀 **Performance Optimized** - Efficient rendering, const constructors, and optimized state management
- ♿ **Accessibility Ready** - Built with accessibility in mind and screen reader support
- 📖 **Comprehensive Documentation** - Detailed component documentation with usage examples and best practices
- 🔧 **Developer Friendly** - Centralized constants, type-safe routing, and maintainable codebase
- 🎪 **Component Registry** - Centralized component management with search and filtering capabilities

## 🛠️ Components Included

### Form Elements
- ✅ **Button** - Primary, secondary, outline, destructive, and ghost variants with icons
- ✅ **IconButton** - Clickable icon buttons with multiple variants
- ✅ **Input** - Text fields with placeholder, validation, and icons
- ✅ **InputOTP** - One-time password input with individual slots
- ✅ **Checkbox** - Interactive checkboxes with labels and group selection
- ✅ **RadioGroup** - Radio button groups for single selection
- ✅ **Select** - Dropdown selection with search and multiple selection
- ✅ **Switch** - Toggle switches with custom styling
- ✅ **Slide** - Range sliders with custom steps
- ✅ **Textarea** - Multi-line text input with auto-resize
- ✅ **TimePicker** - Time selection component
- ✅ **Form** - Complete form with validation and state management

### Display Elements
- ✅ **Card** - Flexible content containers with various layouts
- ✅ **Alert** - Informational, warning, and error alerts
- ✅ **Badge** - Status indicators and labels with variants
- ✅ **Avatar** - User profile images with fallbacks and status indicators
- ✅ **Progress** - Linear and circular progress indicators
- ✅ **Table** - Data tables with sorting and pagination

### Layout Elements
- ✅ **Accordion** - Collapsible content panels
- ✅ **Resizable** - Resizable panels with custom handles

### Navigation
- ✅ **Responsive Navigation** - Adaptive navigation bar
- ✅ **Tabs** - Tab-based content organization
- ✅ **Menu** - Dropdown menus with nested items
- ✅ **Menubar** - Application menu bar with keyboard navigation

### Feedback
- ✅ **Toast** - Temporary notifications with actions
- ✅ **Sonner** - Modern toast notifications
- ✅ **Dialog** - Modal dialogs with forms and confirmations
- ✅ **Popover** - Contextual popups with rich content

### Data Display
- ✅ **Calendar** - Date picker with multiple selection modes
- ✅ **Progress** - Progress bars and circular indicators

*All components include interactive examples, code samples, and documentation!*

## 🚀 Quick Start

### Prerequisites

- **Flutter SDK**: >= 3.6.1
- **Dart SDK**: >= 3.0.0
- **IDE**: VS Code, Android Studio, or IntelliJ IDEA
- **Platforms**: iOS, Android, Web, macOS, Windows, Linux

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/shadcn-flutter-template.git
   cd shadcn-flutter-template
   ```
   
   *Or use this template directly from DreamFlow:*
   ```bash
   # Clone from DreamFlow template
   git clone https://github.com/dreamflow-app/shadcn-flutter-template.git
   cd shadcn-flutter-template
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### Development Setup

1. **Enable Flutter Web (optional)**
   ```bash
   flutter config --enable-web
   ```

2. **Run on specific platform**
   ```bash
   # Web
   flutter run -d chrome
   
   # iOS Simulator
   flutter run -d ios
   
   # Android Emulator
   flutter run -d android
   ```

## 📁 Project Structure

```
lib/
├── main.dart                           # Application entry point
├── constants/                          # Application constants
│   └── app_constants.dart             # Centralized constants and URLs
├── routes/                            # Navigation configuration
│   └── go_router_config.dart          # GoRouter setup and route definitions
├── screens/                           # Screen widgets
│   ├── home_screen.dart               # Landing page
│   ├── components_screen.dart         # Component gallery
│   └── component_detail/              # Component detail screens
│       ├── component_detail_screen.dart    # Individual component details
│       └── component_detail_view_model.dart # Component detail state management
└── widgets/                           # Reusable widgets
    ├── responsive_nav.dart            # Responsive navigation component
    ├── theme_manager.dart             # Theme state management
    ├── component_categories.dart      # Component categorization system
    ├── header_component.dart          # Landing page header
    ├── shared/                        # Shared UI components
    │   ├── component_sidebar.dart     # Sidebar navigation
    │   ├── code_viewer.dart          # Syntax-highlighted code display
    │   ├── component_tab_bar.dart    # Tab navigation for components
    │   └── preview_container.dart    # Component preview wrapper
    └── component_examples/           # Component implementations
        ├── component_example_interface.dart  # Component interface definition
        ├── component_example_registry.dart   # Component registration system
        ├── form/                     # Form components (Button, Input, etc.)
        ├── layout/                   # Layout components (Card, Accordion, etc.)
        ├── navigation/               # Navigation components (Tabs, Menu, etc.)
        ├── feedback/                 # Feedback components (Toast, Dialog, etc.)
        ├── media/                    # Media components (Avatar, Badge, etc.)
        └── data/                     # Data components (Table, Progress, etc.)
```

## 🎨 Theming

The template includes a robust theming system with a clean light mode design:

```dart
// Use the predefined light theme
theme: lightTheme,
```

### Customizing Colors

Modify the theme colors in `main.dart`:

```dart
ShadThemeData(
  brightness: Brightness.light,
  colorScheme: const ShadSlateColorScheme.light(), // Change to your preferred color scheme
)
```

## 🧩 Using Components

### Basic Button Example

```dart
import 'package:shadcn_ui/shadcn_ui.dart';

ShadButton(
  onPressed: () {
    // Handle button press
  },
  child: const Text('Click me'),
)
```

### Card with Content

```dart
ShadCard(
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        const Text('Card Title', 
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
        ),
        const SizedBox(height: 8),
        const Text('Card content goes here.'),
      ],
    ),
  ),
)
```

### Form Input

```dart
ShadInput(
  placeholder: const Text('Enter your email'),
  onChanged: (value) {
    // Handle input change
  },
)
```

## 📱 Responsive Design

The template uses `ShadResponsiveBuilder` for adaptive layouts:

```dart
ShadResponsiveBuilder(
  builder: (context, breakpoint) {
    final isDesktop = breakpoint >= ShadTheme.of(context).breakpoints.lg;
    final isTablet = breakpoint >= ShadTheme.of(context).breakpoints.md;
    
    if (isDesktop) {
      return DesktopLayout();
    } else if (isTablet) {
      return TabletLayout();
    } else {
      return MobileLayout();
    }
  },
)
```

## 🏗️ Building for Production

### Web Deployment

```bash
flutter build web --release
```

### Mobile App Bundle

```bash
# Android
flutter build appbundle --release

# iOS
flutter build ipa --release
```

## 📋 Scripts

Add these scripts to your development workflow:

```bash
# Format code
dart format .

# Analyze code
flutter analyze

# Run tests
flutter test

# Clean and rebuild
flutter clean && flutter pub get

# Prepare for template distribution (removes build artifacts)
./cleanup-for-template.sh
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Guidelines

1. Follow the existing code style and structure
2. Add tests for new components
3. Update documentation for any changes
4. Ensure all platforms build successfully

## 📖 Documentation

- [Flutter Documentation](https://docs.flutter.dev/)
- [Shadcn UI Documentation](https://ui.shadcn.com/)
- [Shadcn UI Flutter Package](https://pub.dev/packages/shadcn_ui)
- [Material Design Guidelines](https://material.io/design)
- [Go Router Documentation](https://pub.dev/packages/go_router)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 💖 Acknowledgments

- [shadcn/ui](https://ui.shadcn.com/) for the amazing design system
- [Flutter team](https://flutter.dev/) for the incredible framework
- [shadcn_ui package](https://pub.dev/packages/shadcn_ui) for the Flutter implementation
- [DreamFlow](https://dreamflow.app/) for the template platform
- [Go Router](https://pub.dev/packages/go_router) for excellent navigation

## 📞 Support

If you have any questions or need help getting started, please:

- Open an issue on GitHub
- Check the [discussions](https://github.com/your-username/shadcn-flutter-template/discussions) page
- Review the component examples in the app
- Visit [DreamFlow](https://dreamflow.app/) for more templates and resources

---

**Happy coding! 🚀**
