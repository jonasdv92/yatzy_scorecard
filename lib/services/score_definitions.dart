import '../models/game_type.dart';
import '../models/score_category.dart';
import '../models/score_definition.dart';

class ScoreDefinitions {
  static List<ScoreDefinition> forGameType(GameType type) {
    switch (type) {
      case GameType.yatzy:
        return yatzyDefinitions;
      case GameType.maxiYatzy:
        return maxiYatzyDefinitions;
    }
  }

  static const List<ScoreDefinition> yatzyDefinitions = [
    ScoreDefinition(category: ScoreCategory.ones, isUpperSection: true, key: 'ones'),
    ScoreDefinition(category: ScoreCategory.twos, isUpperSection: true, key: 'twos'),
    ScoreDefinition(category: ScoreCategory.threes, isUpperSection: true, key: 'threes'),
    ScoreDefinition(category: ScoreCategory.fours, isUpperSection: true, key: 'fours'),
    ScoreDefinition(category: ScoreCategory.fives, isUpperSection: true, key: 'fives'),
    ScoreDefinition(category: ScoreCategory.sixes, isUpperSection: true, key: 'sixes'),

    ScoreDefinition(category: ScoreCategory.onePair, isUpperSection: false, key: 'onePair'),
    ScoreDefinition(category: ScoreCategory.twoPairs, isUpperSection: false, key: 'twoPairs'),
    ScoreDefinition(category: ScoreCategory.threeOfAKind, isUpperSection: false, key: 'threeOfAKind'),
    ScoreDefinition(category: ScoreCategory.fourOfAKind, isUpperSection: false, key: 'fourOfAKind'),
    ScoreDefinition(category: ScoreCategory.smallStraight, isUpperSection: false, key: 'smallStraight'),
    ScoreDefinition(category: ScoreCategory.largeStraight, isUpperSection: false, key: 'largeStraight'),
    ScoreDefinition(category: ScoreCategory.fullHouse, isUpperSection: false, key: 'fullHouse'),
    ScoreDefinition(category: ScoreCategory.chance, isUpperSection: false, key: 'chance'),
    ScoreDefinition(category: ScoreCategory.yatzy, isUpperSection: false, key: 'yatzy'),
  ];

  static const List<ScoreDefinition> maxiYatzyDefinitions = [
    ScoreDefinition(category: ScoreCategory.ones, isUpperSection: true, key: 'ones'),
    ScoreDefinition(category: ScoreCategory.twos, isUpperSection: true, key: 'twos'),
    ScoreDefinition(category: ScoreCategory.threes, isUpperSection: true, key: 'threes'),
    ScoreDefinition(category: ScoreCategory.fours, isUpperSection: true, key: 'fours'),
    ScoreDefinition(category: ScoreCategory.fives, isUpperSection: true, key: 'fives'),
    ScoreDefinition(category: ScoreCategory.sixes, isUpperSection: true, key: 'sixes'),

    ScoreDefinition(category: ScoreCategory.onePair, isUpperSection: false, key: 'onePair'),
    ScoreDefinition(category: ScoreCategory.twoPairs, isUpperSection: false, key: 'twoPairs'),
    ScoreDefinition(category: ScoreCategory.threePairs, isUpperSection: false, key: 'threePairs'),
    ScoreDefinition(category: ScoreCategory.threeOfAKind, isUpperSection: false, key: 'threeOfAKind'),
    ScoreDefinition(category: ScoreCategory.fourOfAKind, isUpperSection: false, key: 'fourOfAKind'),
    ScoreDefinition(category: ScoreCategory.fiveOfAKind, isUpperSection: false, key: 'fiveOfAKind'),
    ScoreDefinition(category: ScoreCategory.smallStraight, isUpperSection: false, key: 'smallStraight'),
    ScoreDefinition(category: ScoreCategory.largeStraight, isUpperSection: false, key: 'largeStraight'),
    ScoreDefinition(category: ScoreCategory.fullStraight, isUpperSection: false, key: 'fullStraight'),
    ScoreDefinition(category: ScoreCategory.fullHouse, isUpperSection: false, key: 'fullHouse'),
    ScoreDefinition(category: ScoreCategory.tower, isUpperSection: false, key: 'tower'),
    ScoreDefinition(category: ScoreCategory.castle, isUpperSection: false, key: 'castle'),
    ScoreDefinition(category: ScoreCategory.chance, isUpperSection: false, key: 'chance'),
    ScoreDefinition(category: ScoreCategory.maxiYatzy, isUpperSection: false, key: 'maxiYatzy'),
  ];
}