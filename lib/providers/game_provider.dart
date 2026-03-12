import 'package:flutter/foundation.dart';

import '../models/game.dart';
import '../models/game_type.dart';
import '../models/player.dart';
import '../models/score_category.dart';
import '../services/game_repository.dart';
import '../services/game_service.dart';

class GameProvider extends ChangeNotifier {
  final GameService _gameService = GameService();
  final GameRepository _gameRepository = GameRepository();

  Game? _currentGame;
  List<Game> _savedGames = [];
  int _selectedPlayerIndex = 0;
  bool _isLoading = false;

  Game? get currentGame => _currentGame;
  List<Game> get savedGames => _savedGames;
  int get selectedPlayerIndex => _selectedPlayerIndex;
  bool get isLoading => _isLoading;

  Player? get selectedPlayer {
    if (_currentGame == null) return null;
    if (_currentGame!.players.isEmpty) return null;
    if (_selectedPlayerIndex < 0 || _selectedPlayerIndex >= _currentGame!.players.length) {
      return null;
    }
    return _currentGame!.players[_selectedPlayerIndex];
  }

  Future<void> loadGames() async {
    _isLoading = true;
    notifyListeners();

    _savedGames = _gameRepository.getAllGames();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> createGame({
    required GameType type,
    required List<String> playerNames,
  }) async {
    _isLoading = true;
    notifyListeners();

    final cleanedNames = playerNames
        .map((name) => name.trim())
        .where((name) => name.isNotEmpty)
        .toList();

    final players = <Player>[];

    for (int i = 0; i < cleanedNames.length; i++) {
      players.add(
        Player(
          id: 'player_${DateTime.now().millisecondsSinceEpoch}_$i',
          name: cleanedNames[i],
        ),
      );
    }

    final scores = <String, Map<ScoreCategory, int?>>{};
    for (final player in players) {
      scores[player.id] = _gameService.createEmptyScoreMap(type);
    }

    final now = DateTime.now();

    _currentGame = Game(
      id: now.millisecondsSinceEpoch.toString(),
      type: type,
      players: players,
      scores: scores,
      createdAt: now,
      updatedAt: now,
      isFinished: false,
    );

    _selectedPlayerIndex = 0;

    await _gameRepository.saveGame(_currentGame!);
    _savedGames = _gameRepository.getAllGames();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> openGame(String gameId) async {
    _isLoading = true;
    notifyListeners();

    _currentGame = _gameRepository.getGame(gameId);
    _selectedPlayerIndex = 0;

    _isLoading = false;
    notifyListeners();
  }

  void selectPlayer(int index) {
    if (_currentGame == null) return;
    if (index < 0 || index >= _currentGame!.players.length) return;

    _selectedPlayerIndex = index;
    notifyListeners();
  }

  Future<void> updateScore({
    required String playerId,
    required ScoreCategory category,
    required int value,
  }) async {
    if (_currentGame == null) return;

    _currentGame = _gameService.updateScore(
      game: _currentGame!,
      playerId: playerId,
      category: category,
      value: value,
    );

    await _gameRepository.saveGame(_currentGame!);
    _savedGames = _gameRepository.getAllGames();

    notifyListeners();
  }

  Future<void> updateExtraThrows({
    required String playerId,
    required int newValue,
  }) async {
    if (_currentGame == null) return;

    _currentGame = _gameService.updateExtraThrows(
      game: _currentGame!,
      playerId: playerId,
      newValue: newValue,
    );

    await _gameRepository.saveGame(_currentGame!);
    _savedGames = _gameRepository.getAllGames();

    notifyListeners();
  }

  int getUpperSectionTotal(String playerId) {
    if (_currentGame == null) return 0;
    return _gameService.calculateUpperSectionTotal(_currentGame!, playerId);
  }

  int getLowerSectionTotal(String playerId) {
    if (_currentGame == null) return 0;
    return _gameService.calculateLowerSectionTotal(_currentGame!, playerId);
  }

  int getBonus(String playerId) {
    if (_currentGame == null) return 0;
    return _gameService.calculateBonus(_currentGame!, playerId);
  }

  int getGrandTotal(String playerId) {
    if (_currentGame == null) return 0;
    return _gameService.calculateGrandTotal(_currentGame!, playerId);
  }

  Future<void> deleteGame(String gameId) async {
    await _gameRepository.deleteGame(gameId);

    if (_currentGame?.id == gameId) {
      _currentGame = null;
      _selectedPlayerIndex = 0;
    }

    _savedGames = _gameRepository.getAllGames();
    notifyListeners();
  }

  Future<void> createRematch() async {
    if (_currentGame == null) return;

    _currentGame = _gameService.createRematch(_currentGame!);
    _selectedPlayerIndex = 0;

    await _gameRepository.saveGame(_currentGame!);
    _savedGames = _gameRepository.getAllGames();

    notifyListeners();
  }

  void clearCurrentGame() {
    _currentGame = null;
    _selectedPlayerIndex = 0;
    notifyListeners();
  }
}