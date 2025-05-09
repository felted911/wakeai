// This is an example file to demonstrate how to use the API service layer.
// It is not meant to be included in the actual app.

import 'dart:io';
import 'dart:developer' as developer;
import 'service_factory.dart';
import 'models/ai_message_dto.dart';

/// Example class demonstrating how to use the API service layer
class APIServiceExample {
  final ServiceFactory _serviceFactory;
  
  APIServiceExample({ServiceFactory? serviceFactory}) 
    : _serviceFactory = serviceFactory ?? ServiceFactory.instance;
  
  /// Example of using the speech-to-text service
  Future<void> demonstrateSpeechToText() async {
    try {
      final speechService = _serviceFactory.createSpeechService();
      
      // Assuming you have an audio file
      const String audioFilePath = 'path/to/audio.wav';
      
      developer.log('Converting speech to text...', name: 'APIService');
      final result = await speechService.speechToText(audioFilePath);
      
      developer.log('Speech-to-text result: ${result.text}', name: 'APIService');
      developer.log('Confidence: ${result.confidence}', name: 'APIService');
    } catch (e) {
      developer.log('Error in speech-to-text: $e', name: 'APIService', error: e);
    }
  }
  
  /// Example of using the text-to-speech service
  Future<void> demonstrateTextToSpeech() async {
    try {
      final speechService = _serviceFactory.createSpeechService();
      
      const String text = 'Hello, this is a test of the text-to-speech service.';
      
      developer.log('Converting text to speech...', name: 'APIService');
      final audioData = await speechService.textToSpeech(text);
      
      // Save the audio data to a file
      final file = File('output.mp3');
      await file.writeAsBytes(audioData);
      
      developer.log('Text-to-speech output saved to ${file.path}', name: 'APIService');
    } catch (e) {
      developer.log('Error in text-to-speech: $e', name: 'APIService', error: e);
    }
  }
  
  /// Example of using the AI chat completion service
  Future<void> demonstrateAIChat() async {
    try {
      final aiService = _serviceFactory.createAIService();
      
      // Create a message list for the AI chat
      final messages = [
        AIMessageDto.system('You are a helpful personal morning assistant named Peri.'),
        AIMessageDto.user('Good morning! What should I do today?')
      ];
      
      developer.log('Sending chat request to AI...', name: 'APIService');
      final completion = await aiService.completeChat(messages);
      
      developer.log('AI response: ${completion.content}', name: 'APIService');
    } catch (e) {
      developer.log('Error in AI chat: $e', name: 'APIService', error: e);
    }
  }
  
  /// Example of using the AI text completion service
  Future<void> demonstrateAIText() async {
    try {
      final aiService = _serviceFactory.createAIService();
      
      const String prompt = 'Write a morning affirmation:';
      
      developer.log('Sending text completion request to AI...', name: 'APIService');
      final completion = await aiService.completeText(prompt);
      
      developer.log('AI completion: $completion', name: 'APIService');
    } catch (e) {
      developer.log('Error in AI text completion: $e', name: 'APIService', error: e);
    }
  }
  
  /// Run all examples
  Future<void> runAllExamples() async {
    developer.log('=== Speech-to-Text Example ===', name: 'APIService');
    await demonstrateSpeechToText();
    
    developer.log('=== Text-to-Speech Example ===', name: 'APIService');
    await demonstrateTextToSpeech();
    
    developer.log('=== AI Chat Example ===', name: 'APIService');
    await demonstrateAIChat();
    
    developer.log('=== AI Text Completion Example ===', name: 'APIService');
    await demonstrateAIText();
    
    // Remember to clean up
    _serviceFactory.dispose();
    developer.log('Examples completed, resources disposed', name: 'APIService');
  }
}