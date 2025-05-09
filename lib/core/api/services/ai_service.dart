import 'dart:async';
import '../api_client.dart';
import '../../error/api_exception.dart';
import '../../config/environment_config.dart';
import '../models/ai_message_dto.dart';
import '../models/ai_completion_dto.dart';

/// Interface for AI service operations.
/// This abstraction allows for different AI provider implementations
/// (Azure, local, mock, etc.) without affecting the rest of the application.
abstract class AIService {
  /// Sends a message to the AI and receives a completion response
  Future<AICompletionDto> completeChat(List<AIMessageDto> messages);
  
  /// Generates a text completion based on a prompt
  Future<String> completeText(String prompt);
}

/// Azure AI service implementation
class AzureAIService implements AIService {
  final ApiClient _apiClient;
  final EnvironmentConfig _config;
  
  AzureAIService({
    required ApiClient apiClient,
    EnvironmentConfig? config,
  }) : _apiClient = apiClient,
       _config = config ?? EnvironmentConfig.current;
  
  @override
  Future<AICompletionDto> completeChat(List<AIMessageDto> messages) async {
    try {
      // Azure endpoint for AI chat completion
      final endpoint = '${_config.azureAIEndpoint}openai/deployments/${_config.azureDeploymentName}/chat/completions?api-version=${_config.azureAPIVersion}';
      
      final messagesJson = messages.map((msg) => msg.toJson()).toList();
      
      final Map<String, dynamic> body = {
        'messages': messagesJson,
        'temperature': 0.7,
        'max_tokens': 150,
      };
      
      final Map<String, String> headers = {
        'api-key': _config.azureApiKey,
        'Content-Type': 'application/json',
      };
      
      final response = await _apiClient.post(
        endpoint,
        headers: headers,
        body: body,
      );
      
      if (response is Map<String, dynamic>) {
        return AICompletionDto.fromJson(response);
      } else {
        throw ApiException(message: 'Invalid response format');
      }
    } on ApiException catch (e) {
      throw ApiException(
        code: e.code,
        message: 'Azure AI chat completion failed: ${e.message}',
        response: e.response,
      );
    } catch (e) {
      throw ApiException(
        message: 'Azure AI chat completion failed: ${e.toString()}',
      );
    }
  }
  
  @override
  Future<String> completeText(String prompt) async {
    try {
      // Azure endpoint for AI text completion
      final endpoint = '${_config.azureAIEndpoint}openai/deployments/${_config.azureDeploymentName}/completions?api-version=${_config.azureAPIVersion}';
      
      final Map<String, dynamic> body = {
        'prompt': prompt,
        'temperature': 0.7,
        'max_tokens': 150,
      };
      
      final Map<String, String> headers = {
        'api-key': _config.azureApiKey,
        'Content-Type': 'application/json',
      };
      
      final response = await _apiClient.post(
        endpoint,
        headers: headers,
        body: body,
      );
      
      if (response is Map<String, dynamic> && 
          response.containsKey('choices') && 
          response['choices'] is List && 
          (response['choices'] as List).isNotEmpty) {
        final choice = response['choices'][0] as Map<String, dynamic>;
        return choice['text'] as String? ?? '';
      }
      
      throw ApiException(message: 'Invalid response format');
    } on ApiException catch (e) {
      throw ApiException(
        code: e.code,
        message: 'Azure AI text completion failed: ${e.message}',
        response: e.response,
      );
    } catch (e) {
      throw ApiException(
        message: 'Azure AI text completion failed: ${e.toString()}',
      );
    }
  }
}

/// Mock AI service implementation for testing and development
class MockAIService implements AIService {
  @override
  Future<AICompletionDto> completeChat(List<AIMessageDto> messages) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    final lastMessage = messages.isNotEmpty ? messages.last : AIMessageDto(role: 'user', content: '');
    
    return AICompletionDto(
      id: 'mock-id',
      model: 'mock-model',
      created: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      content: 'This is a mock response to: "${lastMessage.content}"',
      finishReason: 'stop',
    );
  }
  
  @override
  Future<String> completeText(String prompt) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    return 'This is a mock completion for: "$prompt"';
  }
}