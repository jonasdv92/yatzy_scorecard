import 'package:flutter/material.dart';

import '../models/player.dart';

class PlayerTabs extends StatelessWidget {
  final List<Player> players;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const PlayerTabs({
    super.key,
    required this.players,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: players.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;

          return ChoiceChip(
            label: Text(players[index].name),
            selected: isSelected,
            onSelected: (_) => onSelected(index),
          );
        },
      ),
    );
  }
}