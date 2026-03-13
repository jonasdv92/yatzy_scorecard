import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app_texts.dart';
import '../providers/settings_provider.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageCode = context.watch<SettingsProvider>().languageCode;

    final isEnglish = languageCode == 'en';
    final yatzyTitle = AppTexts.t(languageCode, 'yatzyRules');
    final maxiTitle = AppTexts.t(languageCode, 'maxiYatzyRules');

    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.t(languageCode, 'rules')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _RuleSection(
            title: yatzyTitle,
            rules: isEnglish
                ? const [
                    'Played with 5 dice.',
                    'One row is filled each turn.',
                    'Upper section bonus: 50 points when reaching 63 or more.',
                    'Yatzy gives 50 points.',
                  ]
                : const [
                    'Spilles med 5 terninger.',
                    'Én rad fylles ut per tur.',
                    'Bonus i øvre del: 50 poeng ved 63 eller mer.',
                    'Yatzy gir 50 poeng.',
                  ],
          ),
          const SizedBox(height: 16),
          _RuleSection(
            title: maxiTitle,
            rules: isEnglish
                ? const [
                    'Played with 6 dice.',
                    'One row is filled each turn.',
                    'Upper section bonus: 100 points when reaching 84 or more.',
                    'Maxi Yatzy gives 100 points.',
                    'Extra throws can be tracked manually in the app.',
                    'Cottage = one pair + three of a kind.',
                    'House = three of a kind + three of a kind.',
                    'Tower = one pair + four of a kind.',
                  ]
                : const [
                    'Spilles med 6 terninger.',
                    'Én rad fylles ut per tur.',
                    'Bonus i øvre del: 100 poeng ved 84 eller mer.',
                    'Maxi Yatzy gir 100 poeng.',
                    'Ekstra kast kan føres manuelt i appen.',
                    'Hytte = ett par + tre like.',
                    'Hus = tre like + tre like.',
                    'Tårn = ett par + fire like.',
                  ],
          ),
        ],
      ),
    );
  }
}

class _RuleSection extends StatelessWidget {
  final String title;
  final List<String> rules;

  const _RuleSection({
    required this.title,
    required this.rules,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ...rules.map(
              (rule) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text('• $rule'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}