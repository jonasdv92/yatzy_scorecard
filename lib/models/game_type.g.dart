// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameTypeAdapter extends TypeAdapter<GameType> {
  @override
  final int typeId = 2;

  @override
  GameType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return GameType.yatzy;
      case 1:
        return GameType.maxiYatzy;
      default:
        return GameType.yatzy;
    }
  }

  @override
  void write(BinaryWriter writer, GameType obj) {
    switch (obj) {
      case GameType.yatzy:
        writer.writeByte(0);
        break;
      case GameType.maxiYatzy:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
