import 'package:flutter/material.dart';

class TotalsCard extends StatelessWidget {
  final int upperTotal;
  final int bonus;
  final int lowerTotal;
  final int grandTotal;

  const TotalsCard({
    super.key,
    required this.upperTotal,
    required this.bonus,
    required this.lowerTotal,
    required this.grandTotal,
  });

  Widget _buildRow(String label, int value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Text(
            value.toString(),
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildRow('Sum øvre del', upperTotal),
            _buildRow('Bonus', bonus),
            _buildRow('Sum nedre del', lowerTotal),
            const Divider(),
            _buildRow('Total', grandTotal, bold: true),
          ],
        ),
      ),
    );
  }
}