# API Service Layer Implementation

## Overview

The API Service Layer has been implemented to provide a clean separation between the application's business logic and external services like Azure. This layer is designed to be:

1. **Centralized**: All API-related code is in one place
2. **Consistent**: Standardized error handling and response processing
3. **Flexible**: Easy to switch between different implementations (real, mock)
4. **Testable**: Simple to mock for unit testing
5. **Future-proof**: Ready for potential frontend/backend separation

## Structure

```
lib/core/api/
├── api_client.dart           # Base HTTP client
├── service_factory.dart      # Factory for creating service instances
├── example_usage.dart        # Examples of how to use the services
├── README.md                 # Documentation
├── models/                   # Data Transfer Objects
│   ├── ai_completion_dto.dart
│   ├── ai_message_dto.dart
│   └── speech_result_dto.dart
└── services/                 # Service interfaces and implementations
    ├── ai_service.dart
    └── speech_service.dart
```

## Components

### 1. API Client

The `ApiClient` class provides a centralized way to make HTTP requests with consistent error handling and response processing. It supports:

- GET, POST, PUT, DELETE methods
- Binary data uploads (for audio files)
- Query parameter building
- Standard header management
- Unified error handling

### 2. Service Interfaces

Each service has a clear interface that defines its capabilities:

- `SpeechService`: Speech-to-text and text-to-speech
- `AIService`: AI chat and text completion

### 3. Service Implementations

Each service has multiple implementations:

- Azure implementations for production
- Mock implementations for testing and development

### 4. Service Factory

The `ServiceFactory` provides a single point for creating service instances, making it easy to switch between real and mock implementations based on the environment.

### 5. Environment Configuration

The `EnvironmentConfig` class manages different configurations for development, staging, and production environments.

## How to Use

### Basic Usage

```dart
// Get service instances
final speechService = sl<SpeechService>();
final aiService = sl<AIService>();

// Use speech services
final speechResult = await speechService.speechToText('audio.wav');
final audioData = await speechService.textToSpeech('Hello, world!');

// Use AI services
final chatMessages = [
  AIMessageDto.system('You are a helpful assistant.'),
  AIMessageDto.user('Good morning!')
];
final chatResponse = await aiService.completeChat(chatMessages);
final textResponse = await aiService.completeText('Write a morning greeting:');
```

### Best Practices

1. **Use dependency injection**: Access services through the GetIt service locator
2. **Handle errors**: All service methods can throw `ApiException`
3. **Use DTOs**: Use the provided DTO classes for type safety
4. **Environment awareness**: Be aware of which environment is active

## Migration Plan

The API service layer is designed to work alongside the existing code. Here's a plan for migrating to the new architecture:

1. **Phase 1 (Current)**: Build the service layer foundation
2. **Phase 2**: Implement services for new features using the new layer
3. **Phase 3**: Gradually migrate existing features to use the new services
4. **Phase 4**: Remove the legacy implementation

## Azure Integration

The implementation focuses on integrating with Azure services:

1. **Azure Speech Service**: For speech-to-text and text-to-speech
2. **Azure OpenAI Service**: For AI chat and text completion

## Benefits for WakeAI

This API service layer provides several benefits for the WakeAI project:

1. **Simplified Integration**: Clear interfaces for all external services
2. **Reduced Duplication**: Centralized HTTP client and error handling
3. **Easier Testing**: Mock implementations for all services
4. **Future-Proofing**: Ready for potential frontend/backend separation
5. **Consistency**: Standardized approach across all API interactions