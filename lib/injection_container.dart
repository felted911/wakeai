import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

// Core
import 'core/api/api_client.dart';
import 'core/api/service_factory.dart';
import 'core/api/services/speech_service.dart';
import 'core/api/services/ai_service.dart';
import 'core/config/environment_config.dart';

// Legacy imports (will be phased out as we migrate)
import 'data/datasources/speech_service_datasource.dart';
import 'data/repositories/speech_repository_impl.dart';
import 'domain/repositories/speech_repository.dart';
import 'domain/usecases/speech_to_text_usecase.dart';
import 'domain/usecases/text_to_speech_usecase.dart';
import 'presentation/bloc/speech_bloc.dart';

final sl = GetIt.instance;

void init() {
  //=========================================================================
  // New API Service Layer (will eventually replace legacy services)
  //=========================================================================
  
  // Core Services
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => ApiClient(httpClient: sl()));
  sl.registerLazySingleton(() => EnvironmentConfig.current);
  
  // Service Factory
  sl.registerLazySingleton(() => ServiceFactory.createCustom(sl(), sl()));
  
  // API Services
  sl.registerLazySingleton<SpeechService>(
    () => sl<ServiceFactory>().createSpeechService(),
  );
  
  sl.registerLazySingleton<AIService>(
    () => sl<ServiceFactory>().createAIService(),
  );
  
  //=========================================================================
  // Legacy Services (will be phased out as we migrate)
  //=========================================================================
  
  // BLoCs
  sl.registerFactory(
    () => SpeechBloc(speechToTextUseCase: sl(), textToSpeechUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => SpeechToTextUseCase(sl()));
  sl.registerLazySingleton(() => TextToSpeechUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<SpeechRepository>(
    () => SpeechRepositoryImpl(datasource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<SpeechServiceDatasource>(
    () => SpeechServiceDatasourceImpl(client: sl()),
  );
}