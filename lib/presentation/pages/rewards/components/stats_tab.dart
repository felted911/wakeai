import 'package:flutter/material.dart';
//import '../../../theme/app_theme.dart';
import '../../../widgets/peri_card.dart';
import 'overall_progress_card.dart';

class StatsTab extends StatelessWidget {
  final Map<String, String> stats;

  const StatsTab({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overall Progress Card
          OverallProgressCard(
            routinesCount: stats['Completed Routines'] ?? '0',
            streakDays: stats['Current Streak']?.split(' ')[0] ?? '0',
            perfectDays: stats['Perfect Days'] ?? '0',
            currentLevel: int.parse(stats['Level'] ?? '1'),
            currentXp: 350, // This would come from a real data source
            targetXp: 500, // This would come from a real data source
          ),

          const SizedBox(height: 32),

          // Stats List
          _buildStatsList(context),
        ],
      ),
    );
  }

  Widget _buildStatsList(BuildContext context) {
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
            itemCount: stats.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final entry = stats.entries.elementAt(index);
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
