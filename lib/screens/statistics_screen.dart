import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/statistics_provider.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<StatisticsProvider>().loadStatistics();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StatisticsProvider>();
    final statistics = provider.statistics;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistikk'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : statistics == null || statistics.totalGames == 0
                ? const Center(
                    child: Text('Ingen ferdige spill ennå'),
                  )
                : ListView(
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              _StatRow(
                                label: 'Antall spill',
                                value: statistics.totalGames.toString(),
                              ),
                              _StatRow(
                                label: 'Beste score',
                                value: statistics.bestScoreOverall.toString(),
                              ),
                              _StatRow(
                                label: 'Gjennomsnitt',
                                value: statistics.averageScoreOverall
                                    .toStringAsFixed(1),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Per spiller',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...statistics.players.map(
                        (player) => Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  player.playerName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                _StatRow(
                                  label: 'Spill',
                                  value: player.gamesPlayed.toString(),
                                ),
                                _StatRow(
                                  label: 'Seiere',
                                  value: player.wins.toString(),
                                ),
                                _StatRow(
                                  label: 'Beste score',
                                  value: player.bestScore.toString(),
                                ),
                                _StatRow(
                                  label: 'Gjennomsnitt',
                                  value:
                                      player.averageScore.toStringAsFixed(1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;

  const _StatRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}