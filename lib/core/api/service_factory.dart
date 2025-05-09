import 'package:http/http.dart' as http;
import 'api_client.dart';
import 'services/speech_service.dart';
import 'services/ai_service.dart';
import '../config/environment_config.dart';

/// Factory class responsible for creating instances of various API services.
/// This centralized factory ensures consistent configuration and makes it easy
/// to switch between real and mock implementations.
class ServiceFactory {
  final http.Client _httpClient;
  final ApiClient _apiClient;
  final EnvironmentConfig _config;
  
  // Singleton pattern
  static ServiceFactory? _instance;
  
  /// Gets the singleton instance of ServiceFactory
  static ServiceFactory get instance {
    _instance ??= ServiceFactory._create(
      http.Client(),
      EnvironmentConfig.current,
    );
    return _instance!;
  }
  
  /// Creates a new instance with custom parameters (useful for testing)
  static ServiceFactory createCustom(
    http.Client client,
    EnvironmentConfig config,
  ) {
    return ServiceFactory._create(client, config);
  }
  
  /// Private constructor
  ServiceFactory._create(this._httpClient, this._config)
      : _apiClient = ApiClient(httpClient: _httpClient);
  
  /// Creates a speech service instance based on current environment
  SpeechService createSpeechService() {
    if (_config.useMockServices) {
      return MockSpeechService();
    } else {
      return AzureSpeechService(apiClient: _apiClient, config: _config);
    }
  }
  
  /// Creates an AI service instance based on current environment
  AIService createAIService() {
    if (_config.useMockServices) {
      return MockAIService();
    } else {
      return AzureAIService(apiClient: _apiClient, config: _config);
    }
  }
  
  /// Closes the HTTP client when the app is done
  void dispose() {
    _httpClient.close();
  }
}