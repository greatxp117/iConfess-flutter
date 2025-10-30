import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../widgets/shared/minimal_header.dart';
import '../widgets/shared/mobile_nav_drawer.dart';
import '../routes/go_router_config.dart';
import 'package:iconfess/constants/app_constants.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      drawer: const MobileNavDrawer(),
      body: Column(
        children: [
          const MinimalHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              children: [
                Text(
                  'Learn',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    shadows: TextDepth.soft,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Articles to prepare well for Confession',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.75),
                  ),
                ),
                const SizedBox(height: 16),
                ..._articles.map((a) => _ArticleCard(article: a)).toList(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Article {
  final String title;
  final String excerpt;
  final List<String> tags;
  final String? url; // could be used later for detail
  const _Article({required this.title, required this.excerpt, this.tags = const [], this.url});
}

const _articles = <_Article>[
  _Article(
    title: 'Why Confession Matters',
    excerpt:
        'Discover the grace of the Sacrament of Reconciliation and how it renews our lives in Christ.',
    tags: ['basics', 'sacrament'],
  ),
  _Article(
    title: 'How to Make a Good Confession',
    excerpt:
        'A simple, step-by-step guide: examination, contrition, confession, absolution, and penance.',
    tags: ['guide', 'how-to'],
  ),
  _Article(
    title: 'Examination of Conscience Tips',
    excerpt:
        'Gentle questions to help you reflect in truth and trust, without anxiety or scruples.',
    tags: ['examen', 'pastoral'],
  ),
  _Article(
    title: 'After Confession: Living Mercy',
    excerpt:
        'Ideas for prayer and habits that keep your heart close to the Father’s mercy.',
    tags: ['spirituality'],
  ),
];

class _ArticleCard extends StatelessWidget {
  final _Article article;
  const _ArticleCard({required this.article});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: _TappableArticleCard(article: article),
    );
  }
}

String _slugify(String input) {
  var s = input.trim().toLowerCase();
  s = s.replaceAll(RegExp(r'[^a-z0-9]+'), '-');
  s = s.replaceAll(RegExp(r'-{2,}'), '-');
  while (s.startsWith('-')) {
    s = s.substring(1);
  }
  while (s.endsWith('-')) {
    s = s.substring(0, s.length - 1);
  }
  return s;
}

class _TappableArticleCard extends StatelessWidget {
  final _Article article;
  const _TappableArticleCard({required this.article});

  void _open(BuildContext context) {
    final slug = _slugify(article.title);
    context.push(AppRoutes.articleRoute(slug));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        boxShadow: AppShadows.elevation1,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _open(context),
          child: ShadCard(
            padding: const EdgeInsets.all(16),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: theme.colorScheme.primary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Icon(LucideIcons.bookOpen, size: 20, color: theme.colorScheme.primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.title,
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          article.excerpt,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.8),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final tag in article.tags)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.14)),
                      ),
                      child: Text(
                        tag,
                        style: theme.textTheme.labelMedium,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  ShadButton.ghost(
                    leading: const Padding(
                      padding: EdgeInsets.only(right: 6),
                      child: Icon(LucideIcons.arrowRight, size: 16),
                    ),
                    onPressed: () => _open(context),
                    child: const Text('Read more'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
