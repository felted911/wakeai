import 'package:flutter/material.dart';
import '../../widgets/peri_app_bar.dart';
import '../../widgets/peri_card.dart';
import '../../theme/app_theme.dart';
//import '../../../core/util/color_extensions.dart';

class ProgressTrackingPage extends StatefulWidget {
  const ProgressTrackingPage({super.key});

  @override
  State<ProgressTrackingPage> createState() => _ProgressTrackingPageState();
}

class _ProgressTrackingPageState extends State<ProgressTrackingPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabTitles = ['Daily', 'Weekly', 'Monthly'];

  // Sample data - in a real app, this would come from your database
  final Map<String, List<double>> _completionRates = {
    'daily': [0.8, 0.6, 1.0, 0.9, 0.7, 0.5, 1.0],
    'weekly': [0.75, 0.82, 0.68, 0.9],
    'monthly': [0.7, 0.65, 0.8, 0.82, 0.85, 0.88],
  };

  final List<Map<String, dynamic>> _achievements = [
    {
      'title': 'Early Bird',
      'description': 'Complete your routine before 8 AM for 5 days',
      'progress': 0.6, // 3 out of 5 days
      'icon': Icons.wb_sunny_outlined,
      'isComplete': false,
    },
    {
      'title': 'Consistency Champion',
      'description': 'Complete your full routine for 7 days in a row',
      'progress': 0.71, // 5 out of 7 days
      'icon': Icons.calendar_today_outlined,
      'isComplete': false,
    },
    {
      'title': 'Hydration Hero',
      'description': 'Start your day with water for 10 days',
      'progress': 1.0, // 10 out of 10 days
      'icon': Icons.water_drop_outlined,
      'isComplete': true,
    },
    {
      'title': 'Stretching Star',
      'description': 'Complete morning stretches for 14 days',
      'progress': 0.5, // 7 out of 14 days
      'icon': Icons.fitness_center_outlined,
      'isComplete': false,
    },
  ];

  final Map<String, List<String>> _streakData = {
    'current': ['5', 'days', 'Current streak'],
    'longest': ['12', 'days', 'Longest streak'],
    'total': ['23', 'days', 'Total days'],
  };

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
      appBar: const PeriAppBar(title: 'Progress Tracker', showBackButton: true),
      body: Column(
        children: [
          // Tab Bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(),
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
                _buildDailyView(),
                _buildWeeklyView(),
                _buildMonthlyView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Streak Cards
          _buildStreakSection(),

          const SizedBox(height: 32),

          // Daily Completion Chart
          _buildSectionHeader('This Week'),
          const SizedBox(height: 16),
          _buildCompletionChart('daily'),

          const SizedBox(height: 32),

          // Daily Stats
          _buildSectionHeader('Today\'s Stats'),
          const SizedBox(height: 16),
          _buildTodayStats(),

          const SizedBox(height: 32),

          // Achievements
          _buildSectionHeader('Achievements'),
          const SizedBox(height: 16),
          _buildAchievements(),
        ],
      ),
    );
  }

  Widget _buildWeeklyView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Streak Cards
          _buildStreakSection(),

          const SizedBox(height: 32),

          // Weekly Completion Chart
          _buildSectionHeader('Last 4 Weeks'),
          const SizedBox(height: 16),
          _buildCompletionChart('weekly'),

          const SizedBox(height: 32),

          // Weekly Stats
          _buildSectionHeader('This Week\'s Stats'),
          const SizedBox(height: 16),
          _buildWeeklyStats(),

          const SizedBox(height: 32),

          // Achievements
          _buildSectionHeader('Achievements'),
          const SizedBox(height: 16),
          _buildAchievements(),
        ],
      ),
    );
  }

  Widget _buildMonthlyView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Streak Cards
          _buildStreakSection(),

          const SizedBox(height: 32),

          // Monthly Completion Chart
          _buildSectionHeader('Last 6 Months'),
          const SizedBox(height: 16),
          _buildCompletionChart('monthly'),

          const SizedBox(height: 32),

          // Monthly Stats
          _buildSectionHeader('This Month\'s Stats'),
          const SizedBox(height: 16),
          _buildMonthlyStats(),

          const SizedBox(height: 32),

          // Achievements
          _buildSectionHeader('Achievements'),
          const SizedBox(height: 16),
          _buildAchievements(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildStreakSection() {
    return Row(
      children:
          _streakData.entries.map((entry) {
            final data = entry.value;
            return Expanded(
              child: PeriCard(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 8,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data[0],
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryGold,
                      ),
                    ),
                    Text(data[1], style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(height: 4),
                    Text(
                      data[2],
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textLight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildCompletionChart(String period) {
    // Simple placeholder chart
    // In a real app, you'd use a chart library like fl_chart or charts_flutter
    final completionRates = _completionRates[period]!;

    return PeriCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Routine Completion Rate',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 180,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(completionRates.length, (index) {
                final height = completionRates[index] * 150;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 24,
                      height: height,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGold.withValues(),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getChartLabel(period, index),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  String _getChartLabel(String period, int index) {
    switch (period) {
      case 'daily':
        final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        return days[index];
      case 'weekly':
        return 'W${index + 1}';
      case 'monthly':
        final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
        return months[index];
      default:
        return '';
    }
  }

  Widget _buildTodayStats() {
    final stats = [
      {'label': 'Completion Rate', 'value': '85%'},
      {'label': 'Start Time', 'value': '7:15 AM'},
      {'label': 'Total Duration', 'value': '15 min'},
      {'label': 'Steps', 'value': '4/5'},
    ];

    return _buildStatsGrid(stats);
  }

  Widget _buildWeeklyStats() {
    final stats = [
      {'label': 'Avg. Completion', 'value': '78%'},
      {'label': 'Avg. Start Time', 'value': '7:25 AM'},
      {'label': 'Most Skipped', 'value': 'Meditation'},
      {'label': 'Perfect Days', 'value': '3/7'},
    ];

    return _buildStatsGrid(stats);
  }

  Widget _buildMonthlyStats() {
    final stats = [
      {'label': 'Avg. Completion', 'value': '82%'},
      {'label': 'Best Week', 'value': 'Week 3'},
      {'label': 'Perfect Days', 'value': '12/30'},
      {'label': 'Total Time', 'value': '7.5 hrs'},
    ];

    return _buildStatsGrid(stats);
  }

  Widget _buildStatsGrid(List<Map<String, String>> stats) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final stat = stats[index];
        return PeriCard(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                stat['value']!,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryGold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                stat['label']!,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppTheme.textLight),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAchievements() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _achievements.length,
      itemBuilder: (context, index) {
        final achievement = _achievements[index];
        final isComplete = achievement['isComplete'] as bool;
        final progress = achievement['progress'] as double;

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
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppTheme.textLight),
                          ),
                        ],
                      ),
                    ),
                    if (isComplete)
                      const Icon(Icons.verified, color: AppTheme.primaryGold),
                  ],
                ),

                if (!isComplete) ...[
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey.withValues(),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppTheme.primaryGold,
                    ),
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${(progress * 100).toInt()}% Complete',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppTheme.textLight),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
