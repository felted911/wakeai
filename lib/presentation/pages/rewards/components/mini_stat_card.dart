import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class MiniStatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const MiniStatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppTheme.primaryGold.withValues(),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppTheme.primaryGold),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppTheme.textLight),
        ),
      ],
    );
  }
}
