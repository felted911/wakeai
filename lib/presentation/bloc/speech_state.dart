import 'package:equatable/equatable.dart';
import '../../../domain/entities/speech_result.dart';

abstract class SpeechState extends Equatable {
  const SpeechState();

  @override
  List<Object?> get props => [];
}

class SpeechInitial extends SpeechState {}

class SpeechLoading extends SpeechState {}

class SpeechToTextSuccess extends SpeechState {
  final SpeechResult result;

  const SpeechToTextSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

class TextToSpeechSuccess extends SpeechState {
  final String audioBase64;

  const TextToSpeechSuccess(this.audioBase64);

  @override
  List<Object?> get props => [audioBase64];
}

class SpeechError extends SpeechState {
  final String message;

  const SpeechError(this.message);

  @override
  List<Object?> get props => [message];
}
