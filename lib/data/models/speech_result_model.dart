import '../../domain/entities/speech_result.dart';

class SpeechResultModel extends SpeechResult {
  // Removed 'const' keyword to fix the error
  SpeechResultModel({
    required super.text,
    required super.confidence,
  });

  // Helper method to safely convert any value to a String
  static String _safeToString(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  // Helper method to safely convert any value to a double
  static double _safeToDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  factory SpeechResultModel.fromJson(Map<String, dynamic> json) {
    // Extract text and confidence using the safe conversion methods
    final text = _safeToString(json['DisplayText']);
    final confidence = _safeToDouble(json['Confidence']);

    return SpeechResultModel(
      text: text,
      confidence: confidence,
    );
  }

  // This is a fallback factory constructor for any unexpected JSON structure
  factory SpeechResultModel.empty() {
    return SpeechResultModel(
      text: '',
      confidence: 0.0,
    );
  }
}
