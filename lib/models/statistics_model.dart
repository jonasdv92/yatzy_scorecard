class PlayerStatistics {
  final String playerName;
  final int wins;
  final int bestScore;
  final double averageScore;
  final int gamesPlayed;

  const PlayerStatistics({
    required this.playerName,
    required this.wins,
    required this.bestScore,
    required this.averageScore,
    required this.gamesPlayed,
  });
}

class StatisticsModel {
  final int totalGames;
  final int bestScoreOverall;
  final double averageScoreOverall;
  final List<PlayerStatistics> players;

  const StatisticsModel({
    required this.totalGames,
    required this.bestScoreOverall,
    required this.averageScoreOverall,
    required this.players,
  });
}