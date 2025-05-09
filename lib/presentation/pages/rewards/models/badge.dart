class Badge {
  final int id;
  final String title;
  final String description;
  final String icon;
  final bool isUnlocked;
  final int level;
  final double? progress;

  Badge({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.isUnlocked,
    required this.level,
    this.progress,
  });

  factory Badge.fromMap(Map<String, dynamic> map) {
    return Badge(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      icon: map['icon'] as String,
      isUnlocked: map['isUnlocked'] as bool,
      level: map['level'] as int,
      progress: map['progress'] as double?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'isUnlocked': isUnlocked,
      'level': level,
      if (progress != null) 'progress': progress,
    };
  }
}
