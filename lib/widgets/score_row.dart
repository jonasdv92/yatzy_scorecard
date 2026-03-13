import 'package:flutter/material.dart';

class ScoreRow extends StatelessWidget {
  final String title;
  final int? value;
  final VoidCallback onTap;
  final VoidCallback? onInfoTap;

  const ScoreRow({
    super.key,
    required this.title,
    required this.value,
    required this.onTap,
    this.onInfoTap,
  });

  @override
  Widget build(BuildContext context) {
    final isFilled = value != null;

    return Material(
      color: isFilled ? Colors.teal.withValues(alpha: 0.08) : Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              if (onInfoTap != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: InkWell(
                    onTap: onInfoTap,
                    child: const Icon(Icons.info_outline, size: 20),
                  ),
                ),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Text(
                value?.toString() ?? '-',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}