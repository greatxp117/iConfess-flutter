import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../widgets/shared/minimal_header.dart';
import '../widgets/shared/mobile_nav_drawer.dart';
import '../routes/go_router_config.dart';

class ArticleDetailScreen extends StatefulWidget {
  final String slug;
  const ArticleDetailScreen({super.key, required this.slug});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    final position = _scrollController.position;
    if (!position.hasPixels || !position.hasContentDimensions) return;
    final max = position.maxScrollExtent <= 0 ? 1 : position.maxScrollExtent;
    final value = (position.pixels / max).clamp(0.0, 1.0);
    if (value != _progress) {
      setState(() => _progress = value);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final article = _ArticleRepository.bySlug(widget.slug);

    if (article == null) {
      return Scaffold(
        drawer: const MobileNavDrawer(),
        body: Column(
          children: [
            MinimalHeader(
              showBack: true,
              onBack: () => context.go(AppRoutes.learn),
              subtitle: 'Article',
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Article not found'),
                    const SizedBox(height: 12),
                    ShadButton(
                      leading: const Icon(LucideIcons.chevronLeft, size: 16),
                      onPressed: () => context.go(AppRoutes.learn),
                      child: const Text('Back to Learn'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    final keys = article.sections.map((_) => GlobalKey()).toList(growable: false);
    final readMinutes = _estimateReadMinutes(article);

    return Scaffold(
      drawer: const MobileNavDrawer(),
      body: Stack(
        children: [
          Column(
            children: [
              MinimalHeader(
                showBack: true,
                onBack: () => context.go(AppRoutes.learn),
                subtitle: 'Reading',
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final wide = constraints.maxWidth >= 1000;
                    return ListView(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      children: [
                        // Hero header
                        _HeroHeader(article: article, readMinutes: readMinutes),
                        const SizedBox(height: 20),
                        if (wide)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left gutter / TOC
                              SizedBox(
                                width: 240,
                                child: _TocPanel(
                                  article: article,
                                  keys: keys,
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Content
                              Expanded(
                                child: _ArticleBody(article: article, keys: keys),
                              ),
                            ],
                          )
                        else
                          Column(
                            children: [
                              // Mobile TOC
                              _TocInline(article: article, keys: keys),
                              const SizedBox(height: 8),
                              _ArticleBody(article: article, keys: keys),
                            ],
                          ),
                        const SizedBox(height: 32),
                        ShadSeparator.horizontal(),
                        const SizedBox(height: 20),
                        _RelatedArticles(currentSlug: article.slug),
                        const SizedBox(height: 24),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          // Reading progress bar pinned to top
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: LinearProgressIndicator(
              value: _progress,
              minHeight: 3,
              color: theme.colorScheme.primary,
              backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.15),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  final _Article article;
  final int readMinutes;
  const _HeroHeader({required this.article, required this.readMinutes});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Gradient hero card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary.withValues(alpha: 0.10),
                theme.colorScheme.secondary.withValues(alpha: 0.10),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: theme.dividerColor.withValues(alpha: 0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.colorScheme.primary.withValues(alpha: 0.35),
                      ),
                    ),
                    child: Icon(LucideIcons.bookOpen, size: 20, color: theme.colorScheme.primary),
                  ),
                  const SizedBox(width: 12),
                  ShadBadge(child: Text(article.primaryTag.toUpperCase())),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                article.title,
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700, height: 1.2),
              ),
              const SizedBox(height: 10),
              Text(
                article.subtitle,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.80),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.grey.withValues(alpha: 0.2),
                    child: Text(article.author[0]),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${article.author} • ${_formatDate(article.publishedAt)} • ${readMinutes} min read',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TocPanel extends StatelessWidget {
  final _Article article;
  final List<GlobalKey> keys;
  const _TocPanel({required this.article, required this.keys});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('On this page', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          ...List.generate(article.sections.length, (i) {
            final s = article.sections[i];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(6),
                onTap: () => _scrollTo(keys[i]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                  child: Row(
                    children: [
                      const Icon(LucideIcons.dot, size: 14),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          s.heading,
                          style: theme.textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        alignment: 0.08,
      );
    }
  }
}

class _TocInline extends StatelessWidget {
  final _Article article;
  final List<GlobalKey> keys;
  const _TocInline({required this.article, required this.keys});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ShadCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('On this page', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(article.sections.length, (i) {
              return ShadButton.secondary(
                size: ShadButtonSize.sm,
                onPressed: () => _scrollTo(keys[i]),
                child: Text(article.sections[i].heading),
              );
            }),
          ),
        ],
      ),
    );
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        alignment: 0.08,
      );
    }
  }
}

class _ArticleBody extends StatelessWidget {
  final _Article article;
  final List<GlobalKey> keys;
  const _ArticleBody({required this.article, required this.keys});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < article.sections.length; i++) ...[
          _SectionBlock(
            key: keys[i],
            section: article.sections[i],
          ),
          const SizedBox(height: 16),
        ],
        const SizedBox(height: 8),
        // Share / CTA
        Row(
          children: [
            ShadButton.ghost(
              leading: const Icon(LucideIcons.share2, size: 16),
              onPressed: () async {
                final uri = GoRouter.of(context).routeInformationProvider.value.uri;
                final sonner = ShadSonner.of(context);
                final id = DateTime.now().millisecondsSinceEpoch;
                sonner.show(
                  ShadToast(
                    id: id,
                    title: const Text('Link ready to share'),
                    description: Text(uri.toString()),
                  ),
                );
              },
              child: const Text('Share'),
            ),
            const SizedBox(width: 8),
            ShadButton(
              leading: const Icon(LucideIcons.bookmark, size: 16),
              onPressed: () {},
              child: const Text('Save'),
            ),
          ],
        ),
      ],
    );
  }
}

class _RelatedArticles extends StatelessWidget {
  final String currentSlug;
  const _RelatedArticles({required this.currentSlug});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final others = _ArticleRepository.all.where((a) => a.slug != currentSlug).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('You might also like', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 640;
            if (isWide) {
              return Row(
                children: [
                  for (final a in others)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: _RelatedCard(article: a),
                      ),
                    ),
                ],
              );
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final a in others)
                    SizedBox(width: 280, child: _RelatedCard(article: a)),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _RelatedCard extends StatelessWidget {
  final _Article article;
  const _RelatedCard({required this.article});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: ShadCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(article.title, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(
              article.subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 12),
            ShadButton.ghost(
              trailing: const Icon(LucideIcons.arrowRight, size: 16),
              onPressed: () => context.push(AppRoutes.articleRoute(article.slug)),
              child: const Text('Read'),
            )
          ],
        ),
      ),
    );
  }
}

class _SectionBlock extends StatelessWidget {
  final _Section section;
  const _SectionBlock({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(section.heading, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        ...section.paragraphs.map((p) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                p,
                style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
              ),
            )),
        if (section.callout != null) ...[
          const SizedBox(height: 6),
          ShadAlert(
            icon: const Icon(LucideIcons.info, size: 18),
            title: Text(section.callout!.title),
            description: Text(section.callout!.content),
          ),
        ],
        if (section.quote != null) ...[
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withValues(alpha: 0.16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('“${section.quote!.text}”', style: theme.textTheme.titleSmall?.copyWith(fontStyle: FontStyle.italic, height: 1.5)),
                const SizedBox(height: 6),
                Text('— ${section.quote!.attribution}', style: theme.textTheme.bodySmall?.copyWith(color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.8))),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

// --- Data layer (mock content) ---

class _ArticleRepository {
  static final List<_Article> all = [
    _ArticlesData.whyConfessionMatters,
    _ArticlesData.howToConfess,
    _ArticlesData.examenTips,
    _ArticlesData.afterConfession,
  ];

  static _Article? bySlug(String slug) => all.firstWhere(
        (a) => a.slug == slug,
        orElse: () => null as _Article,
      );
}

class _ArticlesData {
  static final _Article whyConfessionMatters = _Article(
    slug: 'why-confession-matters',
    title: 'Why Confession Matters',
    subtitle: 'Discover the grace of Reconciliation and how it renews our lives in Christ.',
    author: 'Editorial Team',
    primaryTag: 'basics',
    publishedAt: DateTime(2024, 6, 15),
    sections: [
      _Section(
        heading: 'The gift of mercy',
        paragraphs: [
          'Confession is not about shame—it is about encounter. In the sacrament, we meet the Father who runs to us with mercy.',
          'When we prepare and speak honestly, God restores our friendship with Him and strengthens us to live as His sons and daughters.',
        ],
        quote: _Quote(
          text: 'God never tires of forgiving us; we are the ones who tire of seeking His mercy.',
          attribution: 'Pope Francis',
        ),
      ),
      _Section(
        heading: 'What happens in Confession',
        paragraphs: [
          'After a sincere examination, we confess our sins, receive absolution, and accept a penance that helps us begin anew.',
          'Grace is real: it heals wounds and rekindles hope.',
        ],
        callout: _Callout(
          title: 'Tip',
          content: 'Bring a short list if you’re nervous. The priest is there to help.',
        ),
      ),
    ],
  );

  static final _Article howToConfess = _Article(
    slug: 'how-to-make-a-good-confession',
    title: 'How to Make a Good Confession',
    subtitle: 'A simple, step-by-step guide to a fruitful confession.',
    author: 'Editorial Team',
    primaryTag: 'guide',
    publishedAt: DateTime(2024, 7, 10),
    sections: [
      _Section(
        heading: '1) Examination of conscience',
        paragraphs: [
          'Find a quiet moment. Ask the Holy Spirit for light. Review your life since your last confession with humility and trust.',
        ],
      ),
      _Section(
        heading: '2) Contrition',
        paragraphs: [
          'Tell God you are sorry, above all because sin wounds your friendship with Him. A short act of contrition from the heart is enough.',
        ],
      ),
      _Section(
        heading: '3) Confession, absolution, penance',
        paragraphs: [
          'Simply tell your sins, without drama or excuses. Receive absolution and take your penance seriously—this is your first step forward.',
        ],
        callout: _Callout(
          title: 'Remember',
          content: 'If you forget a sin unintentionally, it is still forgiven.',
        ),
      ),
    ],
  );

  static final _Article examenTips = _Article(
    slug: 'examination-of-conscience-tips',
    title: 'Examination of Conscience Tips',
    subtitle: 'Gentle questions to help you reflect in trust, not anxiety.',
    author: 'Editorial Team',
    primaryTag: 'examen',
    publishedAt: DateTime(2024, 8, 2),
    sections: [
      _Section(
        heading: 'Start with gratitude',
        paragraphs: [
          'Before naming faults, remember God’s gifts. Gratitude clarifies and calms the heart.',
        ],
      ),
      _Section(
        heading: 'Ask simple questions',
        paragraphs: [
          'Have I loved God above all things? Have I loved my neighbor as myself? Where did I fall short?',
        ],
      ),
      _Section(
        heading: 'End with trust',
        paragraphs: [
          'Offer your reflection to God, ask for mercy, and resolve to go to confession soon.',
        ],
        quote: _Quote(
          text: 'In failing we learn to rely on His mercy, not our performance.',
          attribution: 'Anonymous',
        ),
      ),
    ],
  );

  static final _Article afterConfession = _Article(
    slug: 'after-confession-living-mercy',
    title: 'After Confession: Living Mercy',
    subtitle: 'Habits and prayer that keep your heart close to the Father’s mercy.',
    author: 'Editorial Team',
    primaryTag: 'spirituality',
    publishedAt: DateTime(2024, 8, 20),
    sections: [
      _Section(
        heading: 'Keep a short account',
        paragraphs: [
          'A brief nightly examen keeps your heart free, your conscience clear, and your next confession simple.',
        ],
      ),
      _Section(
        heading: 'Practice mercy daily',
        paragraphs: [
          'Offer small acts of kindness and forgive quickly. Mercy received becomes mercy shared.',
        ],
        callout: _Callout(title: 'Practice', content: 'Choose one person to forgive today, even silently before God.'),
      ),
    ],
  );
}

class _Article {
  final String slug;
  final String title;
  final String subtitle;
  final String author;
  final String primaryTag;
  final DateTime publishedAt;
  final List<_Section> sections;
  const _Article({
    required this.slug,
    required this.title,
    required this.subtitle,
    required this.author,
    required this.primaryTag,
    required this.publishedAt,
    required this.sections,
  });
}

class _Section {
  final String heading;
  final List<String> paragraphs;
  final _Callout? callout;
  final _Quote? quote;
  const _Section({
    required this.heading,
    required this.paragraphs,
    this.callout,
    this.quote,
  });
}

class _Callout {
  final String title;
  final String content;
  const _Callout({required this.title, required this.content});
}

class _Quote {
  final String text;
  final String attribution;
  const _Quote({required this.text, required this.attribution});
}

int _estimateReadMinutes(_Article a) {
  final text = [a.title, a.subtitle, ...a.sections.expand((s) => [s.heading, ...s.paragraphs])].join(' ');
  final words = text.trim().split(RegExp(r'\s+')).length;
  final minutes = (words / 220).ceil();
  return minutes < 1 ? 1 : minutes;
}

String _formatDate(DateTime d) {
  // Simple MMM d, y formatting without intl dependency
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  return '${months[d.month - 1]} ${d.day}, ${d.year}';
}
