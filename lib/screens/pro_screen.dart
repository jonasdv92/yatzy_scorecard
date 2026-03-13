import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app_texts.dart';
import '../providers/purchase_provider.dart';
import '../providers/settings_provider.dart';

class ProScreen extends StatelessWidget {
  const ProScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageCode = context.watch<SettingsProvider>().languageCode;
    final isPro = context.watch<PurchaseProvider>().isPro;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.t(languageCode, 'proVersion')),
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
                      Icons.workspace_premium,
                      size: 42,
                      color: Color(0xFFE6C068),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      AppTexts.t(languageCode, 'proVersion'),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      AppTexts.t(languageCode, 'proDescription'),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    _BenefitTile(
                      text: AppTexts.t(languageCode, 'removeAds'),
                    ),
                    _BenefitTile(
                      text: AppTexts.t(languageCode, 'unlockStatistics'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            if (!isPro)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<PurchaseProvider>().unlockPro();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppTexts.t(languageCode, 'proActivated'),
                        ),
                      ),
                    );
                  },
                  child: Text(AppTexts.t(languageCode, 'activateProDemo')),
                ),
              ),
            if (isPro)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          AppTexts.t(languageCode, 'proActive'),
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
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
}

class _BenefitTile extends StatelessWidget {
  final String text;

  const _BenefitTile({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(
            Icons.check,
            size: 18,
            color: Color(0xFF0F766E),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}