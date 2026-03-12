import 'player.dart';
import 'game_type.dart';
import 'score_category.dart';

class Game {
  final String id;
  final GameType type;
  final List<Player> players;
  final Map<String, Map<ScoreCategory, int?>> scores;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isFinished;

  Game({
    required this.id,
    required this.type,
    required this.players,
    required this.scores,
    required this.createdAt,
    required this.updatedAt,
    required this.isFinished,
  });

  Game copyWith({
    String? id,
    GameType? type,
    List<Player>? players,
    Map<String, Map<ScoreCategory, int?>>? scores,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isFinished,
  }) {
    return Game(
      id: id ?? this.id,
      type: type ?? this.type,
      players: players ?? this.players,
      scores: scores ?? this.scores,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isFinished: isFinished ?? this.isFinished,
    );
  }
}