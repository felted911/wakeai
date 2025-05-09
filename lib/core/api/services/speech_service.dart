import 'dart:io';
import 'dart:typed_data';
import '../api_client.dart';
import '../../error/api_exception.dart';
import '../../config/environment_config.dart';
import '../models/speech_result_dto.dart';

/// Interface for speech-related services (speech-to-text and text-to-speech).
/// This abstraction allows for different implementations (Azure, local, mock, etc.)
/// without affecting the rest of the application.
abstract class SpeechService {
  /// Converts speech audio to text
  Future<SpeechResultDto> speechToText(String audioFilePath);
  
  /// Converts text to speech audio
  Future<Uint8List> textToSpeech(String text);
}

/// Azure Speech Service implementation
class AzureSpeechService implements SpeechService {
  final ApiClient _apiClient;
  final EnvironmentConfig _config;
  
  AzureSpeechService({
    required ApiClient apiClient,
    EnvironmentConfig? config,
  }) : _apiClient = apiClient,
       _config = config ?? EnvironmentConfig.current;
  
  @override
  Future<SpeechResultDto> speechToText(String audioFilePath) async {
    try {
      final file = File(audioFilePath);
      final bytes = await file.readAsBytes();
      
      final endpoint = '${_config.speechServiceBaseUrl}speech/recognition/conversation/cognitiveservices/v1';
      
      final Map<String, String> headers = {
        'Ocp-Apim-Subscription-Key': _config.speechApiKey,
        'Content-Type': 'audio/wav',
        'Accept': 'application/json',
      };
      
      final Map<String, dynamic> queryParams = {'language': 'en-US'};
      
      final response = await _apiClient.postBinary(
        endpoint,
        bytes: bytes,
        headers: headers,
        queryParams: queryParams,
      );
      
      if (response is Map<String, dynamic>) {
        return SpeechResultDto.fromJson(response);
      } else {
        throw ApiException(message: 'Invalid response format');
      }
    } on ApiException catch (e) {
      throw ApiException(
        code: e.code,
        message: 'Speech to text failed: ${e.message}',
        response: e.response,
      );
    } catch (e) {
      throw ApiException(
        message: 'Speech to text failed: ${e.toString()}',
      );
    }
  }
  
  @override
  Future<Uint8List> textToSpeech(String text) async {
    try {
      final endpoint = '${_config.speechServiceBaseUrl}cognitiveservices/v1';
      
      final ssml = '''
      <speak version='1.0' xml:lang='en-US'>
        <voice xml:lang='en-US' name='en-US-JennyNeural'>
          $text
        </voice>
      </speak>
      ''';
      
      final Map<String, String> headers = {
        'Ocp-Apim-Subscription-Key': _config.speechApiKey,
        'Content-Type': 'application/ssml+xml',
        'X-Microsoft-OutputFormat': 'audio-16khz-128kbitrate-mono-mp3',
        'Accept': '*/*',
      };
      
      final response = await _apiClient.post(
        endpoint,
        headers: headers,
        body: ssml,
      );
      
      if (response is Map && response.containsKey('rawBytes')) {
        return response['rawBytes'] as Uint8List;
      } else {
        throw ApiException(message: 'No audio data returned');
      }
    } on ApiException catch (e) {
      throw ApiException(
        code: e.code,
        message: 'Text to speech failed: ${e.message}',
        response: e.response,
      );
    } catch (e) {
      throw ApiException(
        message: 'Text to speech failed: ${e.toString()}',
      );
    }
  }
}

/// Mock implementation for testing and development
class MockSpeechService implements SpeechService {
  @override
  Future<SpeechResultDto> speechToText(String audioFilePath) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    return SpeechResultDto(
      text: 'This is a mock speech recognition result',
      confidence: 0.95,
    );
  }
  
  @override
  Future<Uint8List> textToSpeech(String text) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Return a dummy audio data
    return Uint8List.fromList([0, 1, 2, 3, 4, 5]);
  }
}