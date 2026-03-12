import 'score_category.dart';

class ScoreDefinition {
  final ScoreCategory category;
  final bool isUpperSection;
  final String key;

  const ScoreDefinition({
    required this.category,
    required this.isUpperSection,
    required this.key,
  });
}