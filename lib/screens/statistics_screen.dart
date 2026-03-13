import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app_texts.dart';
import '../providers/settings_provider.dart';
import '../providers/statistics_provider.dart';
import '../providers/purchase_provider.dart';
import 'pro_screen.dart';

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
    final languageCode = context.watch<SettingsProvider>().languageCode;
    final isPro = context.watch<PurchaseProvider>().isPro;

    if (!isPro) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppTexts.t(languageCode, 'statistics')),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.lock_outline,
                        size: 38,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        AppTexts.t(languageCode, 'statisticsEmpty'),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ProScreen(),
                              ),
                            );
                          },
                          child: Text(AppTexts.t(languageCode, 'getPro')),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.t(languageCode, 'statistics')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : statistics == null || statistics.totalGames == 0
                ? Center(
                    child: Text(AppTexts.t(languageCode, 'statisticsEmpty')),
                  )
                : ListView(
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              _StatRow(
                                label: AppTexts.t(languageCode, 'gamesPlayed'),
                                value: statistics.totalGames.toString(),
                              ),
                              _StatRow(
                                label: AppTexts.t(languageCode, 'bestScore'),
                                value: statistics.bestScoreOverall.toString(),
                              ),
                              _StatRow(
                                label: AppTexts.t(languageCode, 'average'),
                                value: statistics.averageScoreOverall
                                    .toStringAsFixed(1),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppTexts.t(languageCode, 'perPlayer'),
                        style: const TextStyle(
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
                                  label: AppTexts.t(languageCode, 'gamesPlayed'),
                                  value: player.gamesPlayed.toString(),
                                ),
                                _StatRow(
                                  label: AppTexts.t(languageCode, 'wins'),
                                  value: player.wins.toString(),
                                ),
                                _StatRow(
                                  label: AppTexts.t(languageCode, 'bestScore'),
                                  value: player.bestScore.toString(),
                                ),
                                _StatRow(
                                  label: AppTexts.t(languageCode, 'average'),
                                  value: player.averageScore.toStringAsFixed(1),
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