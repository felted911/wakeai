import '../../domain/entities/speech_result.dart';
import '../../domain/repositories/speech_repository.dart';
import '../datasources/speech_service_datasource.dart';

class SpeechRepositoryImpl implements SpeechRepository {
  final SpeechServiceDatasource datasource;

  SpeechRepositoryImpl({required this.datasource});

  @override
  Future<SpeechResult> convertSpeechToText(String audioFilePath) async {
    return await datasource.speechToText(audioFilePath);
  }

  @override
  Future<String> convertTextToSpeech(String text) async {
    return await datasource.textToSpeech(text);
  }
}
