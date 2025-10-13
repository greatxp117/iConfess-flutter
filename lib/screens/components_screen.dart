import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/responsive_nav.dart';
import '../widgets/component_categories.dart';
import '../widgets/shared/component_sidebar.dart';
import '../widgets/component_examples/component_example_registry.dart';
import '../routes/go_router_config.dart';
import '../constants/app_constants.dart';
import '../theme.dart';
import 'package:iconfess/widgets/shared/mobile_nav_drawer.dart';

/// Constants for the ComponentsScreen
class ComponentScreenConstants {
  // Layout constants
  static const double sidebarWidth = 240.0;
  static const double rightSidebarWidth = 300.0;
  static const int mainContentFlex = 2;

  // Spacing constants
  static const EdgeInsets contentPadding = EdgeInsets.all(24.0);
  static const EdgeInsets sidebarPadding = EdgeInsets.all(24.0);
  static const EdgeInsets gridItemPadding = EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 8,
  );
  static const double headerSpacing = 16.0;
  static const double descriptionSpacing = 32.0;
  static const double rightSidebarButtonSpacing = 20.0;

  // Grid constants
  static const int gridCrossAxisCount = 3;
  static const double gridChildAspectRatio = 4.0;
  static const double gridCrossAxisSpacing = 16.0;
  static const double gridMainAxisSpacing = 12.0;

  // Border constants
  static const double borderWidth = 1.0;
  static const double borderRadius = 6.0;
  static const double sidebarBorderOpacity = 0.1;

  // Text constants
  static const double headerFontSize = 32.0;
  static const double descriptionFontSize = 16.0;
  static const double gridItemFontSize = 14.0;
  static const double rightSidebarTitleFontSize = 18.0;

  // Grid delegate
  static const SliverGridDelegateWithFixedCrossAxisCount gridDelegate =
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridCrossAxisCount,
        childAspectRatio: gridChildAspectRatio,
        crossAxisSpacing: gridCrossAxisSpacing,
        mainAxisSpacing: gridMainAxisSpacing,
      );
}

class ComponentsScreen extends StatefulWidget {
  const ComponentsScreen({super.key});

  @override
  State<ComponentsScreen> createState() => _ComponentsScreenState();
}

class _ComponentsScreenState extends State<ComponentsScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MobileNavDrawer(),
      body: Column(
        children: [
          // Navigation bar
          const ResponsiveNav(),
          // Main content
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isDesktop = constraints.maxWidth >= Breakpoints.lg;

                if (isDesktop) {
                  return _buildDesktopLayout(context);
                } else {
                  return _buildMobileLayout(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        // Left Sidebar - Using the new reusable ComponentSidebar
        ComponentSidebar(
          selectedComponent: 'Components', // This screen shows all components
          scrollController: _scrollController,
          onComponentsPressed: null, // Already on components page
          onComponentSelected: (name) {
            context.go(AppRoutes.componentRoute(name));
          },
        ),
        // Main Content
        Expanded(
          flex: ComponentScreenConstants.mainContentFlex,
          child: _buildMainContent(context),
        ),
        // Right Sidebar
        Container(
          width: ComponentScreenConstants.rightSidebarWidth,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Theme.of(context).dividerColor.withValues(
                  alpha: ComponentScreenConstants.sidebarBorderOpacity,
                ),
                width: ComponentScreenConstants.borderWidth,
              ),
            ),
          ),
          child: _buildRightSidebar(context),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return _buildMainContent(context);
  }

  Widget _buildMainContent(BuildContext context) {
    // Get only implemented components
    final components = ComponentCategories.allComponents
        .where(
          (component) => ComponentExampleRegistry.hasExample(component.name),
        )
        .toList();

    // Sort alphabetically
    components.sort((a, b) => a.name.compareTo(b.name));

    return Padding(
      padding: ComponentScreenConstants.contentPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Text(
                'Components',
                style: TextStyle(
                  fontSize: ComponentScreenConstants.headerFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
            ],
          ),
          SizedBox(height: ComponentScreenConstants.headerSpacing),

          // Description
          Text(
            'Here you can find all the implemented components available in the library.',
            style: TextStyle(
              fontSize: ComponentScreenConstants.descriptionFontSize,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: ComponentScreenConstants.descriptionSpacing),

          // Components Section
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Components Section
                  if (components.isNotEmpty) ...[
                    _buildSectionHeader('Components', components.length),
                    const SizedBox(height: 16),
                    _buildComponentsGrid(components, context),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComponentGridItem(String name, BuildContext context) {
    return InkWell(
      onTap: () {
        context.go(AppRoutes.componentRoute(name));
      },
      borderRadius: BorderRadius.circular(
        ComponentScreenConstants.borderRadius,
      ),
      child: Container(
        padding: ComponentScreenConstants.gridItemPadding,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade200,
          ),
          borderRadius: BorderRadius.circular(
            ComponentScreenConstants.borderRadius,
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            name,
            style: TextStyle(
              fontSize: ComponentScreenConstants.gridItemFontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, int count) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 12),
        ShadBadge.secondary(child: Text('$count')),
      ],
    );
  }

  Widget _buildComponentsGrid(
    List<ComponentData> components,
    BuildContext context,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: _responsiveGridDelegate(context),
      itemCount: components.length,
      itemBuilder: (context, index) {
        return _buildComponentGridItem(components[index].name, context);
      },
    );
  }

  SliverGridDelegate _responsiveGridDelegate(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    int crossAxisCount;
    double aspect;

    if (width >= Breakpoints.lg) {
      crossAxisCount = ComponentScreenConstants.gridCrossAxisCount; // 3
      aspect = ComponentScreenConstants.gridChildAspectRatio; // 4.0
    } else if (width >= Breakpoints.md) {
      crossAxisCount = 2;
      aspect = 3.2;
    } else {
      crossAxisCount = 2;
      aspect = 2.8;
    }

    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      childAspectRatio: aspect,
      crossAxisSpacing: ComponentScreenConstants.gridCrossAxisSpacing,
      mainAxisSpacing: ComponentScreenConstants.gridMainAxisSpacing,
    );
  }

  Widget _buildRightSidebar(BuildContext context) {
    return Padding(
      padding: ComponentScreenConstants.sidebarPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppConstants.cloneProjectText,
            style: TextStyle(
              fontSize: ComponentScreenConstants.rightSidebarTitleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: ComponentScreenConstants.rightSidebarButtonSpacing),
          ShadButton(
            onPressed: () => launchUrl(Uri.parse(AppConstants.dreamFlowUrl)),
            child: const Text(AppConstants.openInDreamflowText),
          ),
        ],
      ),
    );
  }
}
