import '../models/game.dart';
import '../models/player.dart';
import '../models/statistics_model.dart';
import 'game_service.dart';

class StatisticsService {
  final GameService _gameService = GameService();

  StatisticsModel calculate(List<Game> games) {
    final finishedGames = games.where((g) => g.isFinished).toList();

    if (finishedGames.isEmpty) {
      return const StatisticsModel(
        totalGames: 0,
        bestScoreOverall: 0,
        averageScoreOverall: 0,
        players: [],
      );
    }

    final Map<String, List<int>> scoresByPlayer = {};
    final Map<String, int> winsByPlayer = {};

    int bestScoreOverall = 0;
    int totalScoreSum = 0;
    int totalScoreCount = 0;

    for (final game in finishedGames) {
      Player? winner;
      int winnerScore = -1;

      for (final player in game.players) {
        final total = _gameService.calculateGrandTotal(game, player.id);

        scoresByPlayer.putIfAbsent(player.name, () => []);
        scoresByPlayer[player.name]!.add(total);

        totalScoreSum += total;
        totalScoreCount++;

        if (total > bestScoreOverall) {
          bestScoreOverall = total;
        }

        if (total > winnerScore) {
          winnerScore = total;
          winner = player;
        }
      }

      if (winner != null) {
        winsByPlayer[winner.name] = (winsByPlayer[winner.name] ?? 0) + 1;
      }
    }

    final playerStats = scoresByPlayer.entries.map((entry) {
      final name = entry.key;
      final scores = entry.value;

      final best = scores.reduce((a, b) => a > b ? a : b);
      final avg = scores.isEmpty
          ? 0.0
          : scores.reduce((a, b) => a + b) / scores.length;

      return PlayerStatistics(
        playerName: name,
        wins: winsByPlayer[name] ?? 0,
        bestScore: best,
        averageScore: avg,
        gamesPlayed: scores.length,
      );
    }).toList()
      ..sort((a, b) => b.wins.compareTo(a.wins));

    final averageOverall =
        totalScoreCount == 0 ? 0.0 : totalScoreSum / totalScoreCount;

    return StatisticsModel(
      totalGames: finishedGames.length,
      bestScoreOverall: bestScoreOverall,
      averageScoreOverall: averageOverall,
      players: playerStats,
    );
  }
}