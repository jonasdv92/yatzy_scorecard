import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app_constants.dart';
import '../models/game_type.dart';
import '../providers/game_provider.dart';
import '../widgets/primary_button.dart';
import 'game_screen.dart';

class NewGameScreen extends StatefulWidget {
  final GameType gameType;

  const NewGameScreen({
    super.key,
    required this.gameType,
  });

  @override
  State<NewGameScreen> createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> {
  final List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _controllers.add(TextEditingController(text: 'Spiller 1'));
    _controllers.add(TextEditingController(text: 'Spiller 2'));
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addPlayer() {
    if (_controllers.length >= AppConstants.maxPlayers) return;

    setState(() {
      _controllers.add(
        TextEditingController(
          text: 'Spiller ${_controllers.length + 1}',
        ),
      );
    });
  }

  void _removePlayer(int index) {
    if (_controllers.length <= 1) return;

    setState(() {
      _controllers[index].dispose();
      _controllers.removeAt(index);
    });
  }

  Future<void> _startGame() async {
    final names = _controllers.map((c) => c.text).toList();

    await context.read<GameProvider>().createGame(
          type: widget.gameType,
          playerNames: names,
        );

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => GameScreen(),
      ),
    );
  }

  String get _gameTitle {
    switch (widget.gameType) {
      case GameType.yatzy:
        return 'Nytt Yatzy-spill';
      case GameType.maxiYatzy:
        return 'Nytt Maxi Yatzy-spill';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<GameProvider>().isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(_gameTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _controllers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controllers[index],
                            decoration: InputDecoration(
                              labelText: 'Spiller ${index + 1}',
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: _controllers.length <= 1
                              ? null
                              : () => _removePlayer(index),
                          icon: const Icon(Icons.delete_outline),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              text: 'Legg til spiller',
              onPressed: _addPlayer,
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              text: isLoading ? 'Oppretter...' : 'Start spill',
              onPressed: isLoading ? () {} : _startGame,
            ),
          ],
        ),
      ),
    );
  }
}