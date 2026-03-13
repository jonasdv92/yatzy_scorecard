import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app_texts.dart';
import '../config/score_rules.dart';
import '../models/game_type.dart';
import '../models/score_category.dart';
import '../providers/game_provider.dart';
import '../providers/settings_provider.dart';
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
    final languageCode = context.read<SettingsProvider>().languageCode;
    final controller = TextEditingController(
      text: currentValue?.toString() ?? '',
    );

    final result = await showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(ScoreRules.title(languageCode, category)),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: AppTexts.t(languageCode, 'score'),
              border: const OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppTexts.t(languageCode, 'cancel')),
            ),
            ElevatedButton(
              onPressed: () {
                final value = int.tryParse(controller.text.trim());
                if (value == null || value < 0) return;
                Navigator.pop(context, value);
              },
              child: Text(AppTexts.t(languageCode, 'save')),
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

  Future<void> _showRuleDialog(
    BuildContext context,
    ScoreCategory category,
  ) async {
    final languageCode = context.read<SettingsProvider>().languageCode;

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(ScoreRules.title(languageCode, category)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(ScoreRules.description(languageCode, category)),
              const SizedBox(height: 12),
              Text(ScoreRules.example(languageCode, category)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppTexts.t(languageCode, 'cancel')),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GameProvider>();
    final game = provider.currentGame;
    final languageCode = context.watch<SettingsProvider>().languageCode;

    if (game == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppTexts.t(languageCode, 'game')),
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
          title: Text(AppTexts.t(languageCode, 'game')),
        ),
        body: const Center(
          child: Text('Fant ikke spiller'),
        ),
      );
    }

    final definitions = _gameService.getDefinitions(game.type);

    final upperDefinitions = definitions.where((d) => d.isUpperSection).toList();

    final lowerDefinitions = definitions.where((d) => !d.isUpperSection).toList()
      ..sort((a, b) {
        if (game.type != GameType.maxiYatzy) return 0;

        final order = <ScoreCategory, int>{
          ScoreCategory.onePair: 0,
          ScoreCategory.twoPairs: 1,
          ScoreCategory.threePairs: 2,
          ScoreCategory.threeOfAKind: 3,
          ScoreCategory.fourOfAKind: 4,
          ScoreCategory.fiveOfAKind: 5,
          ScoreCategory.smallStraight: 6,
          ScoreCategory.largeStraight: 7,
          ScoreCategory.fullStraight: 8,
          ScoreCategory.fullHouse: 9, // Hytte
          ScoreCategory.castle: 10, // Hus
          ScoreCategory.tower: 11, // Tårn
          ScoreCategory.chance: 12,
          ScoreCategory.maxiYatzy: 13,
          ScoreCategory.yatzy: 13,
        };

        return (order[a.category] ?? 999).compareTo(order[b.category] ?? 999);
      });

    final playerScores = game.scores[player.id] ?? {};

    return Scaffold(
      appBar: AppBar(
        title: Text(
          game.type == GameType.yatzy
              ? AppTexts.t(languageCode, 'startYatzy')
              : AppTexts.t(languageCode, 'startMaxiYatzy'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${AppTexts.t(languageCode, 'activePlayer')}: ${player.name}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '${AppTexts.t(languageCode, 'total')}: ${provider.getGrandTotal(player.id)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: game.players.map((p) {
                          final isActive = p.id == player.id;
                          final total = provider.getGrandTotal(p.id);

                          return Chip(
                            label: Text('${p.name}: $total'),
                            backgroundColor: isActive
                                ? Colors.teal.withValues(alpha: 0.15)
                                : null,
                          );
                        }).toList(),
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
                  label: AppTexts.t(languageCode, 'extraThrows'),
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
                    _SectionHeader(title: AppTexts.t(languageCode, 'upperSection')),
                    const SizedBox(height: 8),
                    ...upperDefinitions.map(
                      (definition) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: ScoreRow(
                          title: ScoreRules.title(languageCode, definition.category),
                          value: playerScores[definition.category],
                          onInfoTap: () => _showRuleDialog(context, definition.category),
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
                    _SectionHeader(title: AppTexts.t(languageCode, 'lowerSection')),
                    const SizedBox(height: 8),
                    ...lowerDefinitions.map(
                      (definition) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: ScoreRow(
                          title: ScoreRules.title(languageCode, definition.category),
                          value: playerScores[definition.category],
                          onInfoTap: () => _showRuleDialog(context, definition.category),
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
                      upperLabel: AppTexts.t(languageCode, 'upperTotal'),
                      bonusLabel: AppTexts.t(languageCode, 'bonus'),
                      lowerLabel: AppTexts.t(languageCode, 'lowerTotal'),
                      totalLabel: AppTexts.t(languageCode, 'total'),
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