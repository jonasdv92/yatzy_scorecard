import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/game.dart';
import 'models/player.dart';
import 'models/game_type.dart';
import 'models/score_category.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(GameAdapter());
  Hive.registerAdapter(PlayerAdapter());
  Hive.registerAdapter(GameTypeAdapter());
  Hive.registerAdapter(ScoreCategoryAdapter());

  await StorageService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yatzy Scorecard',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Yatzy Scorecard'),
        ),
        body: const Center(
          child: Text('App setup is working'),
        ),
      ),
    );
  }
}