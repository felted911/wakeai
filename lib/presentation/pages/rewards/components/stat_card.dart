import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/peri_card.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final double width;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.width = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return PeriCard(
      padding: const EdgeInsets.all(16),
      width: width,
      child: Column(
        children: [
          Icon(
            icon,
            color: AppTheme.primaryGold,
            size: 32,
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryGold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.textLight,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
