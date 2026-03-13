import 'package:flutter/material.dart';

import '../models/game_type.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yatzy Scorecard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 24),
            const Text(
              'Yatzy Scorecard – Maxi Yatzy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'En enkel digital poengblokk',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              text: 'Start Yatzy',
              onPressed: () => _openNewGame(context, GameType.yatzy),
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              text: 'Start Maxi Yatzy',
              onPressed: () => _openNewGame(context, GameType.maxiYatzy),
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              text: 'Fortsett spill',
              onPressed: () => _openContinueGames(context),
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              text: 'Statistikk',
              onPressed: () => _openStatistics(context),
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              text: 'Innstillinger',
              onPressed: () => _openSettings(context),
            ),
          ],
        ),
      ),
    );
  }
}