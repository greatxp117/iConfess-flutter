import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../widgets/responsive_nav.dart';
import '../../widgets/shared/component_sidebar.dart';
import '../../widgets/shared/component_tab_bar.dart';
import '../../widgets/shared/code_viewer.dart';
import '../../widgets/shared/preview_container.dart';
import '../../routes/go_router_config.dart';
import 'component_detail_view_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/app_constants.dart';
import '../../theme.dart';
import 'package:iconfess/widgets/shared/mobile_nav_drawer.dart';

/// Main component detail screen with simplified architecture
class ComponentDetailScreen extends StatefulWidget {
  final String componentName;

  const ComponentDetailScreen({
    super.key,
    required this.componentName,
  });

  @override
  State<ComponentDetailScreen> createState() => _ComponentDetailScreenState();
}

class _ComponentDetailScreenState extends State<ComponentDetailScreen> {
  late ComponentDetailViewModel _viewModel;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _viewModel = ComponentDetailViewModel(componentName: widget.componentName);
    _scrollController = ScrollController();
  }

  @override
  void didUpdateWidget(ComponentDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.componentName != widget.componentName) {
      // Dispose the old view model and create a new one
      _viewModel.dispose();
      _viewModel = ComponentDetailViewModel(
        componentName: widget.componentName,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _viewModel),
        ChangeNotifierProvider<ScrollController>.value(
          value: _scrollController,
        ),
      ],
      child: Scaffold(
        key: ValueKey(widget.componentName), // Ensure proper widget recreation
        drawer: const MobileNavDrawer(),
        body: Column(
          children: [
            const ResponsiveNav(),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = constraints.maxWidth >= Breakpoints.lg;
                  return isDesktop ? _DesktopLayout() : _MobileLayout();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Desktop layout with sidebar and main content
class _DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ComponentDetailViewModel>();

    return Row(
      children: [
        // Reusable sidebar
        ComponentSidebar(
          selectedComponent: viewModel.componentName,
          scrollController: context.read<ScrollController>(),
          onComponentsPressed: () => context.go(AppRoutes.components),
          onComponentSelected: (name) =>
              context.go(AppRoutes.componentRoute(name)),
        ),

        // Main content
        Expanded(
          flex: 2,
          child: _MainContent(),
        ),

        // Right sidebar
        const _RightSidebar(),
      ],
    );
  }
}

/// Mobile layout with main content only
class _MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _MainContent();
  }
}

/// Main content area with header, tabs, and content
class _MainContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ComponentDetailViewModel>();

    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ComponentHeader(),
          const SizedBox(height: 32),
          ComponentTabBar(
            selectedTab: viewModel.selectedTab,
            onTabSelected: viewModel.selectTab,
          ),
          if (viewModel.hasVariants) ...[
            const SizedBox(height: 16),
            _VariantSelector(),
          ],
          const SizedBox(height: 16),
          Expanded(child: _TabContent()),
        ],
      ),
    );
  }
}

/// Component header with title and description
class _ComponentHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ComponentDetailViewModel>();
    final componentData = viewModel.componentData;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          viewModel.componentName,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          componentData?.description ?? viewModel.example?.description ?? '',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

/// Variant selector for components with multiple variants
class _VariantSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ComponentDetailViewModel>();

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: viewModel.variants.keys.map((variantKey) {
            final isSelected = viewModel.selectedVariant == variantKey;
            return Padding(
              padding: const EdgeInsets.only(right: 4),
              child: InkWell(
                onTap: () => viewModel.selectVariant(variantKey),
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    variantKey,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                      color: isSelected ? Colors.black : Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

/// Tab content area
class _TabContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ComponentDetailViewModel>();

    if (viewModel.selectedTab == 'Preview') {
      return _buildPreviewTab(context, viewModel);
    } else {
      return _buildCodeTab(context, viewModel);
    }
  }

  Widget _buildPreviewTab(
    BuildContext context,
    ComponentDetailViewModel viewModel,
  ) {
    final example = viewModel.example;
    if (example == null) {
      return const Center(child: Text('No preview available'));
    }

    return PreviewContainer(
      child: example.buildPreview(context, viewModel.selectedVariant),
    );
  }

  Widget _buildCodeTab(
    BuildContext context,
    ComponentDetailViewModel viewModel,
  ) {
    return CodeViewer(
      code: viewModel.currentCode,
      language: 'dart',
    );
  }
}

/// Right sidebar with additional information
class _RightSidebar extends StatelessWidget {
  const _RightSidebar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppConstants.cloneProjectText,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ShadButton(
              onPressed: () => launchUrl(Uri.parse(AppConstants.dreamFlowUrl)),
              child: const Text('Deploy Now'),
            ),
          ],
        ),
      ),
    );
  }
}
