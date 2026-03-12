import 'package:hive/hive.dart';

part 'game_type.g.dart';

@HiveType(typeId: 2)
enum GameType {
  @HiveField(0)
  yatzy,

  @HiveField(1)
  maxiYatzy,
}