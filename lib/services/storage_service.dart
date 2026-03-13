import 'package:hive_flutter/hive_flutter.dart';

import '../models/game.dart';

class StorageService {
  static const String gamesBoxName = 'games';

  static Future<void> init() async {
    await Hive.openBox<Game>(gamesBoxName);
  }
}