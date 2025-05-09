import 'package:flutter/material.dart';

class Achievement {
  final int id;
  final String title;
  final String description;
  final IconData icon;
  final double progress;
  final bool isComplete;
  final int points;
  final String? completedDate;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.progress,
    required this.isComplete,
    required this.points,
    this.completedDate,
  });

  factory Achievement.fromMap(Map<String, dynamic> map) {
    return Achievement(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      icon: map['icon'] as IconData,
      progress: map['progress'] as double,
      isComplete: map['isComplete'] as bool,
      points: map['points'] as int,
      completedDate: map['completedDate'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'progress': progress,
      'isComplete': isComplete,
      'points': points,
      if (completedDate != null) 'completedDate': completedDate,
    };
  }
}
