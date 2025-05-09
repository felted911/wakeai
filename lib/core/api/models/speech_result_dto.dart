/// Data Transfer Object for speech recognition results.
/// This class represents the data structure returned by Azure's speech-to-text API.
class SpeechResultDto {
  /// The recognized text from the speech audio
  final String text;
  
  /// Confidence score of the recognition (0.0 to 1.0)
  final double confidence;
  
  SpeechResultDto({
    required this.text,
    required this.confidence,
  });
  
  /// Creates an empty result, useful for error cases
  factory SpeechResultDto.empty() {
    return SpeechResultDto(
      text: '',
      confidence: 0.0,
    );
  }
  
  /// Creates a SpeechResultDto from JSON data
  factory SpeechResultDto.fromJson(Map<String, dynamic> json) {
    // Handle different possible Azure response formats
    if (json.containsKey('DisplayText')) {
      // Standard format
      return SpeechResultDto(
        text: json['DisplayText'] as String? ?? '',
        confidence: (json['Confidence'] as num?)?.toDouble() ?? 0.0,
      );
    } else if (json.containsKey('text')) {
      // Alternative format
      return SpeechResultDto(
        text: json['text'] as String? ?? '',
        confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
      );
    } else if (json.containsKey('recognitionStatus') && 
               json['recognitionStatus'] == 'Success' && 
               json.containsKey('nbest') && 
               json['nbest'] is List && 
               (json['nbest'] as List).isNotEmpty) {
      // Another possible format
      final nbest = json['nbest'][0] as Map<String, dynamic>?;
      return SpeechResultDto(
        text: nbest?['lexical'] as String? ?? '',
        confidence: (nbest?['confidence'] as num?)?.toDouble() ?? 0.0,
      );
    } else {
      // Fallback for unexpected formats
      return SpeechResultDto.empty();
    }
  }
  
  /// Converts the SpeechResultDto to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'confidence': confidence,
    };
  }
  
  /// Creates a copy of this SpeechResultDto with optional field updates
  SpeechResultDto copyWith({
    String? text,
    double? confidence,
  }) {
    return SpeechResultDto(
      text: text ?? this.text,
      confidence: confidence ?? this.confidence,
    );
  }
  
  @override
  String toString() => 'SpeechResultDto(text: $text, confidence: $confidence)';
}