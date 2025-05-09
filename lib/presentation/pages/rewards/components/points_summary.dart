import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/peri_button.dart';
import '../../../../core/util/color_extensions.dart';

class PointsSummary extends StatelessWidget {
  final int totalPoints;
  final VoidCallback onRedeem;

  const PointsSummary({
    super.key,
    required this.totalPoints,
    required this.onRedeem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryGold.withAlphaValue(0.8),
            AppTheme.primaryGold.withAlphaValue(0.6),
          ],
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withAlphaValue(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.emoji_events,
              size: 32,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  totalPoints.toString(),
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Reward Points',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white.withAlphaValue(0.8),
                  ),
                ),
              ],
            ),
          ),
          PeriButton(
            text: 'Redeem',
            onPressed: onRedeem,
            type: PeriButtonType.secondary,
          ),
        ],
      ),
    );
  }
}
