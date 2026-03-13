import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app_texts.dart';
import '../providers/settings_provider.dart';
import 'rules_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final languageCode = settings.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.t(languageCode, 'settings')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              AppTexts.t(languageCode, 'language'),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SegmentedButton<String>(
                  segments: [
                    ButtonSegment<String>(
                      value: 'no',
                      label: Text(AppTexts.t(languageCode, 'norwegian')),
                    ),
                    ButtonSegment<String>(
                      value: 'en',
                      label: Text(AppTexts.t(languageCode, 'english')),
                    ),
                  ],
                  selected: {settings.languageCode},
                  onSelectionChanged: (selection) {
                    settings.setLanguage(selection.first);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RulesScreen(),
                    ),
                  );
                },
                child: Text(AppTexts.t(languageCode, 'showRules')),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppTexts.t(languageCode, 'aboutApp'),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppTexts.t(languageCode, 'appTitle')),
                    const SizedBox(height: 8),
                    Text(AppTexts.t(languageCode, 'versionText')),
                    const SizedBox(height: 8),
                    Text(AppTexts.t(languageCode, 'aboutDescription')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}