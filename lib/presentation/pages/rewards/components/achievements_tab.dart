import 'package:flutter/material.dart';
import 'achievement_card.dart';
import 'stat_card.dart';

class AchievementsTab extends StatelessWidget {
  final List<Map<String, dynamic>> achievements;
  final int completedCount;
  final int totalPoints;

  const AchievementsTab({
    super.key,
    required this.achievements,
    required this.completedCount,
    required this.totalPoints,
  });

  @override
  Widget build(BuildContext context) {
    final inProgressAchievements = achievements.where((a) => a['isComplete'] == false).toList();
    final completedAchievements = achievements.where((a) => a['isComplete'] == true).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Achievement stats
          _buildAchievementStats(context),
          
          const SizedBox(height: 24),
          
          // In Progress Achievements
          if (inProgressAchievements.isNotEmpty) ...[
            Text(
              'In Progress',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...inProgressAchievements.map((a) => AchievementCard(achievement: a)),
            
            const SizedBox(height: 24),
          ],
          
          // Completed Achievements
          if (completedAchievements.isNotEmpty) ...[
            Text(
              'Completed',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...completedAchievements.map((a) => AchievementCard(achievement: a)),
          ],
        ],
      ),
    );
  }

  Widget _buildAchievementStats(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        StatCard(
          title: 'Completed',
          value: '$completedCount/${achievements.length}',
          icon: Icons.task_alt,
          width: 100.0,
        ),
        StatCard(
          title: 'In Progress',
          value: '${achievements.length - completedCount}',
          icon: Icons.pending_actions,
          width: 100.0,
        ),
        StatCard(
          title: 'Points Earned',
          value: '$totalPoints',
          icon: Icons.star,
          width: 100.0,
        ),
      ],
    );
  }
}
