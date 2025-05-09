import '../repositories/speech_repository.dart';

class TextToSpeechUseCase {
  final SpeechRepository repository;

  TextToSpeechUseCase(this.repository);

  Future<String> execute(String text) {
    return repository.convertTextToSpeech(text);
  }
}
