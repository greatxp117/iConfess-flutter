import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../widgets/shared/minimal_header.dart';
import '../openai/openai_config.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  // Preferences (kept from prior Settings for continuity)
  bool reminders = false;
  bool darkMode = false;
  String language = 'English';

  // AI Prayer generator
  final TextEditingController _topicController = TextEditingController();
  bool _generating = false;
  String? _prayerText;
  String? _errorText;

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
  }

  Future<void> _generatePrayer() async {
    final topic = _topicController.text.trim();
    if (topic.isEmpty) return;
    setState(() {
      _generating = true;
      _errorText = null;
      _prayerText = null;
    });
    try {
      final text = await OpenAIClient.generatePrayer(topic: topic);
      setState(() => _prayerText = text);
    } catch (e) {
      setState(() => _errorText = e.toString());
    } finally {
      if (mounted) setState(() => _generating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const MinimalHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Browse',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),

                // AI Prayer Generator card
                ShadCard(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(LucideIcons.sparkles, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'AI Prayer Generator',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Enter a topic and receive a reverent, Catholic prayer crafted for your intention.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 12),
                        ShadInput(
                          controller: _topicController,
                          placeholder: const Text('e.g. patience, exams, family, thanksgiving, healing'),
                          leading: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(LucideIcons.feather),
                          ),
                          onSubmitted: (_) => _generatePrayer(),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            ShadButton(
                              onPressed: _generating || _topicController.text.trim().isEmpty
                                  ? null
                                  : _generatePrayer,
                              child: _generating
                                  ? const SizedBox(
                                      height: 16,
                                      width: 16,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                  : const Text('Generate Prayer'),
                            ),
                            const SizedBox(width: 12),
                            TextButton(
                              onPressed: _generating
                                  ? null
                                  : () => setState(() {
                                        _topicController.clear();
                                        _prayerText = null;
                                        _errorText = null;
                                      }),
                              child: const Text('Clear'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (_errorText != null)
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(alpha: 0.08),
                              border: Border.all(color: Colors.red.withValues(alpha: 0.25)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.error_outline, color: Colors.red, size: 18),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Could not generate prayer. Please try again in a moment.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (_prayerText != null)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Theme.of(context).dividerColor.withValues(alpha: 0.12),
                              ),
                            ),
                            child: SelectableText(
                              _prayerText!,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Preferences section (optional)
                ShadCard(
                  child: Column(
                    children: [
                      const ListTile(
                        title: Text('Preferences',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                      const Divider(height: 1),
                      SwitchListTile(
                        title: const Text('Confession reminders'),
                        subtitle: const Text('Receive gentle reminders to prepare for confession'),
                        value: reminders,
                        onChanged: (v) => setState(() => reminders = v),
                      ),
                      SwitchListTile(
                        title: const Text('Dark mode'),
                        value: darkMode,
                        onChanged: (v) => setState(() => darkMode = v),
                      ),
                      ListTile(
                        title: const Text('Language'),
                        subtitle: Text(language),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: _pickLanguage,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),
                const ListTile(
                  title: Text('About'),
                  subtitle: Text('A simple tool to help Catholics prepare for confession.'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickLanguage() async {
    final options = ['English', 'Español', 'Français'];
    final selected = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: ListView(
            children: options
                .map(
                  (o) => RadioListTile<String>(
                    title: Text(o),
                    value: o,
                    groupValue: language,
                    onChanged: (v) => Navigator.pop(context, v),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
    if (selected != null) setState(() => language = selected);
  }
}
