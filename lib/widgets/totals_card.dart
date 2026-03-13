import 'package:flutter/material.dart';

class TotalsCard extends StatelessWidget {
  final int upperTotal;
  final int bonus;
  final int lowerTotal;
  final int grandTotal;
  final String upperLabel;
  final String bonusLabel;
  final String lowerLabel;
  final String totalLabel;

  const TotalsCard({
    super.key,
    required this.upperTotal,
    required this.bonus,
    required this.lowerTotal,
    required this.grandTotal,
    required this.upperLabel,
    required this.bonusLabel,
    required this.lowerLabel,
    required this.totalLabel,
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
            _buildRow(upperLabel, upperTotal),
            _buildRow(bonusLabel, bonus),
            _buildRow(lowerLabel, lowerTotal),
            const Divider(),
            _buildRow(totalLabel, grandTotal, bold: true),
          ],
        ),
      ),
    );
  }
}