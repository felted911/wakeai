import 'package:flutter/material.dart';
import '../../widgets/peri_button.dart';
import '../../widgets/peri_app_bar.dart';
import '../../widgets/peri_card.dart';
import '../../theme/app_theme.dart';
//import '../../routes/app_router.dart';
import '../../../core/util/color_extensions.dart';

class RoutineEditorPage extends StatefulWidget {
  const RoutineEditorPage({super.key});

  @override
  State<RoutineEditorPage> createState() => _RoutineEditorPageState();
}

class _RoutineEditorPageState extends State<RoutineEditorPage> {
  final List<Map<String, dynamic>> _routineActivities = [
    {
      'id': 1,
      'title': 'Drink Water',
      'icon': Icons.water_drop_outlined,
      'duration': 60, // seconds
      'active': true,
    },
    {
      'id': 2,
      'title': 'Morning Stretches',
      'icon': Icons.fitness_center_outlined,
      'duration': 300, // 5 minutes
      'active': true,
    },
    {
      'id': 3,
      'title': 'Brush Teeth',
      'icon': Icons.brush_outlined,
      'duration': 120, // 2 minutes
      'active': true,
    },
    {
      'id': 4,
      'title': 'Make Bed',
      'icon': Icons.bed_outlined,
      'duration': 120, // 2 minutes
      'active': true,
    },
  ];

  final List<Map<String, dynamic>> _recommendedActivities = [
    {
      'id': 101,
      'title': 'Meditation',
      'icon': Icons.self_improvement_outlined,
      'duration': 300, // 5 minutes
      'active': false,
    },
    {
      'id': 102,
      'title': 'Journal',
      'icon': Icons.edit_note_outlined,
      'duration': 300, // 5 minutes
      'active': false,
    },
    {
      'id': 103,
      'title': 'Quick Workout',
      'icon': Icons.fitness_center_outlined,
      'duration': 600, // 10 minutes
      'active': false,
    },
  ];

  int get _totalDuration {
    int total = 0;
    for (final activity in _routineActivities) {
      if (activity['active'] == true) {
        total += activity['duration'] as int;
      }
    }
    return total;
  }

  String get _formattedTotalDuration {
    final minutes = _totalDuration ~/ 60;
    return '$minutes minutes';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceWhite,
      appBar: const PeriAppBar(
        title: 'Edit Morning Routine',
        showBackButton: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Total duration display
            Container(
              padding: const EdgeInsets.all(16.0),
              color: AppTheme.primaryGold.withAlphaValue(0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.timer_outlined, color: AppTheme.primaryGold),
                  const SizedBox(width: 8),
                  Text(
                    'Total Duration: $_formattedTotalDuration',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryGold,
                    ),
                  ),
                ],
              ),
            ),

            // Routine activities list
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Routine',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    // Reorderable list of activities
                    _buildActivitiesList(),

                    const SizedBox(height: 32),

                    // Recommended activities section
                    Text(
                      'Recommended Activities',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add these activities to enhance your morning routine',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textLight,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Recommended activities list
                    _buildRecommendedActivities(),

                    const SizedBox(height: 32),

                    // Custom activity button
                    _buildCustomActivityButton(),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Bottom save button
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlphaValue(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: PeriButton(
                text: 'Save Changes',
                onPressed: _saveChanges,
                isFullWidth: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivitiesList() {
    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _routineActivities.length,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final item = _routineActivities.removeAt(oldIndex);
          _routineActivities.insert(newIndex, item);
        });
      },
      itemBuilder: (context, index) {
        final activity = _routineActivities[index];
        return _buildActivityCard(
          activity,
          index,
          key: Key(activity['id'].toString()),
          showDragHandle: true,
          onToggle: (value) {
            setState(() {
              activity['active'] = value;
            });
          },
          onEdit: () => _editActivity(activity),
          onDelete: () => _deleteActivity(index),
        );
      },
    );
  }

  Widget _buildRecommendedActivities() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _recommendedActivities.length,
      itemBuilder: (context, index) {
        final activity = _recommendedActivities[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: PeriCard(
            elevation: 2,
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlphaValue(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    activity['icon'] as IconData,
                    color: AppTheme.textLight,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity['title'] as String,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _formatDuration(activity['duration'] as int),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textLight,
                        ),
                      ),
                    ],
                  ),
                ),
                PeriButton(
                  text: 'Add',
                  onPressed: () => _addRecommendedActivity(activity),
                  type: PeriButtonType.secondary,
                  icon: Icons.add,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCustomActivityButton() {
    return PeriCard(
      onTap: _addCustomActivity,
      backgroundColor: AppTheme.primaryGold.withAlphaValue(0.05),
      borderRadius: 16,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppTheme.primaryGold.withAlphaValue(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: AppTheme.primaryGold,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Add Custom Activity',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryGold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Create an activity that fits your needs',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppTheme.textLight),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityCard(
    Map<String, dynamic> activity,
    int index, {
    required Key key,
    bool showDragHandle = false,
    required Function(bool) onToggle,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    final isActive = activity['active'] as bool;

    return Padding(
      key: key,
      padding: const EdgeInsets.only(bottom: 12),
      child: Dismissible(
        key: Key('dismiss-${activity['id']}'),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        onDismissed: (direction) {
          onDelete();
        },
        child: PeriCard(
          elevation: 2,
          backgroundColor: isActive ? Colors.white : Colors.grey[100],
          child: Row(
            children: [
              // Drag Handle
              if (showDragHandle)
                const Icon(Icons.drag_handle_rounded, color: Colors.grey),

              // Activity Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color:
                      isActive
                          ? AppTheme.primaryGold.withAlphaValue(0.1)
                          : Colors.grey.withAlphaValue(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  activity['icon'] as IconData,
                  color: isActive ? AppTheme.primaryGold : Colors.grey,
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
                        color: isActive ? AppTheme.textDark : Colors.grey,
                      ),
                    ),
                    Text(
                      _formatDuration(activity['duration'] as int),
                      style: TextStyle(
                        fontSize: 12,
                        color: isActive ? AppTheme.textLight : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              // Edit Button
              IconButton(
                icon: Icon(
                  Icons.edit_outlined,
                  color: isActive ? AppTheme.primaryGold : Colors.grey,
                  size: 20,
                ),
                onPressed: onEdit,
              ),

              // Active Toggle
              Switch(
                value: isActive,
                activeColor: AppTheme.primaryGold,
                onChanged: onToggle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editActivity(Map<String, dynamic> activity) {
    // Show dialog to edit the activity
    _showActivityDialog(
      title: 'Edit Activity',
      activity: Map<String, dynamic>.from(activity),
      onSave: (editedActivity) {
        setState(() {
          final index = _routineActivities.indexWhere(
            (a) => a['id'] == activity['id'],
          );
          if (index != -1) {
            _routineActivities[index] = editedActivity;
          }
        });
      },
    );
  }

  void _deleteActivity(int index) {
    setState(() {
      _routineActivities.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Activity removed'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              // This would restore the removed activity in a real app
            });
          },
        ),
      ),
    );
  }

  void _addRecommendedActivity(Map<String, dynamic> activity) {
    // Add the recommended activity to the routine
    setState(() {
      final newActivity = Map<String, dynamic>.from(activity);
      newActivity['id'] =
          DateTime.now().millisecondsSinceEpoch; // Generate a unique ID
      newActivity['active'] = true;
      _routineActivities.add(newActivity);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Activity added to your routine')),
    );
  }

  void _addCustomActivity() {
    // Show dialog to create a new activity
    _showActivityDialog(
      title: 'Create New Activity',
      activity: {
        'id': DateTime.now().millisecondsSinceEpoch,
        'title': '',
        'icon': Icons.star_outline,
        'duration': 300, // Default 5 minutes
        'active': true,
      },
      onSave: (newActivity) {
        setState(() {
          _routineActivities.add(newActivity);
        });
      },
    );
  }

  void _showActivityDialog({
    required String title,
    required Map<String, dynamic> activity,
    required Function(Map<String, dynamic>) onSave,
  }) {
    final TextEditingController titleController = TextEditingController(
      text: activity['title'] as String,
    );
    int minutes = (activity['duration'] as int) ~/ 60;
    IconData selectedIcon = activity['icon'] as IconData;

    // List of available icons
    final List<IconData> availableIcons = [
      Icons.water_drop_outlined,
      Icons.fitness_center_outlined,
      Icons.brush_outlined,
      Icons.bed_outlined,
      Icons.self_improvement_outlined,
      Icons.edit_note_outlined,
      Icons.shower_outlined,
      Icons.restaurant_outlined,
      Icons.pets_outlined,
      Icons.local_cafe_outlined,
      Icons.star_outline,
      Icons.favorite_outline,
    ];

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text(title),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Activity title
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          labelText: 'Activity Name',
                          hintText: 'Enter a name for this activity',
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Duration selector
                      Text(
                        'Duration (minutes)',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              if (minutes > 1) {
                                setState(() {
                                  minutes--;
                                });
                              }
                            },
                          ),
                          Text(
                            '$minutes',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () {
                              setState(() {
                                minutes++;
                              });
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Icon selector
                      Text(
                        'Select Icon',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children:
                            availableIcons.map((icon) {
                              final isSelected = selectedIcon == icon;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIcon = icon;
                                  });
                                },
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color:
                                        isSelected
                                            ? AppTheme.primaryGold
                                            : AppTheme.primaryGold
                                                .withAlphaValue(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    icon,
                                    color:
                                        isSelected
                                            ? Colors.white
                                            : AppTheme.primaryGold,
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final editedActivity = Map<String, dynamic>.from(
                        activity,
                      );
                      editedActivity['title'] =
                          titleController.text.isNotEmpty
                              ? titleController.text
                              : 'New Activity';
                      editedActivity['duration'] = minutes * 60;
                      editedActivity['icon'] = selectedIcon;

                      onSave(editedActivity);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGold,
                    ),
                    child: const Text('Save'),
                  ),
                ],
              );
            },
          ),
    );
  }

  void _saveChanges() {
    // In a real app, this would save changes to a database or state management solution
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Changes saved successfully')));
    Navigator.of(context).pop();
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    if (minutes == 1) {
      return '1 minute';
    }
    return '$minutes minutes';
  }
}
