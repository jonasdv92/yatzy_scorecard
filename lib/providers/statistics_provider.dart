import 'package:flutter/foundation.dart';

import '../models/statistics_model.dart';
import '../services/game_repository.dart';
import '../services/statistics_service.dart';

class StatisticsProvider extends ChangeNotifier {
  final GameRepository _gameRepository = GameRepository();
  final StatisticsService _statisticsService = StatisticsService();

  StatisticsModel? _statistics;
  bool _isLoading = false;

  StatisticsModel? get statistics => _statistics;
  bool get isLoading => _isLoading;

  Future<void> loadStatistics() async {
    _isLoading = true;
    notifyListeners();

    try {
      final games = _gameRepository.getAllGames();
      _statistics = _statisticsService.calculate(games);
    } catch (e) {
      debugPrint('loadStatistics error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}