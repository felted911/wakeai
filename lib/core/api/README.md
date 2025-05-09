# API Service Layer

This directory contains the API service layer implementation for the WakeAI app. The service layer acts as a central point for all external API communications, making it easier to maintain, test, and potentially separate into a standalone backend service in the future.

## Structure

- `api_client.dart` - Base HTTP client for handling all API requests with standardized error handling
- `service_factory.dart` - Factory for creating service instances, allowing easy switching between real and mock implementations
- `services/` - Service interfaces and implementations
  - `speech_service.dart` - Speech-to-text and text-to-speech services
  - `ai_service.dart` - AI completion and chat services
- `models/` - Data Transfer Objects (DTOs) for API requests and responses
  - `speech_result_dto.dart` - Structure for speech recognition results
  - `ai_message_dto.dart` - Structure for AI messages
  - `ai_completion_dto.dart` - Structure for AI completion responses

## How to Use

### Accessing Services

Services are registered with the dependency injection container and can be accessed via GetIt:

```dart
// In your repository or use case
final speechService = sl<SpeechService>();
final aiService = sl<AIService>();

// Example speech-to-text usage
final result = await speechService.speechToText(audioFilePath);

// Example AI completion usage
final messages = [
  AIMessageDto.system("You are a helpful assistant."),
  AIMessageDto.user("Hello, how are you?")
];
final completion = await aiService.completeChat(messages);
```

### Adding New Services

To add a new service:

1. Create a new service interface and implementation in the `services/` directory
2. Add any necessary DTOs to the `models/` directory
3. Update `service_factory.dart` to provide the new service
4. Register the service in `injection_container.dart`

### Environment Configuration

The service layer uses environment configuration to manage different settings for development, staging, and production environments. Update the configuration in `core/config/environment_config.dart`.

## Migration Plan

The API service layer is designed to gradually replace the existing implementation:

1. First phase: Build the service layer structure
2. Second phase: Implement services alongside existing code
3. Third phase: Migrate BLoCs and use cases to use the new services
4. Fourth phase: Remove legacy implementations

## Benefits

- **Centralized API Logic**: All API-related code is in one place
- **Consistent Error Handling**: Standardized approach to error handling
- **Environment Flexibility**: Easy switching between development, staging, and production settings
- **Mockable Services**: Simple creation of mock implementations for testing
- **Future-Proof**: Designed for potential frontend/backend separation