import '../entities/speech_result.dart';
import '../repositories/speech_repository.dart';

class SpeechToTextUseCase {
  final SpeechRepository repository;

  SpeechToTextUseCase(this.repository);

  Future<SpeechResult> execute(String audioFilePath) {
    return repository.convertSpeechToText(audioFilePath);
  }
}
