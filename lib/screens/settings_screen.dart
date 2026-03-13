import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Innstillinger'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Språk',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  RadioListTile<String>(
                    title: const Text('Norsk'),
                    value: 'no',
                    groupValue: settings.languageCode,
                    onChanged: (value) {
                      if (value != null) {
                        settings.setLanguage(value);
                      }
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('English'),
                    value: 'en',
                    groupValue: settings.languageCode,
                    onChanged: (value) {
                      if (value != null) {
                        settings.setLanguage(value);
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Om appen',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Yatzy Scorecard – Maxi Yatzy'),
                    SizedBox(height: 8),
                    Text('Versjon 1.0 (utvikling)'),
                    SizedBox(height: 8),
                    Text('En enkel digital poengblokk for Yatzy og Maxi Yatzy.'),
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