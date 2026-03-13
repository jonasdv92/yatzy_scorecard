import '../models/game_type.dart';
import '../models/score_category.dart';

class ScoreRule {
  final String titleNo;
  final String titleEn;
  final String descriptionNo;
  final String descriptionEn;
  final String exampleNo;
  final String exampleEn;

  const ScoreRule({
    required this.titleNo,
    required this.titleEn,
    required this.descriptionNo,
    required this.descriptionEn,
    required this.exampleNo,
    required this.exampleEn,
  });
}

class ScoreRules {
  static final Map<ScoreCategory, ScoreRule> rules = {
    ScoreCategory.ones: const ScoreRule(
      titleNo: '1ere',
      titleEn: 'Ones',
      descriptionNo: 'Poeng summen av alle terninger med verdi 1.',
      descriptionEn: 'Score the sum of all dice showing 1.',
      exampleNo: 'Eksempel: 1-1-3-4-6 = 2',
      exampleEn: 'Example: 1-1-3-4-6 = 2',
    ),
    ScoreCategory.twos: const ScoreRule(
      titleNo: '2ere',
      titleEn: 'Twos',
      descriptionNo: 'Poeng summen av alle terninger med verdi 2.',
      descriptionEn: 'Score the sum of all dice showing 2.',
      exampleNo: 'Eksempel: 2-2-5-6-6 = 4',
      exampleEn: 'Example: 2-2-5-6-6 = 4',
    ),
    ScoreCategory.threes: const ScoreRule(
      titleNo: '3ere',
      titleEn: 'Threes',
      descriptionNo: 'Poeng summen av alle terninger med verdi 3.',
      descriptionEn: 'Score the sum of all dice showing 3.',
      exampleNo: 'Eksempel: 3-3-3-4-6 = 9',
      exampleEn: 'Example: 3-3-3-4-6 = 9',
    ),
    ScoreCategory.fours: const ScoreRule(
      titleNo: '4ere',
      titleEn: 'Fours',
      descriptionNo: 'Poeng summen av alle terninger med verdi 4.',
      descriptionEn: 'Score the sum of all dice showing 4.',
      exampleNo: 'Eksempel: 4-4-2-1-6 = 8',
      exampleEn: 'Example: 4-4-2-1-6 = 8',
    ),
    ScoreCategory.fives: const ScoreRule(
      titleNo: '5ere',
      titleEn: 'Fives',
      descriptionNo: 'Poeng summen av alle terninger med verdi 5.',
      descriptionEn: 'Score the sum of all dice showing 5.',
      exampleNo: 'Eksempel: 5-5-5-2-1 = 15',
      exampleEn: 'Example: 5-5-5-2-1 = 15',
    ),
    ScoreCategory.sixes: const ScoreRule(
      titleNo: '6ere',
      titleEn: 'Sixes',
      descriptionNo: 'Poeng summen av alle terninger med verdi 6.',
      descriptionEn: 'Score the sum of all dice showing 6.',
      exampleNo: 'Eksempel: 6-6-3-2-1 = 12',
      exampleEn: 'Example: 6-6-3-2-1 = 12',
    ),
    ScoreCategory.onePair: const ScoreRule(
      titleNo: 'Ett par',
      titleEn: 'One Pair',
      descriptionNo: 'To like terninger. Poeng = summen av paret.',
      descriptionEn: 'Two matching dice. Score = the sum of the pair.',
      exampleNo: 'Eksempel: 3-3-4-5-6 = 6',
      exampleEn: 'Example: 3-3-4-5-6 = 6',
    ),
    ScoreCategory.twoPairs: const ScoreRule(
      titleNo: 'To par',
      titleEn: 'Two Pairs',
      descriptionNo: 'To forskjellige par. Poeng = summen av begge parene.',
      descriptionEn: 'Two different pairs. Score = the sum of both pairs.',
      exampleNo: 'Eksempel: 2-2-5-5-6 = 14',
      exampleEn: 'Example: 2-2-5-5-6 = 14',
    ),
    ScoreCategory.threePairs: const ScoreRule(
      titleNo: 'Tre par',
      titleEn: 'Three Pairs',
      descriptionNo: 'Tre forskjellige par. Poeng = summen av alle seks terningene.',
      descriptionEn: 'Three different pairs. Score = the sum of all six dice.',
      exampleNo: 'Eksempel: 2-2-4-4-6-6 = 24',
      exampleEn: 'Example: 2-2-4-4-6-6 = 24',
    ),
    ScoreCategory.threeOfAKind: const ScoreRule(
      titleNo: 'Tre like',
      titleEn: 'Three of a Kind',
      descriptionNo: 'Tre like terninger. Poeng = summen av de tre like terningene.',
      descriptionEn: 'Three matching dice. Score = the sum of the three matching dice.',
      exampleNo: 'Eksempel: 4-4-4-2-6 = 12',
      exampleEn: 'Example: 4-4-4-2-6 = 12',
    ),
    ScoreCategory.fourOfAKind: const ScoreRule(
      titleNo: 'Fire like',
      titleEn: 'Four of a Kind',
      descriptionNo: 'Fire like terninger. Poeng = summen av de fire like terningene.',
      descriptionEn: 'Four matching dice. Score = the sum of the four matching dice.',
      exampleNo: 'Eksempel: 6-6-6-6-2 = 24',
      exampleEn: 'Example: 6-6-6-6-2 = 24',
    ),
    ScoreCategory.fiveOfAKind: const ScoreRule(
      titleNo: 'Fem like',
      titleEn: 'Five of a Kind',
      descriptionNo: 'Fem like terninger. Poeng = summen av de fem like terningene.',
      descriptionEn: 'Five matching dice. Score = the sum of the five matching dice.',
      exampleNo: 'Eksempel: 4-4-4-4-4-1 = 20',
      exampleEn: 'Example: 4-4-4-4-4-1 = 20',
    ),
    ScoreCategory.smallStraight: const ScoreRule(
      titleNo: 'Liten straight',
      titleEn: 'Small Straight',
      descriptionNo: 'Kombinasjonen 1-2-3-4-5. Fast poengsum 15.',
      descriptionEn: 'The combination 1-2-3-4-5. Fixed score 15.',
      exampleNo: 'Eksempel: 1-2-3-4-5 = 15',
      exampleEn: 'Example: 1-2-3-4-5 = 15',
    ),
    ScoreCategory.largeStraight: const ScoreRule(
      titleNo: 'Stor straight',
      titleEn: 'Large Straight',
      descriptionNo: 'Kombinasjonen 2-3-4-5-6. Fast poengsum 20.',
      descriptionEn: 'The combination 2-3-4-5-6. Fixed score 20.',
      exampleNo: 'Eksempel: 2-3-4-5-6 = 20',
      exampleEn: 'Example: 2-3-4-5-6 = 20',
    ),
    ScoreCategory.fullStraight: const ScoreRule(
      titleNo: 'Full straight',
      titleEn: 'Full Straight',
      descriptionNo: 'Kombinasjonen 1-2-3-4-5-6. Fast poengsum 21.',
      descriptionEn: 'The combination 1-2-3-4-5-6. Fixed score 21.',
      exampleNo: 'Eksempel: 1-2-3-4-5-6 = 21',
      exampleEn: 'Example: 1-2-3-4-5-6 = 21',
    ),
    ScoreCategory.fullHouse: const ScoreRule(
      titleNo: 'Hus',
      titleEn: 'Full House',
      descriptionNo: 'Tre like og ett par. Poeng = summen av terningene i kombinasjonen.',
      descriptionEn: 'Three of a kind and one pair. Score = the sum of the dice in the combination.',
      exampleNo: 'Eksempel: 2-2-5-5-5 = 19',
      exampleEn: 'Example: 2-2-5-5-5 = 19',
    ),
    ScoreCategory.castle: const ScoreRule(
      titleNo: 'Hus',
      titleEn: 'House',
      descriptionNo: 'Tre like og tre like. Poeng = summen av alle seks terningene.',
      descriptionEn: 'Three of a kind and three of a kind. Score = the sum of all six dice.',
      exampleNo: 'Eksempel: 2-2-2-5-5-5 = 21',
      exampleEn: 'Example: 2-2-2-5-5-5 = 21',
    ),
    ScoreCategory.tower: const ScoreRule(
      titleNo: 'Tårn',
      titleEn: 'Tower',
      descriptionNo: 'Ett par og fire like. Poeng = summen av terningene i kombinasjonen.',
      descriptionEn: 'One pair and four of a kind. Score = the sum of the dice in the combination.',
      exampleNo: 'Eksempel: 3-3-3-3-6-6 = 24',
      exampleEn: 'Example: 3-3-3-3-6-6 = 24',
    ),
    ScoreCategory.chance: const ScoreRule(
      titleNo: 'Sjanse',
      titleEn: 'Chance',
      descriptionNo: 'Her kan alle terningene brukes. Poeng = summen av alle terningene.',
      descriptionEn: 'Any dice combination. Score = the sum of all dice.',
      exampleNo: 'Eksempel: 2-3-4-5-6 = 20',
      exampleEn: 'Example: 2-3-4-5-6 = 20',
    ),
    ScoreCategory.yatzy: const ScoreRule(
      titleNo: 'Yatzy',
      titleEn: 'Yatzy',
      descriptionNo: 'Fem like terninger. Fast poengsum 50.',
      descriptionEn: 'Five matching dice. Fixed score 50.',
      exampleNo: 'Eksempel: 6-6-6-6-6 = 50',
      exampleEn: 'Example: 6-6-6-6-6 = 50',
    ),
    ScoreCategory.maxiYatzy: const ScoreRule(
      titleNo: 'Maxi Yatzy',
      titleEn: 'Maxi Yatzy',
      descriptionNo: 'Seks like terninger. Fast poengsum 100.',
      descriptionEn: 'Six matching dice. Fixed score 100.',
      exampleNo: 'Eksempel: 6-6-6-6-6-6 = 100',
      exampleEn: 'Example: 6-6-6-6-6-6 = 100',
    ),
  };

  static String title(
    String languageCode,
    ScoreCategory category, {
    GameType? gameType,
  }) {
    if (languageCode == 'no' &&
        gameType == GameType.maxiYatzy &&
        category == ScoreCategory.fullHouse) {
      return 'Hytte';
    }

    final rule = rules[category];
    if (rule == null) return category.name;
    return languageCode == 'en' ? rule.titleEn : rule.titleNo;
  }

  static String description(String languageCode, ScoreCategory category) {
    final rule = rules[category];
    if (rule == null) return '';
    return languageCode == 'en' ? rule.descriptionEn : rule.descriptionNo;
  }

  static String example(String languageCode, ScoreCategory category) {
    final rule = rules[category];
    if (rule == null) return '';
    return languageCode == 'en' ? rule.exampleEn : rule.exampleNo;
  }
}