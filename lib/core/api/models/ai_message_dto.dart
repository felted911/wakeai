/// Data Transfer Object for AI message exchanges.
/// This class represents a message in a conversation with an AI service.
class AIMessageDto {
  /// Role of the message sender (system, user, assistant)
  final String role;
  
  /// Content of the message
  final String content;
  
  AIMessageDto({
    required this.role,
    required this.content,
  });
  
  /// Creates an AIMessageDto from JSON data
  factory AIMessageDto.fromJson(Map<String, dynamic> json) {
    return AIMessageDto(
      role: json['role'] as String? ?? 'user',
      content: json['content'] as String? ?? '',
    );
  }
  
  /// Converts the AIMessageDto to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
    };
  }
  
  /// Creates a system message
  factory AIMessageDto.system(String content) {
    return AIMessageDto(role: 'system', content: content);
  }
  
  /// Creates a user message
  factory AIMessageDto.user(String content) {
    return AIMessageDto(role: 'user', content: content);
  }
  
  /// Creates an assistant message
  factory AIMessageDto.assistant(String content) {
    return AIMessageDto(role: 'assistant', content: content);
  }
  
  /// Creates a copy of this AIMessageDto with optional field updates
  AIMessageDto copyWith({
    String? role,
    String? content,
  }) {
    return AIMessageDto(
      role: role ?? this.role,
      content: content ?? this.content,
    );
  }
  
  @override
  String toString() => 'AIMessageDto(role: $role, content: $content)';
}