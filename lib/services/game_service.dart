import '../config/app_constants.dart';
import '../models/game.dart';
import '../models/game_type.dart';
import '../models/player.dart';
import '../models/score_category.dart';
import '../models/score_definition.dart';
import 'score_definitions.dart';

class GameService {
  List<ScoreDefinition> getDefinitions(GameType type) {
    return ScoreDefinitions.forGameType(type);
  }

  int calculateUpperSectionTotal(Game game, String playerId) {
    final definitions = getDefinitions(game.type);
    final playerScores = game.scores[playerId] ?? {};

    int total = 0;

    for (final definition in definitions) {
      if (definition.isUpperSection) {
        total += playerScores[definition.category] ?? 0;
      }
    }

    return total;
  }

  int calculateLowerSectionTotal(Game game, String playerId) {
    final definitions = getDefinitions(game.type);
    final playerScores = game.scores[playerId] ?? {};

    int total = 0;

    for (final definition in definitions) {
      if (!definition.isUpperSection) {
        total += playerScores[definition.category] ?? 0;
      }
    }

    return total;
  }

  int calculateBonus(Game game, String playerId) {
    final upperTotal = calculateUpperSectionTotal(game, playerId);

    switch (game.type) {
      case GameType.yatzy:
        return upperTotal >= AppConstants.yatzyBonusThreshold
            ? AppConstants.yatzyBonusScore
            : 0;
      case GameType.maxiYatzy:
        return upperTotal >= AppConstants.maxiBonusThreshold
            ? AppConstants.maxiBonusScore
            : 0;
    }
  }

  int calculateGrandTotal(Game game, String playerId) {
    final upper = calculateUpperSectionTotal(game, playerId);
    final lower = calculateLowerSectionTotal(game, playerId);
    final bonus = calculateBonus(game, playerId);

    return upper + lower + bonus;
  }

  Game updateScore({
    required Game game,
    required String playerId,
    required ScoreCategory category,
    required int value,
  }) {
    final newScores = <String, Map<ScoreCategory, int?>>{};

    for (final entry in game.scores.entries) {
      newScores[entry.key] = Map<ScoreCategory, int?>.from(entry.value);
    }

    newScores[playerId] ??= {};
    newScores[playerId]![category] = value;

    final updatedGame = game.copyWith(
      scores: newScores,
      updatedAt: DateTime.now(),
    );

    return updatedGame.copyWith(
      isFinished: isGameFinished(updatedGame),
    );
  }

  Game updateExtraThrows({
    required Game game,
    required String playerId,
    required int newValue,
  }) {
    final updatedPlayers = game.players.map((player) {
      if (player.id == playerId) {
        return player.copyWith(
          extraThrows: newValue < 0 ? 0 : newValue,
        );
      }
      return player;
    }).toList();

    return game.copyWith(
      players: updatedPlayers,
      updatedAt: DateTime.now(),
    );
  }

  bool isGameFinished(Game game) {
    final definitions = getDefinitions(game.type);

    for (final player in game.players) {
      final playerScores = game.scores[player.id] ?? {};

      for (final definition in definitions) {
        if (playerScores[definition.category] == null) {
          return false;
        }
      }
    }

    return true;
  }

  Map<ScoreCategory, int?> createEmptyScoreMap(GameType type) {
  final definitions = getDefinitions(type);

  return {
    for (final definition in definitions) definition.category: null,
  };
}

  Game createRematch(Game oldGame) {
    final newPlayers = oldGame.players
        .map(
          (player) => Player(
            id: '${player.id}_${DateTime.now().millisecondsSinceEpoch}',
            name: player.name,
            extraThrows: 0,
          ),
        )
        .toList();

    final newScores = <String, Map<ScoreCategory, int?>>{};
    for (final player in newPlayers) {
      newScores[player.id] = createEmptyScoreMap(oldGame.type);
    }

    return Game(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: oldGame.type,
      players: newPlayers,
      scores: newScores,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isFinished: false,
    );
  }
}