import 'package:flutter/material.dart';
import '../../../widgets/peri_card.dart';
import '../../../theme/app_theme.dart';
import '../../../../core/util/color_extensions.dart';

class ActivityCard extends StatelessWidget {
  final Map<String, dynamic> activity;
  final bool isActive;
  
  const ActivityCard({
    super.key,
    required this.activity,
    this.isActive = true,
  });

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    if (minutes == 1) {
      return '1 minute';
    }
    return '$minutes minutes';
  }

  @override
  Widget build(BuildContext context) {
    return PeriCard(
      elevation: isActive ? 4 : 2,
      padding: isActive ? const EdgeInsets.all(24) : const EdgeInsets.all(16),
      child: isActive ? _buildActiveCard(context) : _buildUpcomingCard(context),
    );
  }

  Widget _buildActiveCard(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppTheme.primaryGold.withAlphaValue(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                activity['icon'] as IconData,
                color: AppTheme.primaryGold,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity['title'] as String,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _formatDuration(activity['duration'] as int),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textLight,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Instructions
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.primaryGold.withAlphaValue(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppTheme.primaryGold.withAlphaValue(0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.tips_and_updates_outlined,
                color: AppTheme.primaryGold,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  activity['instruction'] as String,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingCard(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.withAlphaValue(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            activity['icon'] as IconData,
            color: Colors.grey,
          ),
        ),
        
        const SizedBox(width: 16),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                activity['title'] as String,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _formatDuration(activity['duration'] as int),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textLight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
