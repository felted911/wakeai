import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import '../error/api_exception.dart';

/// A centralized client for making HTTP requests to external APIs.
/// This class handles common tasks like error processing, request formatting, 
/// and response parsing to ensure consistent API interaction throughout the app.
class ApiClient {
  final http.Client httpClient;
  
  ApiClient({required this.httpClient});
  
  /// Performs a GET request to the specified endpoint.
  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParams);
      
      final response = await httpClient.get(
        uri,
        headers: _buildHeaders(headers),
      );
      
      return _processResponse(response);
    } catch (e) {
      throw ApiException(message: 'Network error: ${e.toString()}');
    }
  }
  
  /// Performs a POST request with a JSON body.
  Future<dynamic> post(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParams);
      final String bodyString;
      
      if (body is String) {
        bodyString = body;
      } else if (body is Map) {
        bodyString = json.encode(body);
      } else {
        bodyString = '';
      }
      
      final response = await httpClient.post(
        uri,
        headers: _buildHeaders(headers),
        body: bodyString,
      );
      
      return _processResponse(response);
    } catch (e) {
      throw ApiException(message: 'Network error: ${e.toString()}');
    }
  }
  
  /// Performs a POST request with binary data (e.g., for audio files).
  Future<dynamic> postBinary(
    String endpoint, {
    required Uint8List bytes,
    required Map<String, String> headers,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParams);
      
      final response = await httpClient.post(
        uri,
        headers: headers, // Don't use _buildHeaders here as content type will be specific
        body: bytes,
      );
      
      return _processResponse(response);
    } catch (e) {
      throw ApiException(message: 'Network error: ${e.toString()}');
    }
  }
  
  /// Performs a PUT request.
  Future<dynamic> put(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParams);
      final String bodyString;
      
      if (body is String) {
        bodyString = body;
      } else if (body is Map) {
        bodyString = json.encode(body);
      } else {
        bodyString = '';
      }
      
      final response = await httpClient.put(
        uri,
        headers: _buildHeaders(headers),
        body: bodyString,
      );
      
      return _processResponse(response);
    } catch (e) {
      throw ApiException(message: 'Network error: ${e.toString()}');
    }
  }
  
  /// Performs a DELETE request.
  Future<dynamic> delete(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParams);
      
      final response = await httpClient.delete(
        uri,
        headers: _buildHeaders(headers),
      );
      
      return _processResponse(response);
    } catch (e) {
      throw ApiException(message: 'Network error: ${e.toString()}');
    }
  }
  
  /// Builds a URI with optional query parameters.
  Uri _buildUri(String endpoint, Map<String, dynamic>? queryParams) {
    if (queryParams != null) {
      // Convert all values to strings
      final Map<String, String> stringParams = {};
      queryParams.forEach((key, value) {
        stringParams[key] = value.toString();
      });
      return Uri.parse(endpoint).replace(queryParameters: stringParams);
    }
    return Uri.parse(endpoint);
  }
  
  /// Builds headers with defaults.
  Map<String, String> _buildHeaders(Map<String, String>? customHeaders) {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    
    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }
    
    return headers;
  }
  
  /// Processes the HTTP response, handling different status codes and formats.
  dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return <String, dynamic>{};
      
      // Try to parse as JSON first
      try {
        return json.decode(response.body) as Map<String, dynamic>;
      } catch (e) {
        // If not JSON, return a map with raw data
        return <String, dynamic>{
          'data': response.body,
          'rawBytes': response.bodyBytes,
        };
      }
    } else {
      // Handle different error status codes
      switch (response.statusCode) {
        case 400:
          throw ApiException(
            code: response.statusCode,
            message: 'Bad request',
            response: response.body,
          );
        case 401:
          throw ApiException(
            code: response.statusCode,
            message: 'Unauthorized',
            response: response.body,
          );
        case 403:
          throw ApiException(
            code: response.statusCode,
            message: 'Forbidden',
            response: response.body,
          );
        case 404:
          throw ApiException(
            code: response.statusCode,
            message: 'Not found',
            response: response.body,
          );
        case 500:
        case 501:
        case 502:
        case 503:
          throw ApiException(
            code: response.statusCode,
            message: 'Server error',
            response: response.body,
          );
        default:
          throw ApiException(
            code: response.statusCode,
            message: 'API Error: ${response.reasonPhrase}',
            response: response.body,
          );
      }
    }
  }
}