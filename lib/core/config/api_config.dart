class ApiConfig {
  // Azure Speech Service credentials
  static const String subscriptionKey =
      'AAVpE7QoR24xDP0T1dSSSrb1UjQLtyMZvBmhjyrhtdsw7SDBvdAaJQQJ99BEACHYHv6XJ3w3AAAYACOGhF80'; // Replace with your actual key
  static const String region = 'eastus2'; // Based on your "East US 2" location
  static const String endpoint = 'https://eastus2.api.cognitive.microsoft.com/';

  // API endpoints
  static String get speechToTextEndpoint =>
      'https://$region.stt.speech.microsoft.com/speech/recognition/conversation/cognitiveservices/v1';

  static String get textToSpeechEndpoint =>
      'https://$region.tts.speech.microsoft.com/cognitiveservices/v1';
}
