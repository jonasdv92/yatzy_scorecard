import 'package:hive/hive.dart';

import 'player.dart';
import 'game_type.dart';
import 'score_category.dart';

part 'game.g.dart';

@HiveType(typeId: 0)
class Game extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final GameType type;

  @HiveField(2)
  final List<Player> players;

  @HiveField(3)
  final Map<String, Map<ScoreCategory, int?>> scores;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final DateTime updatedAt;

  @HiveField(6)
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