import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/ui_state.dart';
import '../widgets/shared/minimal_header.dart';
import 'package:iconfess/constants/app_constants.dart';

enum ExamenProfile { child, student, single, married }

enum ExamenFlowStep { profile, beginPrayer, commandments, endPrayer, review }

class Commandment {
  final int number; // 1-10
  final String title;
  final String summary;
  final List<ExamenQuestion> questions;
  Commandment({
    required this.number,
    required this.title,
    required this.summary,
    required this.questions,
  });
}

class ExamenQuestion {
  final String id;
  final String text;
  final Set<ExamenProfile>? profiles; // null = all
  ExamenQuestion({required this.id, required this.text, this.profiles});
}

class ExamenResult {
  ExamenProfile? profile;
  final Map<String, bool> answers; // key: questionId
  final Map<String, String> notes; // optional notes per question
  DateTime? savedAt;

  ExamenResult({this.profile, Map<String, bool>? answers, Map<String, String>? notes})
      : answers = answers ?? {},
        notes = notes ?? {};

  Map<String, dynamic> toJson() => {
        'profile': profile?.name,
        'answers': answers,
        'notes': notes,
        'savedAt': savedAt?.toIso8601String(),
      };

  static ExamenResult fromJson(Map<String, dynamic> json) {
    final result = ExamenResult(
      profile: json['profile'] != null
          ? ExamenProfile.values.firstWhere(
              (e) => e.name == json['profile'],
              orElse: () => ExamenProfile.single,
            )
          : null,
      answers: (json['answers'] as Map?)?.map((k, v) => MapEntry(k.toString(), v == true)) ?? {},
      notes: (json['notes'] as Map?)?.map((k, v) => MapEntry(k.toString(), v.toString())) ?? {},
    );
    final savedAtRaw = json['savedAt'] as String?;
    if (savedAtRaw != null) {
      result.savedAt = DateTime.tryParse(savedAtRaw);
    }
    return result;
  }
}

class ExaminationScreen extends StatelessWidget {
  const ExaminationScreen({super.key});

  Future<void> _openExaminationSheet(BuildContext context) async {
    try {
      GlobalUiState.examenSheetOpen.value = true;
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) {
          final height = MediaQuery.of(context).size.height;
          return SizedBox(
            height: height * 0.96,
            child: const ExamenFlowSheet(),
          );
        },
      );
    } finally {
      GlobalUiState.examenSheetOpen.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: Column(
          children: [
            const MinimalHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text(
                    'Examination of Conscience',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      shadows: TextDepth.soft,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'A gentle, guided way to prepare for the Sacrament of Reconciliation.',
                    style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  ShadCard(
                    title: const Text('What to expect'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(height: 8),
                        Text('• Choose your profile (child, student, single, or married).'),
                        SizedBox(height: 6),
                        Text('• Begin with a short prayer asking the Holy Spirit to guide you.'),
                        SizedBox(height: 6),
                        Text('• Reflect on the Ten Commandments through concise questions.'),
                        SizedBox(height: 6),
                        Text('• Conclude with the Act of Contrition.'),
                        SizedBox(height: 6),
                        Text('• Review your selections and optionally save them locally.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  ShadAlert(
                    title: const Text('Privacy'),
                    description: Text(
                      'Your selections never leave your device. Saved examinations are stored locally and can be cleared anytime.',
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ShadButton(
                          onPressed: () => _openExaminationSheet(context),
                          child: const Text('Begin Examination'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExamenFlowSheet extends StatefulWidget {
  const ExamenFlowSheet({super.key});

  @override
  State<ExamenFlowSheet> createState() => _ExamenFlowSheetState();
}

class _ExamenFlowSheetState extends State<ExamenFlowSheet> {
  static const _storageKey = 'examen_latest';
  static const _profileKey = 'examen_profile';
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  ExamenFlowStep _currentStep = ExamenFlowStep.profile;
  late List<Commandment> _commandments;
  ExamenResult _result = ExamenResult();
  bool _saving = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _commandments = _buildCommandments();
    _loadSaved();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final steps = ExamenFlowStep.values;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Column(
          children: [
            _buildTopBar(context),
            _buildStepProgress(context),
            const SizedBox(height: 8),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildProfileStep(context),
                  _buildBeginPrayerStep(context),
                  _buildCommandmentsStep(context),
                  _buildEndPrayerStep(context),
                  _buildReviewStep(context),
                ],
              ),
            ),
            _buildBottomNav(context, steps.indexOf(_currentStep), steps.length),
          ],
        ),
      ),
    );
  }

  // Top title bar to keep brand and a reset button
  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          const Icon(Icons.checklist, color: Colors.blue),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Examination of Conscience',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          ShadButton.ghost(
            onPressed: _confirmReset,
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  // Horizontal step indicator using shadcn badges
  Widget _buildStepProgress(BuildContext context) {
    final steps = [
      ('Profile', ExamenFlowStep.profile),
      ('Begin Prayer', ExamenFlowStep.beginPrayer),
      ('Commandments', ExamenFlowStep.commandments),
      ('End Prayer', ExamenFlowStep.endPrayer),
      ('Review', ExamenFlowStep.review),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          for (final s in steps) ...[
            _currentStep == s.$2
                ? ShadBadge(child: Text(s.$1))
                : ShadBadge.secondary(child: Text(s.$1)),
            if (s != steps.last) const Padding(padding: EdgeInsets.symmetric(horizontal: 6), child: Icon(Icons.chevron_right, size: 16, color: Colors.grey)),
          ]
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context, int index, int total) {
    final isFirst = index == 0;
    final isLast = index == total - 1;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        child: Row(
          children: [
            Expanded(
              child: ShadButton.outline(
                onPressed: isFirst ? null : () => _goToStep(index - 1),
                child: const Text('Back'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ShadButton(
                onPressed: isLast ? _saveResults : () => _goToStep(index + 1),
                child: isLast
                    ? (_saving ? const Row(mainAxisAlignment: MainAxisAlignment.center, children: [SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)), SizedBox(width: 8), Text('Saving...')]) : const Text('Save'))
                    : const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goToStep(int newIndex) {
    final steps = ExamenFlowStep.values;
    if (newIndex < 0 || newIndex >= steps.length) return;
    setState(() => _currentStep = steps[newIndex]);
    _pageController.animateToPage(newIndex, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
  }

  // Step 1: Profile selection
  Widget _buildProfileStep(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ShadCard(
        title: const Text('Who are you examining your conscience as?'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('This helps tailor the questions to your state of life.'),
            const SizedBox(height: 8),
            ShadRadioGroup<ExamenProfile>(
              onChanged: (v) {
                setState(() => _result.profile = v);
                _persistProfile(v);
              },
              items: [
                ShadRadio(value: ExamenProfile.child, label: const Text('Child')),
                ShadRadio(value: ExamenProfile.student, label: const Text('Student')),
                ShadRadio(value: ExamenProfile.single, label: const Text('Single')),
                ShadRadio(value: ExamenProfile.married, label: const Text('Married')),
              ],
            ),
            const SizedBox(height: 12),
            const ShadAlert(title: Text('Tip')),
            const Padding(
              padding: EdgeInsets.only(top: 6),
              child: Text('You can change this later in the Review step.'),
            ),
          ],
        ),
      ),
    );
  }

  // Step 2: Begin prayer
  Widget _buildBeginPrayerStep(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        ShadCard(
          title: Text('Begin with Prayer'),
          child: Padding(
            padding: EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ask the Holy Spirit to guide your examination.'),
                SizedBox(height: 8),
                Text(
                  'Come, Holy Spirit, fill the hearts of your faithful and kindle in them the fire of your love. Send forth your Spirit and they shall be created, and you shall renew the face of the earth.\n\nLet us pray. O God, who by the light of the Holy Spirit did instruct the hearts of the faithful, grant that by the same Holy Spirit we may be truly wise and ever enjoy His consolations. Through Christ our Lord. Amen.',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Step 3: Commandments with collapsible images header and sticky chips
  Widget _buildCommandmentsStep(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final headerImages = [
      'assets/images/top_header.png',
      if (isDark) ...[
        'assets/images/1CDark.png',
        'assets/images/2CDark.png',
        'assets/images/3CDark.png',
        'assets/images/4CDark.png',
        'assets/images/5CDark.png',
        'assets/images/6CDark.png',
        'assets/images/7CDark.png',
        'assets/images/8CDark.png',
      ] else ...[
        'assets/images/1CLight.png',
        'assets/images/2CLight.png',
        'assets/images/3CLight.png',
        'assets/images/4CLight.png',
        'assets/images/5CLight.png',
        'assets/images/6CLight.png',
        'assets/images/7CLight.png',
        'assets/images/8CLight.png',
      ],
    ];

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 220,
          backgroundColor: Theme.of(context).colorScheme.surface,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsetsDirectional.only(start: 16, bottom: 12),
            title: const Text('The Ten Commandments'),
            background: _ImageCarousel(images: headerImages),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _StickyHeader(
            minHeight: 56,
            maxHeight: 56,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border(
                  bottom: BorderSide(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2)),
                ),
              ),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemBuilder: (context, i) {
                  final c = _commandments[i];
                  return ShadButton.secondary(
                    onPressed: () {
                      // Scroll to approximately the card; simple heuristic by item height
                      final offset = 220 + 56 + i * 240; // appbar + header + approx card height
                      _scrollController.animateTo(
                        offset.toDouble(),
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text('${c.number}. ${c.title}'),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemCount: _commandments.length,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final c = _commandments[index];
            final filteredQuestions = c.questions.where((q) {
              final p = _result.profile;
              if (q.profiles == null || q.profiles!.isEmpty) return true;
              if (p == null) return true; // show all if profile not set yet
              return q.profiles!.contains(p);
            }).toList();
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: ShadCard(
                title: Text('${c.number}. ${c.title}'),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(c.summary, style: const TextStyle(color: Colors.grey)),
                    ),
                    const SizedBox(height: 8),
                    for (final q in filteredQuestions) _QuestionTile(
                      question: q,
                      value: _result.answers[q.id] ?? false,
                      note: _result.notes[q.id] ?? '',
                      onChanged: (v) => setState(() => _result.answers[q.id] = v),
                      onNoteChanged: (v) => _result.notes[q.id] = v,
                    ),
                  ],
                ),
              ),
            );
          }, childCount: _commandments.length),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 80)),
      ],
    );
  }

  // Step 4: End prayer
  Widget _buildEndPrayerStep(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        ShadCard(
          title: Text('Act of Contrition'),
          child: Padding(
            padding: EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Conclude your examination by praying with contrite heart.'),
                SizedBox(height: 8),
                Text(
                  'O my God, I am heartily sorry for having offended You, and I detest all my sins because of Your just punishments, but most of all because they offend You, my God, who are all-good and deserving of all my love. I firmly resolve, with the help of Your grace, to sin no more and to avoid the near occasions of sin. Amen.',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Step 5: Review and Save
  Widget _buildReviewStep(BuildContext context) {
    final selectedIds = _result.answers.entries.where((e) => e.value).map((e) => e.key).toSet();
    final selectedQuestions = <(String, String, String)>[]; // (commandment, text, note)
    for (final c in _commandments) {
      for (final q in c.questions) {
        if (selectedIds.contains(q.id)) {
          selectedQuestions.add(('${c.number}. ${c.title}', q.text, _result.notes[q.id] ?? ''));
        }
      }
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ShadCard(
          title: const Text('Summary'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text('Profile: ${_result.profile?.name ?? 'Not set'} • Selected: ${selectedIds.length}', style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              if (selectedQuestions.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('No items selected.'),
                )
              else
                ...selectedQuestions.map((t) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('• ${t.$2}'),
                          Padding(
                            padding: const EdgeInsets.only(left: 12, top: 4),
                            child: Text(t.$1, style: const TextStyle(color: Colors.grey)),
                          ),
                          if (t.$3.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(left: 12, top: 4),
                              child: Text('Note: ${t.$3}', style: const TextStyle(color: Colors.grey)),
                            ),
                        ],
                      ),
                    )),
              const SizedBox(height: 12),
              Row(
                children: [
                  ShadButton.outline(onPressed: _confirmReset, child: const Text('Reset')),
                  const SizedBox(width: 12),
                  ShadButton.secondary(
                    onPressed: () => _goToStep(ExamenFlowStep.values.indexOf(ExamenFlowStep.commandments)),
                    child: const Text('Edit Answers'),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _saveResults() async {
    setState(() => _saving = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      _result.savedAt = DateTime.now();
      await prefs.setString(_storageKey, jsonEncode(_result.toJson()));
      if (mounted) {
        // Dismiss any open dialog/sheet/pop-up if present
        // Using rootNavigator to ensure modals are closed without affecting route
        // ignore: use_build_context_synchronously
        Navigator.of(context, rootNavigator: true).maybePop();
        ShadToaster.of(context).show(
          const ShadToast(description: Text('Examination saved locally')),
        );
        // After saving, return to Home so the mobile menu bar becomes visible again
        // ignore: use_build_context_synchronously
        context.go('/');
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _loadSaved() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_storageKey);
      if (raw != null) {
        final json = jsonDecode(raw) as Map<String, dynamic>;
        setState(() {
          _result = ExamenResult.fromJson(json);
          _loading = false;
        });
      } else {
        setState(() => _loading = false);
      }
      // If no profile persisted in latest result, try reading standalone profile
      if (_result.profile == null) {
        final pRaw = prefs.getString(_profileKey);
        if (pRaw != null) {
          final matches = ExamenProfile.values.where((e) => e.name == pRaw).toList();
          if (matches.isNotEmpty) {
            setState(() => _result.profile = matches.first);
          }
        }
      }
    } catch (_) {
      setState(() => _loading = false);
    }
  }

  Future<void> _confirmReset() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Examination'),
        content: const Text('This will clear all selections and notes. Continue?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetAll();
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  Future<void> _persistProfile(ExamenProfile? profile) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (profile == null) {
        await prefs.remove(_profileKey);
      } else {
        await prefs.setString(_profileKey, profile.name);
      }
    } catch (_) {
      // ignore errors in background persistence
    }
  }

  Future<void> _resetAll() async {
    setState(() {
      _result = ExamenResult();
      _currentStep = ExamenFlowStep.profile;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
    await prefs.remove(_profileKey);
    _pageController.jumpToPage(0);
  }

  List<Commandment> _buildCommandments() {
    List<ExamenQuestion> q(int n, List<(String, Set<ExamenProfile>?)> list) {
      return [
        for (final e in list)
          ExamenQuestion(
            id: 'c${n}_${e.$1.hashCode}',
            text: e.$1,
            profiles: e.$2,
          )
      ];
    }

    return [
      Commandment(
        number: 1,
        title: 'No other gods',
        summary: 'I am the Lord your God; you shall not have other gods before me.',
        questions: q(1, [
          ('Have I prayed daily and trusted God above all things?', null),
          ('Have I placed work, success, or entertainment before God?', null),
          ('As a parent or spouse, do I help my family keep Sunday holy?', {ExamenProfile.married}),
          ('As a student, do I skip prayer for distractions?', {ExamenProfile.student}),
        ]),
      ),
      Commandment(
        number: 2,
        title: 'Honor God’s name',
        summary: 'You shall not take the name of the Lord your God in vain.',
        questions: q(2, [
          ('Have I used God’s name carelessly or in anger?', null),
          ('Have I spoken with reverence about holy things?', null),
        ]),
      ),
      Commandment(
        number: 3,
        title: 'Keep the Lord’s day',
        summary: 'Remember to keep holy the Lord’s Day.',
        questions: q(3, [
          ('Have I attended Mass on Sundays and holy days?', null),
          ('Have I kept Sunday as a day of rest and charity?', null),
        ]),
      ),
      Commandment(
        number: 4,
        title: 'Honor father and mother',
        summary: 'Honor your father and mother.',
        questions: q(4, [
          ('Have I obeyed and respected parents and lawful authority?', null),
          ('As a parent, have I provided love, discipline, and faith example?', {ExamenProfile.married}),
          ('As a child, have I been disobedient or disrespectful?', {ExamenProfile.child}),
          ('As a student, have I respected teachers and school rules?', {ExamenProfile.student}),
        ]),
      ),
      Commandment(
        number: 5,
        title: 'Do not kill',
        summary: 'You shall not kill; respect life and dignity of every person.',
        questions: q(5, [
          ('Have I harbored anger, hatred, or desire for revenge?', null),
          ('Have I abused alcohol or harmed my health?', null),
        ]),
      ),
      Commandment(
        number: 6,
        title: 'Chastity',
        summary: 'You shall not commit adultery; live purity in body and heart.',
        questions: q(6, [
          ('Have I been chaste in thought, word, and action?', null),
          ('As married, have I been faithful to my spouse?', {ExamenProfile.married}),
          ('Have I consumed impure media or entertained lustful thoughts?', null),
        ]),
      ),
      Commandment(
        number: 7,
        title: 'Do not steal',
        summary: 'You shall not steal; practice justice and generosity.',
        questions: q(7, [
          ('Have I taken or kept what is not mine?', null),
          ('Have I been dishonest in school or at work?', {ExamenProfile.student, ExamenProfile.single, ExamenProfile.married}),
        ]),
      ),
      Commandment(
        number: 8,
        title: 'Speak the truth',
        summary: 'You shall not bear false witness; avoid gossip and calumny.',
        questions: q(8, [
          ('Have I lied, gossiped, or harmed another’s reputation?', null),
          ('Have I failed to defend someone’s good name?', null),
        ]),
      ),
      Commandment(
        number: 9,
        title: 'Purity of heart',
        summary: 'You shall not covet your neighbor’s spouse.',
        questions: q(9, [
          ('Have I entertained impure desires contrary to my vocation?', null),
        ]),
      ),
      Commandment(
        number: 10,
        title: 'Detachment',
        summary: 'You shall not covet your neighbor’s goods; be grateful and generous.',
        questions: q(10, [
          ('Have I been envious of others’ possessions or success?', null),
          ('Have I trusted in providence and practiced generosity?', null),
        ]),
      ),
    ];
  }
}

class _QuestionTile extends StatefulWidget {
  final ExamenQuestion question;
  final bool value;
  final String note;
  final ValueChanged<bool> onChanged;
  final ValueChanged<String> onNoteChanged;
  const _QuestionTile({
    required this.question,
    required this.value,
    required this.note,
    required this.onChanged,
    required this.onNoteChanged,
  });

  @override
  State<_QuestionTile> createState() => _QuestionTileState();
}

class _QuestionTileState extends State<_QuestionTile> {
  bool _showNote = false;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _showNote = widget.note.isNotEmpty;
    _controller = TextEditingController(text: widget.note);
  }

  @override
  void didUpdateWidget(covariant _QuestionTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.note != widget.note && _controller.text != widget.note) {
      _controller.text = widget.note;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShadCheckbox(
                value: widget.value,
                onChanged: (v) => widget.onChanged(v ?? false),
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(widget.question.text)),
              ShadButton.ghost(
                onPressed: () => setState(() => _showNote = !_showNote),
                child: const Icon(Icons.note_alt, size: 18),
              ),
            ],
          ),
          if (_showNote)
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 6),
              child: ShadInput(
                placeholder: const Text('Optional note'),
                controller: _controller,
                onChanged: widget.onNoteChanged,
                maxLines: 3,
              ),
            ),
        ],
      ),
    );
  }
}

class _ImageCarousel extends StatefulWidget {
  final List<String> images;
  const _ImageCarousel({required this.images});

  @override
  State<_ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<_ImageCarousel> {
  late final PageController _controller;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(
          controller: _controller,
          onPageChanged: (i) => setState(() => _index = i),
          itemCount: widget.images.length,
          itemBuilder: (_, i) => Image.asset(widget.images[i], fit: BoxFit.cover),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.images.length, (i) {
              final active = i == _index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: active ? 18 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: active ? Theme.of(context).colorScheme.primary : Colors.white.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(99),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _StickyHeader extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;
  _StickyHeader({required this.minHeight, required this.maxHeight, required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  bool shouldRebuild(covariant _StickyHeader oldDelegate) {
    return oldDelegate.child != child || oldDelegate.minHeight != minHeight || oldDelegate.maxHeight != maxHeight;
  }
}
