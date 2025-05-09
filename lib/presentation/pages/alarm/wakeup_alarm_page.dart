import 'package:flutter/material.dart';
import 'dart:async';
import '../../widgets/peri_button.dart';
import '../../theme/app_theme.dart';
//import '../../routes/app_router.dart';
import '../../../core/util/color_extensions.dart';

class WakeupAlarmPage extends StatefulWidget {
  const WakeupAlarmPage({super.key});

  @override
  State<WakeupAlarmPage> createState() => _WakeupAlarmPageState();
}

class _WakeupAlarmPageState extends State<WakeupAlarmPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  Timer? _timeTimer;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();

    // Set up pulse animation
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Make the pulse animation repeat
    _pulseController.repeat(reverse: true);

    // Set up timer to update current time
    _timeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _timeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryGold,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.primaryGold,
                AppTheme.primaryGold.withAlphaValue(0.8),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 1),

                // Current Time
                Text(
                  _formatTime(_currentTime),
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 60,
                  ),
                ),

                const SizedBox(height: 8),

                // Current Date
                Text(
                  _formatDate(_currentTime),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white.withAlphaValue(0.8),
                  ),
                ),

                const Spacer(flex: 1),

                // Pulsing Sun Icon
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnimation.value,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlphaValue(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Image.asset(
                            'assets/images/peri_logo.png',
                            fit: BoxFit.contain,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 40),

                // Greeting Text
                Text(
                  'Good Morning, Mark!',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  'Time to start your day with Peri',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white.withAlphaValue(0.8),
                  ),
                ),

                const Spacer(flex: 1),

                // Wake Up Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: PeriButton(
                    text: 'I\'m Awake',
                    onPressed: () {
                      //Navigator.of(context).pushNamed(AppRouter.routineGuidance);
                    },
                    isFullWidth: true,
                    type: PeriButtonType.secondary,
                  ),
                ),

                const SizedBox(height: 16),

                // Snooze Button
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Snoozed for 5 minutes'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Snooze for 5 Minutes',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour =
        time.hour > 12 ? time.hour - 12 : (time.hour == 0 ? 12 : time.hour);
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  String _formatDate(DateTime date) {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    final day = days[date.weekday - 1];
    final month = months[date.month - 1];

    return '$day, $month ${date.day}';
  }
}
