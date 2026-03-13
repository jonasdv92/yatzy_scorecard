import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app_texts.dart';
import '../models/player.dart';
import '../providers/game_provider.dart';
import '../providers/settings_provider.dart';
import 'game_screen.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  List<Player> _sortedPlayers(BuildContext context) {
    final provider = context.read<GameProvider>();
    final game = provider.currentGame;

    if (game == null) return [];

    final players = List<Player>.from(game.players);

    players.sort((a, b) {
      final totalA = provider.getGrandTotal(a.id);
      final totalB = provider.getGrandTotal(b.id);
      return totalB.compareTo(totalA);
    });

    return players;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GameProvider>();
    final game = provider.currentGame;
    final languageCode = context.watch<SettingsProvider>().languageCode;

    if (game == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppTexts.t(languageCode, 'results')),
        ),
        body: const Center(
          child: Text('Fant ikke resultat'),
        ),
      );
    }

    final players = _sortedPlayers(context);
    final winner = players.isNotEmpty ? players.first : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.t(languageCode, 'results')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (winner != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        AppTexts.t(languageCode, 'winner'),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        winner.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        provider.getGrandTotal(winner.id).toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: players.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final player = players[index];
                  final total = provider.getGrandTotal(player.id);

                  return ListTile(
                    tileColor: Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    leading: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    title: Text(player.name),
                    trailing: Text(
                      total.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () async {
                  await context.read<GameProvider>().createRematch();

                  if (!context.mounted) return;

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const GameScreen(),
                    ),
                  );
                },
                child: Text(AppTexts.t(languageCode, 'playAgain')),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Text(AppTexts.t(languageCode, 'backToMenu')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}