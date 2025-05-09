import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/speech_to_text_usecase.dart';
import '../../../domain/usecases/text_to_speech_usecase.dart';
import 'speech_event.dart';
import 'speech_state.dart';

class SpeechBloc extends Bloc<SpeechEvent, SpeechState> {
  final SpeechToTextUseCase speechToTextUseCase;
  final TextToSpeechUseCase textToSpeechUseCase;

  SpeechBloc({
    required this.speechToTextUseCase,
    required this.textToSpeechUseCase,
  }) : super(SpeechInitial()) {
    on<ConvertSpeechToTextEvent>(_onConvertSpeechToText);
    on<ConvertTextToSpeechEvent>(_onConvertTextToSpeech);
  }

  Future<void> _onConvertSpeechToText(
    ConvertSpeechToTextEvent event,
    Emitter<SpeechState> emit,
  ) async {
    emit(SpeechLoading());
    try {
      final result = await speechToTextUseCase.execute(event.audioFilePath);
      emit(SpeechToTextSuccess(result));
    } catch (e) {
      emit(SpeechError(e.toString()));
    }
  }

  Future<void> _onConvertTextToSpeech(
    ConvertTextToSpeechEvent event,
    Emitter<SpeechState> emit,
  ) async {
    emit(SpeechLoading());
    try {
      final audioBase64 = await textToSpeechUseCase.execute(event.text);
      emit(TextToSpeechSuccess(audioBase64));
    } catch (e) {
      emit(SpeechError(e.toString()));
    }
  }
}
