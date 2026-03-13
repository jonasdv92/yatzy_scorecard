import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/score_labels.dart';
import '../models/game_type.dart';
import '../models/score_category.dart';
import '../providers/game_provider.dart';
import '../services/game_service.dart';
import '../widgets/extra_throws_counter.dart';
import '../widgets/player_tabs.dart';
import '../widgets/score_row.dart';
import '../widgets/totals_card.dart';
import 'results_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GameService _gameService = GameService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final provider = context.read<GameProvider>();
      if (provider.justFinishedGame) {
        provider.clearJustFinishedGame();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const ResultsScreen(),
          ),
        );
      }
    });
  }

  Future<void> _showScoreDialog(
    BuildContext context, {
    required String playerId,
    required ScoreCategory category,
    int? currentValue,
  }) async {
    final controller = TextEditingController(
      text: currentValue?.toString() ?? '',
    );

    final result = await showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(ScoreLabels.norwegian(category)),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Poeng',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Avbryt'),
            ),
            ElevatedButton(
              onPressed: () {
                final value = int.tryParse(controller.text.trim());
                if (value == null || value < 0) return;
                Navigator.pop(context, value);
              },
              child: const Text('Lagre'),
            ),
          ],
        );
      },
    );

    if (result != null && context.mounted) {
      await context.read<GameProvider>().updateScore(
            playerId: playerId,
            category: category,
            value: result,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GameProvider>();
    final game = provider.currentGame;

    if (game == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Spill'),
        ),
        body: const Center(
          child: Text('Fant ikke aktivt spill'),
        ),
      );
    }

    final player = provider.selectedPlayer;
    if (player == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Spill'),
        ),
        body: const Center(
          child: Text('Fant ikke spiller'),
        ),
      );
    }

    final definitions = _gameService.getDefinitions(game.type);
    final upperDefinitions =
        definitions.where((d) => d.isUpperSection).toList();
    final lowerDefinitions =
        definitions.where((d) => !d.isUpperSection).toList();

    final playerScores = game.scores[player.id] ?? {};

    return Scaffold(
      appBar: AppBar(
        title: Text(game.type == GameType.yatzy ? 'Yatzy' : 'Maxi Yatzy'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Aktiv spiller: ${player.name}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'Total: ${provider.getGrandTotal(player.id)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              PlayerTabs(
                players: game.players,
                selectedIndex: provider.selectedPlayerIndex,
                onSelected: provider.selectPlayer,
              ),
              const SizedBox(height: 10),
              if (game.type == GameType.maxiYatzy) ...[
                ExtraThrowsCounter(
                  value: player.extraThrows,
                  onIncrement: () {
                    provider.updateExtraThrows(
                      playerId: player.id,
                      newValue: player.extraThrows + 1,
                    );
                  },
                  onDecrement: () {
                    provider.updateExtraThrows(
                      playerId: player.id,
                      newValue: player.extraThrows - 1,
                    );
                  },
                ),
                const SizedBox(height: 10),
              ],
              Expanded(
                child: ListView(
                  children: [
                    const _SectionHeader(title: 'Øvre del'),
                    const SizedBox(height: 8),
                    ...upperDefinitions.map(
                      (definition) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: ScoreRow(
                          title: ScoreLabels.norwegian(definition.category),
                          value: playerScores[definition.category],
                          onTap: () => _showScoreDialog(
                            context,
                            playerId: player.id,
                            category: definition.category,
                            currentValue: playerScores[definition.category],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const _SectionHeader(title: 'Nedre del'),
                    const SizedBox(height: 8),
                    ...lowerDefinitions.map(
                      (definition) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: ScoreRow(
                          title: ScoreLabels.norwegian(definition.category),
                          value: playerScores[definition.category],
                          onTap: () => _showScoreDialog(
                            context,
                            playerId: player.id,
                            category: definition.category,
                            currentValue: playerScores[definition.category],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TotalsCard(
                      upperTotal: provider.getUpperSectionTotal(player.id),
                      bonus: provider.getBonus(player.id),
                      lowerTotal: provider.getLowerSectionTotal(player.id),
                      grandTotal: provider.getGrandTotal(player.id),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}