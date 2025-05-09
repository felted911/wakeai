import 'package:flutter/material.dart';
import '../../widgets/peri_app_bar.dart';
import '../../widgets/peri_card.dart';
import '../../widgets/peri_button.dart';
import '../../theme/app_theme.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({super.key});

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabTitles = ['Achievements', 'Badges', 'Stats'];

  // Sample data for achievements
  final List<Map<String, dynamic>> _achievements = [
    {
      'id': 1,
      'title': 'Early Bird',
      'description': 'Complete your routine before 8 AM for 5 days',
      'progress': 0.6, // 3 out of 5 days
      'icon': Icons.wb_sunny_outlined,
      'isComplete': false,
      'points': 50,
    },
    {
      'id': 2,
      'title': 'Consistency Champion',
      'description': 'Complete your full routine for 7 days in a row',
      'progress': 0.71, // 5 out of 7 days
      'icon': Icons.calendar_today_outlined,
      'isComplete': false,
      'points': 100,
    },
    {
      'id': 3,
      'title': 'Hydration Hero',
      'description': 'Start your day with water for 10 days',
      'progress': 1.0, // 10 out of 10 days
      'icon': Icons.water_drop_outlined,
      'isComplete': true,
      'points': 70,
      'completedDate': 'May 5, 2025',
    },
    {
      'id': 4,
      'title': 'Stretching Star',
      'description': 'Complete morning stretches for 14 days',
      'progress': 0.5, // 7 out of 14 days
      'icon': Icons.fitness_center_outlined,
      'isComplete': false,
      'points': 120,
    },
    {
      'id': 5,
      'title': 'Meditation Master',
      'description': 'Include meditation in your routine for 20 days',
      'progress': 0.3, // 6 out of 20 days
      'icon': Icons.self_improvement_outlined,
      'isComplete': false,
      'points': 150,
    },
    {
      'id': 6,
      'title': 'Perfect Week',
      'description': 'Complete 100% of your routine every day for a week',
      'progress': 1.0, // 7 out of 7 days
      'icon': Icons.star_outline,
      'isComplete': true,
      'points': 200,
      'completedDate': 'Apr 28, 2025',
    },
  ];

  // Sample data for badges
  final List<Map<String, dynamic>> _badges = [
    {
      'id': 1,
      'title': 'Bronze Morning Person',
      'description': 'Complete 30 morning routines',
      'icon':
          'assets/images/badges/bronze_badge.png', // This would be a real asset in a real app
      'isUnlocked': true,
      'level': 1,
    },
    {
      'id': 2,
      'title': 'Silver Morning Person',
      'description': 'Complete 60 morning routines',
      'icon': 'assets/images/badges/silver_badge.png',
      'isUnlocked': false,
      'level': 2,
      'progress': 0.45, // 27 out of 60
    },
    {
      'id': 3,
      'title': 'Gold Morning Person',
      'description': 'Complete 100 morning routines',
      'icon': 'assets/images/badges/gold_badge.png',
      'isUnlocked': false,
      'level': 3,
      'progress': 0.27, // 27 out of 100
    },
    {
      'id': 4,
      'title': 'Mindfulness Novice',
      'description': 'Include meditation in your routine 15 times',
      'icon': 'assets/images/badges/meditation_novice.png',
      'isUnlocked': false,
      'level': 1,
      'progress': 0.4, // 6 out of 15
    },
    {
      'id': 5,
      'title': 'Streak Starter',
      'description': 'Maintain a 7-day streak',
      'icon': 'assets/images/badges/streak_starter.png',
      'isUnlocked': true,
      'level': 1,
    },
    {
      'id': 6,
      'title': 'Streak Master',
      'description': 'Maintain a 30-day streak',
      'icon': 'assets/images/badges/streak_master.png',
      'isUnlocked': false,
      'level': 2,
      'progress': 0.17, // 5 out of 30
    },
  ];

  // Stats
  final Map<String, String> _stats = {
    'Total Points': '520',
    'Completed Routines': '27',
    'Perfect Days': '14',
    'Current Streak': '5 days',
    'Longest Streak': '12 days',
    'Total Activities': '108',
    'Most Consistent': 'Drinking Water',
    'Most Skipped': 'Meditation',
    'Average Start Time': '7:23 AM',
    'Level': '5',
  };

  int get _totalPoints {
    int total = 0;
    for (final achievement in _achievements) {
      if (achievement['isComplete'] == true) {
        total += achievement['points'] as int;
      }
    }
    return total;
  }

  int get _completedAchievements {
    return _achievements.where((a) => a['isComplete'] == true).length;
  }

  int get _unlockedBadges {
    return _badges.where((b) => b['isUnlocked'] == true).length;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabTitles.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceWhite,
      appBar: const PeriAppBar(
        title: 'Rewards & Achievements',
        showBackButton: true,
      ),
      body: Column(
        children: [
          // Point summary
          _buildPointsSummary(),

          // Tab Bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(13),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              tabs: _tabTitles.map((title) => Tab(text: title)).toList(),
              labelColor: AppTheme.primaryGold,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppTheme.primaryGold,
              indicatorWeight: 3,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Nunito',
              ),
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAchievementsTab(),
                _buildBadgesTab(),
                _buildStatsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointsSummary() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryGold.withAlpha(204),
            AppTheme.primaryGold.withAlpha(153),
          ],
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(51),
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
                  _totalPoints.toString(),
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Reward Points',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white.withAlpha(204),
                  ),
                ),
              ],
            ),
          ),
          PeriButton(
            text: 'Redeem',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Reward redemption will be available in a future update',
                  ),
                ),
              );
            },
            type: PeriButtonType.secondary,
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Achievement stats
          _buildAchievementStats(),

          const SizedBox(height: 24),

          // In Progress Achievements
          if (_achievements.any((a) => a['isComplete'] == false)) ...[
            Text(
              'In Progress',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ..._achievements
                .where((a) => a['isComplete'] == false)
                .map((a) => _buildAchievementCard(a)),

            const SizedBox(height: 24),
          ],

          // Completed Achievements
          if (_achievements.any((a) => a['isComplete'] == true)) ...[
            Text(
              'Completed',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ..._achievements
                .where((a) => a['isComplete'] == true)
                .map((a) => _buildAchievementCard(a)),
          ],
        ],
      ),
    );
  }

  Widget _buildAchievementStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatCard(
          title: 'Completed',
          value: '$_completedAchievements/${_achievements.length}',
          icon: Icons.task_alt,
          width: 100.0,
        ),
        _buildStatCard(
          title: 'In Progress',
          value: '${_achievements.length - _completedAchievements}',
          icon: Icons.pending_actions,
          width: 100.0,
        ),
        _buildStatCard(
          title: 'Points Earned',
          value: '$_totalPoints',
          icon: Icons.star,
          width: 100.0,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    Key? key,
    double width = 100.0,
    required String title,
    required String value,
    required IconData icon,
  }) {
    return PeriCard(
      key: key,
      padding: const EdgeInsets.all(16),
      width: width,
      child: Column(
        children: [
          Icon(icon, color: AppTheme.primaryGold, size: 32),
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
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppTheme.textLight),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(Map<String, dynamic> achievement) {
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
                            : Colors.grey.withAlpha(26),
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
                            ? AppTheme.primaryGold.withAlpha(26)
                            : Colors.grey.withAlpha(26),
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
                backgroundColor: Colors.grey.withAlpha(51),
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

  Widget _buildBadgesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badge stats
          _buildBadgeStats(),

          const SizedBox(height: 24),

          // Unlocked Badges
          if (_badges.any((b) => b['isUnlocked'] == true)) ...[
            Text(
              'Unlocked Badges',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildBadgeGrid(
              _badges.where((b) => b['isUnlocked'] == true).toList(),
            ),

            const SizedBox(height: 24),
          ],

          // Locked Badges
          if (_badges.any((b) => b['isUnlocked'] == false)) ...[
            Text(
              'Badges to Unlock',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildBadgeGrid(
              _badges.where((b) => b['isUnlocked'] == false).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBadgeStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatCard(
          title: 'Unlocked',
          value: '$_unlockedBadges/${_badges.length}',
          icon: Icons.verified,
          width: 100.0,
        ),
        _buildStatCard(
          title: 'Level',
          value: '5',
          icon: Icons.trending_up,
          width: 100.0,
        ),
        _buildStatCard(
          title: 'Next Badge',
          value: 'Silver',
          icon: Icons.military_tech,
          width: 100.0,
        ),
      ],
    );
  }

  Widget _buildBadgeGrid(List<Map<String, dynamic>> badges) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: badges.length,
      itemBuilder: (context, index) {
        final badge = badges[index];
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
                          ? AppTheme.primaryGold.withAlpha(26)
                          : Colors.grey.withAlpha(26),
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
                  backgroundColor: Colors.grey.withAlpha(51),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isUnlocked
                            ? AppTheme.primaryGold.withAlpha(26)
                            : Colors.grey.withAlpha(26),
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
      },
    );
  }

  Widget _buildStatsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overall Progress Card
          _buildOverallProgressCard(),

          const SizedBox(height: 32),

          // Stats
          _buildStatsList(),
        ],
      ),
    );
  }

  Widget _buildOverallProgressCard() {
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
                'Level 5',
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
                      value: 0.7,
                      backgroundColor: Colors.grey.withAlpha(51),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppTheme.primaryGold,
                      ),
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '350/500 XP to Level 6',
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
              _buildMiniStatCard(
                key: UniqueKey(),
                icon: Icons.check_circle_outline,
                value: '27',
                label: 'Routines',
              ),
              _buildMiniStatCard(
                key: UniqueKey(),
                icon: Icons.local_fire_department_outlined,
                value: '5',
                label: 'Day Streak',
              ),
              _buildMiniStatCard(
                key: UniqueKey(),
                icon: Icons.star_outline,
                value: '14',
                label: 'Perfect Days',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStatCard({
    Key? key,
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppTheme.primaryGold.withAlpha(26),
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

  Widget _buildStatsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detailed Stats',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 16),

        PeriCard(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _stats.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final entry = _stats.entries.elementAt(index);
              return ListTile(
                title: Text(entry.key),
                trailing: Text(
                  entry.value,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
