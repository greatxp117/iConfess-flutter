import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool reminders = false;
  bool darkMode = false;
  String language = 'English';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          const ListTile(
            title: Text('Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ),
          const Divider(),
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
          const Divider(),
          const ListTile(
            title: Text('About'),
            subtitle: Text('A simple tool to help Catholics prepare for confession.'),
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
