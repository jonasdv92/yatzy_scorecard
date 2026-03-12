import 'package:flutter/material.dart';

class ScoreRow extends StatelessWidget {
  final String title;
  final int? value;
  final VoidCallback onTap;

  const ScoreRow({
    super.key,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isFilled = value != null;

    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      tileColor: isFilled ? Colors.teal.withValues(alpha: 0.08) : null,
      title: Text(title),
      trailing: Text(
        value?.toString() ?? '-',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }
}