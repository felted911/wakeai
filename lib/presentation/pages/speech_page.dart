import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../bloc/speech_bloc.dart';
import '../bloc/speech_event.dart';
import '../bloc/speech_state.dart';

class SpeechPage extends StatefulWidget {
  const SpeechPage({super.key});

  @override
  State<SpeechPage> createState() => _SpeechPageState();
}

class _SpeechPageState extends State<SpeechPage> {
  final TextEditingController _textController = TextEditingController();
  // Using bool to track recording status
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await Permission.microphone.request();
    await Permission.storage.request();
  }

  Future<void> _startRecording() async {
    // This is a simulation of recording functionality
    // In a real implementation, you would use a plugin like flutter_sound

    setState(() {
      _isRecording = true;
    });

    // Simulate recording for 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _isRecording = false;
    });

    // In a real implementation, you would then:
    // 1. Pass the _recordingPath to the BLoC
    // context.read<SpeechBloc>().add(ConvertSpeechToTextEvent(_recordingPath!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Peri - Your Personal Good Angel')),
      body: BlocConsumer<SpeechBloc, SpeechState>(
        listener: (context, state) {
          if (state is SpeechError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Speech to Text Section
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Speech to Text',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed:
                              _isRecording ? null : () => _startRecording(),
                          child: Text(
                            _isRecording ? 'Recording...' : 'Start Recording',
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text('Recognized Text:'),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            state is SpeechToTextSuccess
                                ? state.result.text
                                : 'No text recognized yet',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Text to Speech Section
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Text to Speech',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _textController,
                          decoration: const InputDecoration(
                            labelText: 'Enter text to convert to speech',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed:
                              state is SpeechLoading
                                  ? null
                                  : () {
                                    if (_textController.text.isNotEmpty) {
                                      context.read<SpeechBloc>().add(
                                        ConvertTextToSpeechEvent(
                                          _textController.text,
                                        ),
                                      );
                                    }
                                  },
                          child:
                              state is SpeechLoading
                                  ? const CircularProgressIndicator()
                                  : const Text('Convert to Speech'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
