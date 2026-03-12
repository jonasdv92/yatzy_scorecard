import 'package:hive/hive.dart';

import '../models/game.dart';
import 'storage_service.dart';

class GameRepository {
  Box<Game> get _box => Hive.box<Game>(StorageService.gamesBoxName);

  Future<void> saveGame(Game game) async {
    await _box.put(game.id, game);
  }

  Game? getGame(String id) {
    return _box.get(id);
  }

  List<Game> getAllGames() {
    return _box.values.toList();
  }

  Future<void> deleteGame(String id) async {
    await _box.delete(id);
  }
}