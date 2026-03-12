import 'package:flutter/material.dart';
import '../screens/continue_game_screen.dart';
import '../models/game_type.dart';
import '../widgets/primary_button.dart';
import 'new_game_screen.dart';

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
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Kommer i neste pakke'),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              text: 'Statistikk',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Kommer senere'),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              text: 'Innstillinger',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Kommer senere'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}