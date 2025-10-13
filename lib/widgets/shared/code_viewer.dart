import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

/// Reusable code viewer widget with syntax highlighting and copy functionality
class CodeViewer extends StatefulWidget {
  final String code;
  final String language;
  final VoidCallback? onCopy;

  const CodeViewer({
    super.key,
    required this.code,
    this.language = 'dart',
    this.onCopy,
  });

  @override
  State<CodeViewer> createState() => _CodeViewerState();
}

class _CodeViewerState extends State<CodeViewer> {
  Highlighter? highlighter;

  @override
  void initState() {
    super.initState();
    _initializeHighlighter();
  }

  Future<void> _initializeHighlighter() async {
    try {
      await Highlighter.initialize([widget.language]);
      final theme = await HighlighterTheme.loadLightTheme();
      highlighter = Highlighter(
        language: widget.language,
        theme: theme,
      );
      setState(() {});
    } catch (e) {
      // Handle initialization error
      debugPrint('Failed to initialize highlighter: $e');
    }
  }

  /// Copies the code to the clipboard and shows a confirmation
  Future<void> _copyToClipboard() async {
    try {
      await Clipboard.setData(ClipboardData(text: widget.code));
      if (context.mounted) {
        final sonner = ShadSonner.of(context);
        sonner.show(
          ShadToast(
            title: const Text('Code copied to clipboard!'),
            description: const Text(
              'The code snippet has been copied to your clipboard.',
            ),
          ),
        );
      }
      widget.onCopy?.call();
    } catch (e) {
      if (context.mounted) {
        final sonner = ShadSonner.of(context);
        sonner.show(
          ShadToast.destructive(
            title: const Text('Failed to copy'),
            description: const Text(
              'Could not copy code to clipboard. Please try again.',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade50,
      ),
      child: Stack(
        children: [
          // Code content
          Padding(
            padding: const EdgeInsets.all(16),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                scrollbars: false,
              ),
              child: highlighter != null
                  ? SingleChildScrollView(
                      child: SelectableText.rich(
                        highlighter!.highlight(widget.code),
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'GeistMono',
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: SelectableText(
                        widget.code,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'GeistMono',
                        ),
                      ),
                    ),
            ),
          ),
          // Copy button
          Positioned(
            top: 12,
            right: 12,
            child: ShadButton.outline(
              onPressed: _copyToClipboard,
              size: ShadButtonSize.sm,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.copy, size: 16),
                  SizedBox(width: 4),
                  Text('Copy'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
