import 'package:equatable/equatable.dart';

abstract class SpeechEvent extends Equatable {
  const SpeechEvent();

  @override
  List<Object> get props => [];
}

class ConvertSpeechToTextEvent extends SpeechEvent {
  final String audioFilePath;

  const ConvertSpeechToTextEvent(this.audioFilePath);

  @override
  List<Object> get props => [audioFilePath];
}

class ConvertTextToSpeechEvent extends SpeechEvent {
  final String text;

  const ConvertTextToSpeechEvent(this.text);

  @override
  List<Object> get props => [text];
}
