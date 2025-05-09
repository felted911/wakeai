import 'package:flutter/material.dart';
import 'badge_card.dart';
import 'stat_card.dart';

class BadgesTab extends StatelessWidget {
  final List<Map<String, dynamic>> badges;
  final int unlockedCount;

  const BadgesTab({
    super.key,
    required this.badges,
    required this.unlockedCount,
  });

  @override
  Widget build(BuildContext context) {
    final unlockedBadges = badges.where((b) => b['isUnlocked'] == true).toList();
    final lockedBadges = badges.where((b) => b['isUnlocked'] == false).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badge stats
          _buildBadgeStats(context),
          
          const SizedBox(height: 24),
          
          // Unlocked Badges
          if (unlockedBadges.isNotEmpty) ...[
            Text(
              'Unlocked Badges',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildBadgeGrid(context, unlockedBadges),
            
            const SizedBox(height: 24),
          ],
          
          // Locked Badges
          if (lockedBadges.isNotEmpty) ...[
            Text(
              'Badges to Unlock',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildBadgeGrid(context, lockedBadges),
          ],
        ],
      ),
    );
  }

  Widget _buildBadgeStats(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        StatCard(
          title: 'Unlocked',
          value: '$unlockedCount/${badges.length}',
          icon: Icons.verified,
          width: 100.0,
        ),
        StatCard(
          title: 'Level',
          value: '5',
          icon: Icons.trending_up,
          width: 100.0,
        ),
        StatCard(
          title: 'Next Badge',
          value: 'Silver',
          icon: Icons.military_tech,
          width: 100.0,
        ),
      ],
    );
  }

  Widget _buildBadgeGrid(BuildContext context, List<Map<String, dynamic>> badgeList) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: badgeList.length,
      itemBuilder: (context, index) {
        return BadgeCard(badge: badgeList[index]);
      },
    );
  }
}
