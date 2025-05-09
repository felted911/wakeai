/// Data Transfer Object for AI completion results.
/// This class represents the completion response from Azure's AI services.
class AICompletionDto {
  /// Unique identifier for the completion
  final String id;
  
  /// Model used for the completion
  final String model;
  
  /// Unix timestamp of when the completion was created
  final int created;
  
  /// The AI-generated content
  final String content;
  
  /// Reason why the completion finished (stop, length, etc.)
  final String finishReason;
  
  AICompletionDto({
    required this.id,
    required this.model,
    required this.created,
    required this.content,
    required this.finishReason,
  });
  
  /// Creates an AICompletionDto from JSON data
  factory AICompletionDto.fromJson(Map<String, dynamic> json) {
    // Handle different possible Azure response formats
    if (json.containsKey('choices') && 
        json['choices'] is List && 
        (json['choices'] as List).isNotEmpty) {
      final choice = json['choices'][0] as Map<String, dynamic>;
      final String contentText;
      
      if (choice.containsKey('message') && choice['message'] is Map) {
        contentText = (choice['message'] as Map<String, dynamic>)['content'] as String? ?? '';
      } else if (choice.containsKey('text')) {
        contentText = choice['text'] as String? ?? '';
      } else {
        contentText = '';
      }
      
      return AICompletionDto(
        id: json['id'] as String? ?? '',
        model: json['model'] as String? ?? '',
        created: json['created'] as int? ?? DateTime.now().millisecondsSinceEpoch ~/ 1000,
        content: contentText,
        finishReason: choice['finish_reason'] as String? ?? '',
      );
    } else {
      // Fallback for unexpected formats
      return AICompletionDto(
        id: json['id'] as String? ?? '',
        model: json['model'] as String? ?? '',
        created: json['created'] as int? ?? DateTime.now().millisecondsSinceEpoch ~/ 1000,
        content: '',
        finishReason: '',
      );
    }
  }
  
  /// Converts the AICompletionDto to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'model': model,
      'created': created,
      'content': content,
      'finish_reason': finishReason,
    };
  }
  
  /// Creates a copy of this AICompletionDto with optional field updates
  AICompletionDto copyWith({
    String? id,
    String? model,
    int? created,
    String? content,
    String? finishReason,
  }) {
    return AICompletionDto(
      id: id ?? this.id,
      model: model ?? this.model,
      created: created ?? this.created,
      content: content ?? this.content,
      finishReason: finishReason ?? this.finishReason,
    );
  }
  
  @override
  String toString() => 'AICompletionDto(id: $id, content: $content)';
}