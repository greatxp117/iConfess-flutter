import 'package:flutter/material.dart';

class ExaminationScreen extends StatefulWidget {
  const ExaminationScreen({super.key});

  @override
  State<ExaminationScreen> createState() => _ExaminationScreenState();
}

class _ExaminationScreenState extends State<ExaminationScreen> {
  late List<_ExamenItem> _items;

  @override
  void initState() {
    super.initState();
    _items = _defaultItems();
  }

  @override
  Widget build(BuildContext context) {
    final grouped = <String, List<_ExamenItem>>{};
    for (final item in _items) {
      grouped.putIfAbsent(item.category, () => []).add(item);
    }

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
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
                TextButton(
                  onPressed: _reset,
                  child: const Text('Reset'),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: grouped.entries.map((entry) {
                return _CategoryCard(
                  category: entry.key,
                  items: entry.value,
                  onChanged: () => setState(() {}),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: ElevatedButton.icon(
              onPressed: _showSummary,
              icon: const Icon(Icons.list_alt),
              label: Text('View Summary (${_items.where((e) => e.checked).length} selected)'),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
            ),
          ),
        ],
      ),
    );
  }

  void _reset() {
    setState(() {
      for (final i in _items) {
        i.checked = false;
        i.note = '';
      }
    });
  }

  void _showSummary() {
    final selected = _items.where((e) => e.checked).toList();
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selected Items',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                if (selected.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text('No items selected.'),
                  )
                else
                  ...selected.map((e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('• ${e.title}'),
                            if (e.note.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(left: 16, top: 4),
                                child: Text(
                                  'Note: ${e.note}',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              )
                          ],
                        ),
                      )),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  List<_ExamenItem> _defaultItems() {
    return [
      // 10 Commandments themed sample
      _ExamenItem(category: 'Love of God', title: 'Have I prayed daily and attended Mass on Sundays?'),
      _ExamenItem(category: 'Love of God', title: 'Have I taken the Lord’s name in vain?'),
      _ExamenItem(category: 'Love of Neighbor', title: 'Have I dishonored my parents or lawful authority?'),
      _ExamenItem(category: 'Love of Neighbor', title: 'Have I harbored anger or hatred toward anyone?'),
      _ExamenItem(category: 'Chastity', title: 'Have I been chaste in thought and action?'),
      _ExamenItem(category: 'Stewardship', title: 'Have I been greedy or stolen what is not mine?'),
      _ExamenItem(category: 'Truthfulness', title: 'Have I lied, gossiped, or harmed another’s reputation?'),
      _ExamenItem(category: 'Detachment', title: 'Have I been envious of others’ possessions or success?'),
    ];
  }
}

class _CategoryCard extends StatelessWidget {
  final String category;
  final List<_ExamenItem> items;
  final VoidCallback onChanged;
  const _CategoryCard({required this.category, required this.items, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text(
                category,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            ...items.map((e) => _ItemTile(item: e, onChanged: onChanged)).toList(),
          ],
        ),
      ),
    );
  }
}

class _ItemTile extends StatefulWidget {
  final _ExamenItem item;
  final VoidCallback onChanged;
  const _ItemTile({required this.item, required this.onChanged});

  @override
  State<_ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<_ItemTile> {
  bool _showNote = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckboxListTile(
          value: widget.item.checked,
          onChanged: (v) {
            setState(() => widget.item.checked = v ?? false);
            widget.onChanged();
          },
          title: Text(widget.item.title),
          controlAffinity: ListTileControlAffinity.leading,
          secondary: IconButton(
            onPressed: () => setState(() => _showNote = !_showNote),
            icon: const Icon(Icons.note_alt, color: Colors.blue),
          ),
        ),
        if (_showNote)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Optional note',
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => widget.item.note = v,
              minLines: 1,
              maxLines: 3,
            ),
          ),
      ],
    );
  }
}

class _ExamenItem {
  final String category;
  final String title;
  bool checked;
  String note;
  _ExamenItem({required this.category, required this.title, this.checked = false, this.note = ''});
}
