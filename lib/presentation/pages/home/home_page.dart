import 'package:flutter/material.dart';
import '../../widgets/peri_button.dart';
import '../../widgets/peri_card.dart';
import '../../theme/app_theme.dart';
import '../../routes/app_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top section with greeting and profile
              _buildTopSection(context),

              // Alarm card
              _buildAlarmCard(context),

              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Your Routine Section
                    _buildSectionHeader(context, 'Your Morning Routine'),
                    const SizedBox(height: 16),
                    _buildRoutinePreview(context),

                    const SizedBox(height: 32),

                    // Progress Section
                    _buildSectionHeader(context, 'Weekly Progress'),
                    const SizedBox(height: 16),
                    _buildProgressCard(context),

                    const SizedBox(height: 32),

                    // Quick Actions
                    _buildSectionHeader(context, 'Quick Actions'),
                    const SizedBox(height: 16),
                    _buildQuickActions(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: AppTheme.primaryGold,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm_outlined),
            activeIcon: Icon(Icons.alarm),
            label: 'Alarm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            activeIcon: Icon(Icons.list_alt),
            label: 'Routine',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights_outlined),
            activeIcon: Icon(Icons.insights),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          // Navigation based on index would go here
          switch (index) {
            case 0: // Home - already here
              break;
            case 1: // Alarm
              Navigator.of(context).pushNamed(AppRouter.alarmSetup);
              break;
            case 2: // Routine
              Navigator.of(context).pushNamed(AppRouter.routineEditor);
              break;
            case 3: // Progress
              Navigator.of(context).pushNamed(AppRouter.progressTracking);
              break;
            case 4: // Settings
              Navigator.of(context).pushNamed(AppRouter.settings);
              break;
          }
        },
      ),
    );
  }

  Widget _buildTopSection(BuildContext context) {
    // Get current time of day
    final hour = DateTime.now().hour;
    String greeting;

    if (hour < 12) {
      greeting = 'Good Morning';
    } else if (hour < 17) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryGold.withValues(),
            AppTheme.primaryGold.withValues(),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Mark', // This would be the user's name in a real app
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // Profile picture placeholder
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white.withValues(),
            child: const Icon(Icons.person, size: 32, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildAlarmCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      color: AppTheme.primaryGold.withValues(),
      child: PeriCard(
        onTap: () {
          Navigator.of(context).pushNamed(AppRouter.alarmSetup);
        },
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppTheme.primaryGold.withValues(),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.alarm,
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
                    'Next Alarm',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '7:00 AM', // This would be dynamic in a real app
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Mon, Tue, Wed, Thu, Fri', // This would be dynamic in a real app
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppTheme.textLight),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppTheme.primaryGold.withValues(),
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.edit_outlined,
                  color: AppTheme.primaryGold,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRouter.alarmSetup);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            // This would navigate to the specific section in a real app
          },
          child: const Text(
            'See All',
            style: TextStyle(
              color: AppTheme.primaryGold,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRoutinePreview(BuildContext context) {
    final routineActivities = [
      {
        'title': 'Drink Water',
        'icon': Icons.water_drop_outlined,
        'duration': '1 min',
      },
      {
        'title': 'Morning Stretches',
        'icon': Icons.fitness_center_outlined,
        'duration': '5 min',
      },
      {
        'title': 'Brush Teeth',
        'icon': Icons.brush_outlined,
        'duration': '2 min',
      },
      {'title': 'Make Bed', 'icon': Icons.bed_outlined, 'duration': '2 min'},
    ];

    return PeriCard(
      onTap: () {
        Navigator.of(context).pushNamed(AppRouter.routineEditor);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Daily Routine',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                '10 minutes total', // This would be dynamic in a real app
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppTheme.textLight),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...routineActivities.map(
            (activity) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGold.withValues(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      activity['icon'] as IconData,
                      color: AppTheme.primaryGold,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      activity['title'] as String,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Text(
                    activity['duration'] as String,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppTheme.textLight),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: PeriButton(
              text: 'Start Routine',
              onPressed: () {
                //Navigator.of(context).pushNamed(AppRouter.routineGuidance);
              },
              type: PeriButtonType.secondary,
              icon: Icons.play_arrow_rounded,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(BuildContext context) {
    // This would contain a chart in a real app
    return PeriCard(
      onTap: () {
        Navigator.of(context).pushNamed(AppRouter.progressTracking);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Progress',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.bar_chart, size: 48, color: Colors.grey),
                  const SizedBox(height: 8),
                  Text(
                    'Progress Chart',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Chart visualization will be here',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatCard(context, '5', 'Day Streak'),
              _buildStatCard(context, '80%', 'Completion Rate'),
              _buildStatCard(context, '23', 'Rewards Earned'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String value, String label) {
    return Expanded(
      child: Card(
        elevation: 0,
        color: AppTheme.primaryGold.withValues(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryGold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppTheme.textLight),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionButton(
          context,
          Icons.edit_outlined,
          'Edit Routine',
          () => Navigator.of(context).pushNamed(AppRouter.routineEditor),
        ),
        _buildActionButton(
          context,
          Icons.alarm_outlined,
          'Set Alarm',
          () => Navigator.of(context).pushNamed(AppRouter.alarmSetup),
        ),
        _buildActionButton(
          context,
          Icons.emoji_events_outlined,
          'Rewards',
          () => Navigator.of(context).pushNamed(AppRouter.rewards),
        ),
        _buildActionButton(
          context,
          Icons.settings_outlined,
          'Settings',
          () => Navigator.of(context).pushNamed(AppRouter.settings),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onPressed,
  ) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppTheme.primaryGold.withValues(),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: AppTheme.primaryGold),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
