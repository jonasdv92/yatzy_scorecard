import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app_texts.dart';
import '../models/game.dart';
import '../models/game_type.dart';
import '../providers/game_provider.dart';
import '../providers/settings_provider.dart';
import 'game_screen.dart';

class ContinueGameScreen extends StatefulWidget {
  const ContinueGameScreen({super.key});

  @override
  State<ContinueGameScreen> createState() => _ContinueGameScreenState();
}

class _ContinueGameScreenState extends State<ContinueGameScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<GameProvider>().loadGames();
    });
  }

  String _gameTypeLabel(GameType type) {
    switch (type) {
      case GameType.yatzy:
        return 'Yatzy';
      case GameType.maxiYatzy:
        return 'Maxi Yatzy';
    }
  }

  String _statusLabel(Game game, String languageCode) {
    return game.isFinished
        ? AppTexts.t(languageCode, 'finished')
        : AppTexts.t(languageCode, 'inProgress');
  }

  String _playersLabel(Game game, String languageCode) {
    final singular = AppTexts.t(languageCode, 'player');
    final plural = AppTexts.t(languageCode, 'players');

    if (game.players.isEmpty) return '0 $plural';
    if (game.players.length == 1) return '1 $singular';
    return '${game.players.length} $plural';
  }

  Future<void> _openGame(BuildContext context, String gameId) async {
    await context.read<GameProvider>().openGame(gameId);

    if (!context.mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const GameScreen(),
      ),
    );
  }

  Future<void> _deleteGame(
    BuildContext context,
    String gameId,
    String languageCode,
  ) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppTexts.t(languageCode, 'deleteGame')),
          content: Text(AppTexts.t(languageCode, 'deleteGameConfirm')),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(AppTexts.t(languageCode, 'cancel')),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(AppTexts.t(languageCode, 'delete')),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true && context.mounted) {
      await context.read<GameProvider>().deleteGame(gameId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GameProvider>();
    final games = provider.savedGames;
    final isLoading = provider.isLoading;
    final languageCode = context.watch<SettingsProvider>().languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.t(languageCode, 'savedGames')),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : games.isEmpty
                  ? Center(
                      child: Text(AppTexts.t(languageCode, 'noSavedGames')),
                    )
                  : ListView.builder(
                      itemCount: games.length,
                      itemBuilder: (context, index) {
                        final game = games[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            title: Text(_gameTypeLabel(game.type)),
                            subtitle: Text(
                              '${_playersLabel(game, languageCode)} • ${_statusLabel(game, languageCode)}',
                            ),
                            trailing: IconButton(
                              onPressed: () =>
                                  _deleteGame(context, game.id, languageCode),
                              icon: const Icon(Icons.delete_outline),
                            ),
                            onTap: () => _openGame(context, game.id),
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}