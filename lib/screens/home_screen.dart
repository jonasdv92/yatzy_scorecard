import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app_texts.dart';
import '../models/game_type.dart';
import '../providers/settings_provider.dart';
import '../widgets/primary_button.dart';
import 'continue_game_screen.dart';
import 'new_game_screen.dart';
import 'settings_screen.dart';
import 'statistics_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openNewGame(BuildContext context, GameType type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NewGameScreen(gameType: type),
      ),
    );
  }

  void _openContinueGames(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ContinueGameScreen(),
      ),
    );
  }

  void _openStatistics(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const StatisticsScreen(),
      ),
    );
  }

  void _openSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageCode = context.watch<SettingsProvider>().languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.t(languageCode, 'appTitle')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Text(
              'Yatzy Scorecard – Maxi Yatzy',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              AppTexts.t(languageCode, 'appSubtitle'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              text: AppTexts.t(languageCode, 'startYatzy'),
              onPressed: () => _openNewGame(context, GameType.yatzy),
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              text: AppTexts.t(languageCode, 'startMaxiYatzy'),
              onPressed: () => _openNewGame(context, GameType.maxiYatzy),
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              text: AppTexts.t(languageCode, 'continueGame'),
              onPressed: () => _openContinueGames(context),
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              text: AppTexts.t(languageCode, 'statistics'),
              onPressed: () => _openStatistics(context),
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              text: AppTexts.t(languageCode, 'settings'),
              onPressed: () => _openSettings(context),
            ),
          ],
        ),
      ),
    );
  }
}