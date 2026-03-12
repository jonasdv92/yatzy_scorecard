// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScoreCategoryAdapter extends TypeAdapter<ScoreCategory> {
  @override
  final int typeId = 3;

  @override
  ScoreCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ScoreCategory.ones;
      case 1:
        return ScoreCategory.twos;
      case 2:
        return ScoreCategory.threes;
      case 3:
        return ScoreCategory.fours;
      case 4:
        return ScoreCategory.fives;
      case 5:
        return ScoreCategory.sixes;
      case 6:
        return ScoreCategory.onePair;
      case 7:
        return ScoreCategory.twoPairs;
      case 8:
        return ScoreCategory.threePairs;
      case 9:
        return ScoreCategory.threeOfAKind;
      case 10:
        return ScoreCategory.fourOfAKind;
      case 11:
        return ScoreCategory.fiveOfAKind;
      case 12:
        return ScoreCategory.smallStraight;
      case 13:
        return ScoreCategory.largeStraight;
      case 14:
        return ScoreCategory.fullStraight;
      case 15:
        return ScoreCategory.fullHouse;
      case 16:
        return ScoreCategory.tower;
      case 17:
        return ScoreCategory.castle;
      case 18:
        return ScoreCategory.chance;
      case 19:
        return ScoreCategory.yatzy;
      case 20:
        return ScoreCategory.maxiYatzy;
      default:
        return ScoreCategory.ones;
    }
  }

  @override
  void write(BinaryWriter writer, ScoreCategory obj) {
    switch (obj) {
      case ScoreCategory.ones:
        writer.writeByte(0);
        break;
      case ScoreCategory.twos:
        writer.writeByte(1);
        break;
      case ScoreCategory.threes:
        writer.writeByte(2);
        break;
      case ScoreCategory.fours:
        writer.writeByte(3);
        break;
      case ScoreCategory.fives:
        writer.writeByte(4);
        break;
      case ScoreCategory.sixes:
        writer.writeByte(5);
        break;
      case ScoreCategory.onePair:
        writer.writeByte(6);
        break;
      case ScoreCategory.twoPairs:
        writer.writeByte(7);
        break;
      case ScoreCategory.threePairs:
        writer.writeByte(8);
        break;
      case ScoreCategory.threeOfAKind:
        writer.writeByte(9);
        break;
      case ScoreCategory.fourOfAKind:
        writer.writeByte(10);
        break;
      case ScoreCategory.fiveOfAKind:
        writer.writeByte(11);
        break;
      case ScoreCategory.smallStraight:
        writer.writeByte(12);
        break;
      case ScoreCategory.largeStraight:
        writer.writeByte(13);
        break;
      case ScoreCategory.fullStraight:
        writer.writeByte(14);
        break;
      case ScoreCategory.fullHouse:
        writer.writeByte(15);
        break;
      case ScoreCategory.tower:
        writer.writeByte(16);
        break;
      case ScoreCategory.castle:
        writer.writeByte(17);
        break;
      case ScoreCategory.chance:
        writer.writeByte(18);
        break;
      case ScoreCategory.yatzy:
        writer.writeByte(19);
        break;
      case ScoreCategory.maxiYatzy:
        writer.writeByte(20);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScoreCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
