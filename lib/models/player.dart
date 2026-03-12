import 'package:hive/hive.dart';

part 'player.g.dart';

@HiveType(typeId: 1)
class Player extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int extraThrows;

  Player({
    required this.id,
    required this.name,
    this.extraThrows = 0,
  });

  Player copyWith({
    String? id,
    String? name,
    int? extraThrows,
  }) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      extraThrows: extraThrows ?? this.extraThrows,
    );
  }
}