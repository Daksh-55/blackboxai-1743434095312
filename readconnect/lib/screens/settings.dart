import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readconnect/providers/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Appearance',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: themeMode == ThemeMode.dark,
            onChanged: (value) {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'Account',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.password),
            title: const Text('Change Password'),
            onTap: () {
              // TODO: Implement password change
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete Account'),
            onTap: () {
              // TODO: Implement account deletion
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'About',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('App Version'),
            subtitle: const Text('1.0.0'),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy Policy'),
            onTap: () {
              // TODO: Show privacy policy
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help & Support'),
            onTap: () {
              // TODO: Show help section
            },
          ),
        ],
      ),
    );
  }
}