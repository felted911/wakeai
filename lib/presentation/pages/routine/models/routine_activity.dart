import 'package:flutter/material.dart';

class RoutineActivity {
  final String title;
  final String instruction;
  final IconData icon;
  final int durationInSeconds;
  bool completed;

  RoutineActivity({
    required this.title,
    required this.instruction,
    required this.icon,
    required this.durationInSeconds,
    this.completed = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'instruction': instruction,
      'icon': icon,
      'duration': durationInSeconds,
      'completed': completed,
    };
  }

  factory RoutineActivity.fromMap(Map<String, dynamic> map) {
    return RoutineActivity(
      title: map['title'] as String,
      instruction: map['instruction'] as String,
      icon: map['icon'] as IconData,
      durationInSeconds: map['duration'] as int,
      completed: map['completed'] as bool,
    );
  }
}
