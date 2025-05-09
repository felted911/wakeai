/// Custom exception class for API-related errors.
/// This class provides a standardized way to handle and report API errors
/// throughout the application.
class ApiException implements Exception {
  /// HTTP status code, if applicable
  final int? code;
  
  /// Error message describing what went wrong
  final String message;
  
  /// Raw API response body, useful for debugging
  final String? response;
  
  ApiException({
    this.code,
    required this.message,
    this.response,
  });
  
  /// Factory constructor for creating an ApiException from a response map
  factory ApiException.fromMap(Map<String, dynamic> map) {
    return ApiException(
      code: map['code'] as int?,
      message: map['message'] as String? ?? 'Unknown error',
      response: map['response'] as String?,
    );
  }
  
  /// Converts the exception to a map, useful for logging
  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'message': message,
      'response': response,
    };
  }
  
  @override
  String toString() => 'ApiException: $message (Code: $code)';
}