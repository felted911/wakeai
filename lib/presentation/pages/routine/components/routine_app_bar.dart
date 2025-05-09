import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../../../core/util/color_extensions.dart';

class RoutineAppBar extends StatelessWidget {
  final int totalActivities;
  final int completedActivities;
  final VoidCallback onBack;
  final VoidCallback onSettings;

  const RoutineAppBar({
    super.key,
    required this.totalActivities,
    required this.completedActivities,
    required this.onBack,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    final progress = totalActivities > 0 ? completedActivities / totalActivities : 0.0;
    
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlphaValue(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back Button
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded),
                onPressed: onBack,
              ),
              
              // Title
              Text(
                'Morning Routine',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              // Settings Button
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: onSettings,
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Progress Bar
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.withAlphaValue(0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryGold),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          
          const SizedBox(height: 8),
          
          // Progress Text
          Text(
            '$completedActivities of $totalActivities activities completed',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.textLight,
            ),
          ),
        ],
      ),
    );
  }
}
