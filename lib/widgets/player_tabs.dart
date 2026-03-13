import 'package:flutter/material.dart';

import '../models/player.dart';
import '../config/app_theme.dart';

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
      height: 46,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: players.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;

          return ChoiceChip(
            label: Text(
              players[index].name,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : AppTheme.textPrimary,
              ),
            ),
            selected: isSelected,
            selectedColor: AppTheme.primary,
            backgroundColor: Colors.white,
            side: BorderSide(
              color: isSelected
                  ? AppTheme.primary
                  : Colors.black.withValues(alpha: 0.08),
            ),
            onSelected: (_) => onSelected(index),
          );
        },
      ),
    );
  }
}