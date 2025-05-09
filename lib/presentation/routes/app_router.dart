import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/animated_splash_screen.dart';
import '../pages/speech_page.dart';
import '../pages/onboarding/welcome_page.dart';
import '../pages/onboarding/permissions_page.dart';
import '../pages/onboarding/voice_style_page.dart';
import '../pages/onboarding/routine_setup_page.dart';
import '../pages/home/home_page.dart';
import '../pages/alarm/alarm_setup_page.dart';
import '../pages/alarm/wakeup_alarm_page.dart';
//import '../pages/routine/routine_guidance_page.dart';
import '../pages/routine/routine_editor_page.dart';
import '../pages/progress/progress_tracking_page.dart';
import '../pages/settings/settings_page.dart';
import '../pages/rewards/rewards_page.dart';
import '../bloc/speech_bloc.dart';
import '../../injection_container.dart' as di;

class AppRouter {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String permissions = '/permissions';
  static const String voiceStyle = '/voice-style';
  static const String routineSetup = '/routine-setup';
  static const String home = '/home';
  static const String alarmSetup = '/alarm-setup';
  static const String wakeupAlarm = '/wakeup-alarm';
  //static const String routineGuidance = '/routine-guidance';
  static const String routineEditor = '/routine-editor';
  static const String progressTracking = '/progress-tracking';
  static const String settings = '/settings';
  static const String rewards = '/rewards';
  static const String speech = '/speech';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder:
              (_) => AnimatedSplashScreen(
                child: BlocProvider(
                  create: (_) => di.sl<SpeechBloc>(),
                  child:
                      const WelcomePage(), // Redirecting to welcome page after splash
                ),
              ),
        );

      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomePage());

      case permissions:
        return MaterialPageRoute(builder: (_) => const PermissionsPage());

      case voiceStyle:
        return MaterialPageRoute(builder: (_) => const VoiceStylePage());

      case routineSetup:
        return MaterialPageRoute(builder: (_) => const RoutineSetupPage());

      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case alarmSetup:
        return MaterialPageRoute(builder: (_) => const AlarmSetupPage());

      case wakeupAlarm:
        return MaterialPageRoute(builder: (_) => const WakeupAlarmPage());

      //case routineGuidance:
      //return MaterialPageRoute(builder: (_) => const RoutineGuidancePage());

      case routineEditor:
        return MaterialPageRoute(builder: (_) => const RoutineEditorPage());

      case progressTracking:
        return MaterialPageRoute(builder: (_) => const ProgressTrackingPage());

      case AppRouter.settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());

      case rewards:
        return MaterialPageRoute(builder: (_) => const RewardsPage());

      case speech:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (_) => di.sl<SpeechBloc>(),
                child: const SpeechPage(),
              ),
        );

      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Route not found!'))),
        );
    }
  }
}
