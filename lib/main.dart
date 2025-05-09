import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;
import 'injection_container.dart' as di;
//import 'presentation/bloc/speech_bloc.dart';
import 'presentation/routes/app_router.dart';
import 'presentation/theme/app_theme.dart';

void main() {
  // Initialize Flutter binding
  developer.log('App starting: About to initialize Flutter binding');
  WidgetsFlutterBinding.ensureInitialized();
  developer.log('Flutter binding initialized');

  // Initialize dependency injection
  developer.log('Initializing dependency injection');
  di.init();
  developer.log('Dependency injection completed');

  // Run the app
  developer.log('Running app with MyApp widget');
  runApp(const MyApp());
  developer.log('App started');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    developer.log('MyApp.build called');
    return MaterialApp(
      title: 'Peri - Your Personal Good Angel',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.splash,
      debugShowMaterialGrid: false,
    );
  }
}
