import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/peri_card.dart';

class AchievementCard extends StatelessWidget {
  final Map<String, dynamic> achievement;

  const AchievementCard({super.key, required this.achievement});

  @override
  Widget build(BuildContext context) {
    final isComplete = achievement['isComplete'] == true;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: PeriCard(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color:
                        isComplete
                            ? AppTheme.primaryGold
                            : Colors.grey.withValues(),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    achievement['icon'] as IconData,
                    color: isComplete ? Colors.white : Colors.grey,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        achievement['title'] as String,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color:
                              isComplete
                                  ? AppTheme.primaryGold
                                  : AppTheme.textDark,
                        ),
                      ),
                      Text(
                        achievement['description'] as String,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textLight,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isComplete
                            ? AppTheme.primaryGold.withValues()
                            : Colors.grey.withValues(),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '+${achievement['points']} pts',
                    style: TextStyle(
                      color: isComplete ? AppTheme.primaryGold : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            if (isComplete && achievement.containsKey('completedDate')) ...[
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: AppTheme.primaryGold,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Completed on ${achievement['completedDate']}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.primaryGold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],

            if (isComplete == false) ...[
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: achievement['progress'] as double,
                backgroundColor: Colors.grey.withValues(),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppTheme.primaryGold,
                ),
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(height: 8),
              Text(
                '${((achievement['progress'] as double) * 100).toInt()}% Complete',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppTheme.textLight),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
