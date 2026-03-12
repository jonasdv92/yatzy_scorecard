import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/game_type.dart';
import '../models/score_category.dart';
import '../providers/game_provider.dart';
import '../services/game_service.dart';
import '../widgets/extra_throws_counter.dart';
import '../widgets/player_tabs.dart';
import '../widgets/score_row.dart';
import '../widgets/totals_card.dart';

class GameScreen extends StatelessWidget {
  GameScreen({super.key});

  final GameService _gameService = GameService();

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
          title: const Text('Skriv poeng'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
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

  String _labelForCategory(ScoreCategory category) {
    switch (category) {
      case ScoreCategory.ones:
        return '1ere';
      case ScoreCategory.twos:
        return '2ere';
      case ScoreCategory.threes:
        return '3ere';
      case ScoreCategory.fours:
        return '4ere';
      case ScoreCategory.fives:
        return '5ere';
      case ScoreCategory.sixes:
        return '6ere';
      case ScoreCategory.onePair:
        return '1 par';
      case ScoreCategory.twoPairs:
        return '2 par';
      case ScoreCategory.threePairs:
        return '3 par';
      case ScoreCategory.threeOfAKind:
        return '3 like';
      case ScoreCategory.fourOfAKind:
        return '4 like';
      case ScoreCategory.fiveOfAKind:
        return '5 like';
      case ScoreCategory.smallStraight:
        return 'Liten straight';
      case ScoreCategory.largeStraight:
        return 'Stor straight';
      case ScoreCategory.fullStraight:
        return 'Full straight';
      case ScoreCategory.fullHouse:
        return 'Hus';
      case ScoreCategory.tower:
        return 'Tower';
      case ScoreCategory.castle:
        return 'Castle';
      case ScoreCategory.chance:
        return 'Sjanse';
      case ScoreCategory.yatzy:
        return 'Yatzy';
      case ScoreCategory.maxiYatzy:
        return 'Maxi Yatzy';
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
        title: Text(
          game.type == GameType.yatzy ? 'Yatzy' : 'Maxi Yatzy',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            PlayerTabs(
              players: game.players,
              selectedIndex: provider.selectedPlayerIndex,
              onSelected: provider.selectPlayer,
            ),
            const SizedBox(height: 12),
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
              const SizedBox(height: 12),
            ],
            Expanded(
              child: ListView(
                children: [
                  const Text(
                    'Øvre del',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...upperDefinitions.map(
                    (definition) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ScoreRow(
                        title: _labelForCategory(definition.category),
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
                  const SizedBox(height: 16),
                  const Text(
                    'Nedre del',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...lowerDefinitions.map(
                    (definition) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ScoreRow(
                        title: _labelForCategory(definition.category),
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
                  const SizedBox(height: 16),
                  TotalsCard(
                    upperTotal: provider.getUpperSectionTotal(player.id),
                    bonus: provider.getBonus(player.id),
                    lowerTotal: provider.getLowerSectionTotal(player.id),
                    grandTotal: provider.getGrandTotal(player.id),
                  ),
                  if (game.isFinished) ...[
                    const SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Spillet er ferdig',
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}