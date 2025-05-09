import 'package:flutter/material.dart';

/// This class provides sample data for the Rewards page.
/// In a real application, this would fetch data from a repository or service.
class RewardsDataProvider {
  /// Get list of achievements
  static List<Map<String, dynamic>> getAchievements() {
    return [
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
  }

  /// Get list of badges
  static List<Map<String, dynamic>> getBadges() {
    return [
      {
        'id': 1,
        'title': 'Bronze Morning Person',
        'description': 'Complete 30 morning routines',
        'icon': 'assets/images/badges/bronze_badge.png', // This would be a real asset in a real app
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
  }

  /// Get user stats
  static Map<String, String> getStats() {
    return {
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
  }

  /// Calculate total points earned from achievements
  static int calculateTotalPoints(List<Map<String, dynamic>> achievements) {
    int total = 0;
    for (final achievement in achievements) {
      if (achievement['isComplete'] == true) {
        total += achievement['points'] as int;
      }
    }
    return total;
  }

  /// Count completed achievements
  static int countCompletedAchievements(List<Map<String, dynamic>> achievements) {
    return achievements.where((a) => a['isComplete'] == true).length;
  }

  /// Count unlocked badges
  static int countUnlockedBadges(List<Map<String, dynamic>> badges) {
    return badges.where((b) => b['isUnlocked'] == true).length;
  }
}
