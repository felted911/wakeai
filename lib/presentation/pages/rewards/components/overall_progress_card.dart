import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/peri_card.dart';
import 'mini_stat_card.dart';

class OverallProgressCard extends StatelessWidget {
  final String routinesCount;
  final String streakDays;
  final String perfectDays;
  final int currentLevel;
  final int currentXp;
  final int targetXp;

  const OverallProgressCard({
    super.key,
    required this.routinesCount,
    required this.streakDays,
    required this.perfectDays,
    required this.currentLevel,
    required this.currentXp,
    required this.targetXp,
  });

  @override
  Widget build(BuildContext context) {
    return PeriCard(
      child: Column(
        children: [
          Text(
            'Your Morning Journey',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 24),

          // Level Progress
          Row(
            children: [
              Text(
                'Level $currentLevel',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryGold,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    LinearProgressIndicator(
                      value: currentXp / targetXp,
                      backgroundColor: Colors.grey.withValues(),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppTheme.primaryGold,
                      ),
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$currentXp/$targetXp XP to Level ${currentLevel + 1}',
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

          // Key Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MiniStatCard(
                icon: Icons.check_circle_outline,
                value: routinesCount,
                label: 'Routines',
              ),
              MiniStatCard(
                icon: Icons.local_fire_department_outlined,
                value: streakDays,
                label: 'Day Streak',
              ),
              MiniStatCard(
                icon: Icons.star_outline,
                value: perfectDays,
                label: 'Perfect Days',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
