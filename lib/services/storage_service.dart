import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  static const String gamesBoxName = 'games';

  static Future<void> init() async {
    await Hive.openBox(gamesBoxName);
  }
}