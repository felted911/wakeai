import '../entities/speech_result.dart';

abstract class SpeechRepository {
  Future<SpeechResult> convertSpeechToText(String audioFilePath);
  Future<String> convertTextToSpeech(String text);
}
