import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/game.dart';
import '../models/game_type.dart';
import '../providers/game_provider.dart';
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

  String _statusLabel(Game game) {
    return game.isFinished ? 'Ferdig' : 'Pågår';
  }

  String _playersLabel(Game game) {
    if (game.players.isEmpty) return '0 spillere';
    if (game.players.length == 1) return '1 spiller';
    return '${game.players.length} spillere';
  }

  Future<void> _openGame(BuildContext context, String gameId) async {
    await context.read<GameProvider>().openGame(gameId);

    if (!context.mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GameScreen(),
      ),
    );
  }

  Future<void> _deleteGame(BuildContext context, String gameId) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Slett spill'),
          content: const Text('Er du sikker på at du vil slette dette spillet?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Avbryt'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Slett'),
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fortsett spill'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : games.isEmpty
                ? const Center(
                    child: Text('Ingen lagrede spill'),
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
                            '${_playersLabel(game)} • ${_statusLabel(game)}',
                          ),
                          trailing: IconButton(
                            onPressed: () => _deleteGame(context, game.id),
                            icon: const Icon(Icons.delete_outline),
                          ),
                          onTap: () => _openGame(context, game.id),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}