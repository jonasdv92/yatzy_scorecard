import 'package:hive/hive.dart';

part 'score_category.g.dart';

@HiveType(typeId: 3)
enum ScoreCategory {
  @HiveField(0)
  ones,

  @HiveField(1)
  twos,

  @HiveField(2)
  threes,

  @HiveField(3)
  fours,

  @HiveField(4)
  fives,

  @HiveField(5)
  sixes,

  @HiveField(6)
  onePair,

  @HiveField(7)
  twoPairs,

  @HiveField(8)
  threePairs,

  @HiveField(9)
  threeOfAKind,

  @HiveField(10)
  fourOfAKind,

  @HiveField(11)
  fiveOfAKind,

  @HiveField(12)
  smallStraight,

  @HiveField(13)
  largeStraight,

  @HiveField(14)
  fullStraight,

  @HiveField(15)
  fullHouse,

  @HiveField(16)
  tower,

  @HiveField(17)
  castle,

  @HiveField(18)
  chance,

  @HiveField(19)
  yatzy,

  @HiveField(20)
  maxiYatzy,
}