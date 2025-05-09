import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../core/config/api_config.dart';
import '../models/speech_result_model.dart';

abstract class SpeechServiceDatasource {
  Future<SpeechResultModel> speechToText(String audioFilePath);
  Future<String> textToSpeech(String text);
}

class SpeechServiceDatasourceImpl implements SpeechServiceDatasource {
  final http.Client client;

  SpeechServiceDatasourceImpl({required this.client});

  @override
  Future<SpeechResultModel> speechToText(String audioFilePath) async {
    final file = File(audioFilePath);
    final bytes = await file.readAsBytes();

    final response = await client.post(
      Uri.parse('${ApiConfig.speechToTextEndpoint}?language=en-US'),
      headers: {
        'Ocp-Apim-Subscription-Key': ApiConfig.subscriptionKey,
        'Content-Type': 'audio/wav',
        'Accept': 'application/json',
      },
      body: bytes,
    );

    if (response.statusCode == 200) {
      try {
        // Decode JSON without type casting
        final dynamic decodedJson = json.decode(response.body);
        
        // Handle different possible JSON structures
        if (decodedJson is Map) {
          // Manually create a new map to avoid type issues
          final Map<String, dynamic> jsonMap = {};
          decodedJson.forEach((key, value) {
            if (key is String) {
              jsonMap[key] = value;
            }
          });
          return SpeechResultModel.fromJson(jsonMap);
        } else if (decodedJson is List && decodedJson.isNotEmpty) {
          if (decodedJson.first is Map) {
            // Manually create a new map to avoid type issues
            final Map<String, dynamic> jsonMap = {};
            decodedJson.first.forEach((key, value) {
              if (key is String) {
                jsonMap[key] = value;
              }
            });
            return SpeechResultModel.fromJson(jsonMap);
          }
        }
        
        // Fallback for unexpected JSON structures
        return SpeechResultModel.empty();
      } catch (e) {
        // Handle parsing errors with a fallback model
        return SpeechResultModel(
          text: 'Error parsing speech result: ${e.toString()}',
          confidence: 0.0,
        );
      }
    } else {
      throw Exception('Failed to convert speech to text: ${response.body}');
    }
  }

  @override
  Future<String> textToSpeech(String text) async {
    final response = await client.post(
      Uri.parse(ApiConfig.textToSpeechEndpoint),
      headers: {
        'Ocp-Apim-Subscription-Key': ApiConfig.subscriptionKey,
        'Content-Type': 'application/ssml+xml',
        'X-Microsoft-OutputFormat': 'audio-16khz-128kbitrate-mono-mp3',
      },
      body: '''
      <speak version='1.0' xml:lang='en-US'>
        <voice xml:lang='en-US' name='en-US-JennyNeural'>
          $text
        </voice>
      </speak>
      ''',
    );

    if (response.statusCode == 200) {
      // Return the audio content as base64 for easy handling
      return base64Encode(response.bodyBytes);
    } else {
      throw Exception('Failed to convert text to speech: ${response.body}');
    }
  }
}
