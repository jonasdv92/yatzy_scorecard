import 'package:flutter/material.dart';

class ExtraThrowsCounter extends StatelessWidget {
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ExtraThrowsCounter({
    super.key,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            const Expanded(
              child: Text(
                'Ekstra kast',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            IconButton(
              onPressed: value > 0 ? onDecrement : null,
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: onIncrement,
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
      ),
    );
  }
}