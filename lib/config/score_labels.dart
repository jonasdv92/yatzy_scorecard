import '../models/score_category.dart';

class ScoreLabels {
  static String norwegian(ScoreCategory category) {
    switch (category) {
      case ScoreCategory.ones:
        return '1ere';
      case ScoreCategory.twos:
        return '2ere';
      case ScoreCategory.threes:
        return '3ere';
      case ScoreCategory.fours:
        return '4ere';
      case ScoreCategory.fives:
        return '5ere';
      case ScoreCategory.sixes:
        return '6ere';
      case ScoreCategory.onePair:
        return 'Ett par';
      case ScoreCategory.twoPairs:
        return 'To par';
      case ScoreCategory.threePairs:
        return 'Tre par';
      case ScoreCategory.threeOfAKind:
        return 'Tre like';
      case ScoreCategory.fourOfAKind:
        return 'Fire like';
      case ScoreCategory.fiveOfAKind:
        return 'Fem like';
      case ScoreCategory.smallStraight:
        return 'Liten straight';
      case ScoreCategory.largeStraight:
        return 'Stor straight';
      case ScoreCategory.fullStraight:
        return 'Full straight';
      case ScoreCategory.fullHouse:
        return 'Hytte';
      case ScoreCategory.castle:
        return 'Hus';
      case ScoreCategory.tower:
        return 'Tårn';
      case ScoreCategory.chance:
        return 'Sjanse';
      case ScoreCategory.yatzy:
        return 'Yatzy';
      case ScoreCategory.maxiYatzy:
        return 'Maxi Yatzy';
    }
  }
}