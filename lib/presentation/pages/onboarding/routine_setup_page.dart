import 'package:flutter/material.dart';
import '../../widgets/peri_button.dart';
import '../../widgets/peri_app_bar.dart';
import '../../widgets/peri_card.dart';
import '../../theme/app_theme.dart';
import '../../routes/app_router.dart';

class RoutineSetupPage extends StatefulWidget {
  const RoutineSetupPage({super.key});

  @override
  State<RoutineSetupPage> createState() => _RoutineSetupPageState();
}

class _RoutineSetupPageState extends State<RoutineSetupPage> {
  final List<Map<String, dynamic>> _availableActivities = [
    {
      'id': 1,
      'title': 'Drink Water',
      'icon': Icons.water_drop_outlined,
      'duration': '1 min',
      'isSelected': true,
    },
    {
      'id': 2,
      'title': 'Morning Stretches',
      'icon': Icons.fitness_center_outlined,
      'duration': '5 min',
      'isSelected': true,
    },
    {
      'id': 3,
      'title': 'Meditation',
      'icon': Icons.self_improvement_outlined,
      'duration': '5-10 min',
      'isSelected': false,
    },
    {
      'id': 4,
      'title': 'Brush Teeth',
      'icon': Icons.brush_outlined,
      'duration': '2 min',
      'isSelected': true,
    },
    {
      'id': 5,
      'title': 'Make Bed',
      'icon': Icons.bed_outlined,
      'duration': '2 min',
      'isSelected': true,
    },
    {
      'id': 6,
      'title': 'Shower',
      'icon': Icons.shower_outlined,
      'duration': '5-10 min',
      'isSelected': false,
    },
    {
      'id': 7,
      'title': 'Breakfast',
      'icon': Icons.restaurant_outlined,
      'duration': '15 min',
      'isSelected': false,
    },
    {
      'id': 8,
      'title': 'Journal',
      'icon': Icons.edit_note_outlined,
      'duration': '5 min',
      'isSelected': false,
    },
  ];

  List<Map<String, dynamic>> get _selectedActivities {
    return _availableActivities
        .where((activity) => activity['isSelected'] == true)
        .toList();
  }

  int get _totalMinutes {
    int total = 0;
    for (final activity in _selectedActivities) {
      final duration = activity['duration'] as String;
      if (duration.contains('-')) {
        // Take the average if it's a range
        final parts = duration.split('-');
        final min = int.parse(parts[0].trim());
        final max = int.parse(parts[1].trim().split(' ')[0]);
        total += (min + max) ~/ 2;
      } else {
        total += int.parse(duration.split(' ')[0]);
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceWhite,
      appBar: const PeriAppBar(
        title: 'Create Your Routine',
        showBackButton: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select activities for your morning routine',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                        size: 18,
                        color: AppTheme.textLight,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Estimated time: $_totalMinutes minutes',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textLight,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),

            // Activities List
            Expanded(
              child: ReorderableListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: _availableActivities.length,
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    final item = _availableActivities.removeAt(oldIndex);
                    _availableActivities.insert(newIndex, item);
                  });
                },
                itemBuilder: (context, index) {
                  final activity = _availableActivities[index];
                  final isSelected = activity['isSelected'] as bool;

                  return Padding(
                    key: Key('${activity['id']}'),
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildActivityCard(activity, isSelected),
                  );
                },
              ),
            ),

            // Bottom Buttons
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Add Custom Activity Button (not functional in this version)
                  PeriButton(
                    text: 'Add Custom Activity',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Custom activity creation will be available in the next version',
                          ),
                        ),
                      );
                    },
                    type: PeriButtonType.secondary,
                    icon: Icons.add,
                    isFullWidth: true,
                  ),

                  const SizedBox(height: 16),

                  // Complete Setup Button
                  PeriButton(
                    text: 'Complete Setup',
                    onPressed: () {
                      if (_selectedActivities.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please select at least one activity',
                            ),
                          ),
                        );
                        return;
                      }
                      Navigator.of(context).pushNamed(AppRouter.home);
                    },
                    isFullWidth: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity, bool isSelected) {
    return PeriCard(
      elevation: 2,
      backgroundColor: isSelected ? Colors.white : Colors.grey[100],
      child: Row(
        children: [
          // Drag Handle
          const Icon(Icons.drag_handle_rounded, color: Colors.grey),

          const SizedBox(width: 12),

          // Activity Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color:
                  isSelected
                      ? AppTheme.primaryGold.withValues()
                      : Colors.grey.withValues(),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              activity['icon'] as IconData,
              color: isSelected ? AppTheme.primaryGold : Colors.grey,
            ),
          ),

          const SizedBox(width: 16),

          // Activity Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['title'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? AppTheme.textDark : Colors.grey,
                  ),
                ),
                Text(
                  activity['duration'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected ? AppTheme.textLight : Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Checkbox
          Switch(
            value: isSelected,
            activeColor: AppTheme.primaryGold,
            onChanged: (value) {
              setState(() {
                activity['isSelected'] = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
