import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/peri_card.dart';

class BadgeCard extends StatelessWidget {
  final Map<String, dynamic> badge;

  const BadgeCard({super.key, required this.badge});

  @override
  Widget build(BuildContext context) {
    final isUnlocked = badge['isUnlocked'] == true;

    return PeriCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Badge Icon (using a placeholder in this example)
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color:
                  isUnlocked
                      ? AppTheme.primaryGold.withValues()
                      : Colors.grey.withValues(),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isUnlocked ? Icons.verified : Icons.lock_outline,
              size: 40,
              color: isUnlocked ? AppTheme.primaryGold : Colors.grey,
            ),
          ),

          const SizedBox(height: 16),

          // Badge Title
          Text(
            badge['title'] as String,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isUnlocked ? AppTheme.primaryGold : AppTheme.textDark,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          // Badge Description
          Text(
            badge['description'] as String,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppTheme.textLight),
            textAlign: TextAlign.center,
          ),

          // Progress bar for locked badges
          if (isUnlocked == false && badge.containsKey('progress')) ...[
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: badge['progress'] as double,
              backgroundColor: Colors.grey.withValues(),
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppTheme.primaryGold,
              ),
              minHeight: 4,
              borderRadius: BorderRadius.circular(2),
            ),
            const SizedBox(height: 4),
            Text(
              '${((badge['progress'] as double) * 100).toInt()}%',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppTheme.textLight),
            ),
          ],

          // Level indicator if applicable
          if (badge.containsKey('level')) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color:
                    isUnlocked
                        ? AppTheme.primaryGold.withValues()
                        : Colors.grey.withValues(),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Level ${badge['level']}',
                style: TextStyle(
                  fontSize: 10,
                  color: isUnlocked ? AppTheme.primaryGold : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
