import 'package:flutter/material.dart';
import 'package:wakeai/core/util/color_extensions.dart';
import '../../widgets/peri_button.dart';
import '../../widgets/peri_app_bar.dart';
import '../../widgets/peri_card.dart';
import '../../theme/app_theme.dart';
import '../../routes/app_router.dart';
// Import removed: no longer using color_extensions

class AlarmSetupPage extends StatefulWidget {
  const AlarmSetupPage({super.key});

  @override
  State<AlarmSetupPage> createState() => _AlarmSetupPageState();
}

class _AlarmSetupPageState extends State<AlarmSetupPage> {
  // Time field needs to be mutable since it's updated in _selectTime
  TimeOfDay _selectedTime = const TimeOfDay(hour: 7, minute: 0);
  final List<bool> _selectedDays = [true, true, true, true, true, false, false];
  final List<String> _dayLabels = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  final String _alarmSound = 'Gentle Rise';
  double _volume = 0.7;
  bool _vibrate = true;
  bool _snoozeEnabled = true;
  int _snoozeMinutes = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceWhite,
      appBar: const PeriAppBar(title: 'Alarm Setup', showBackButton: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Time Selector
                PeriCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Wake-Up Time',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 24),

                      // Time Display
                      GestureDetector(
                        onTap: _selectTime,
                        child: Text(
                          _formatTime(_selectedTime),
                          style: Theme.of(
                            context,
                          ).textTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryGold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Day Selector
                      _buildDaySelector(),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Sound Settings
                _buildSectionHeader('Sound Settings'),
                const SizedBox(height: 8),

                PeriCard(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Column(
                    children: [
                      // Alarm Sound
                      ListTile(
                        title: const Text('Alarm Sound'),
                        subtitle: Text(_alarmSound),
                        trailing: const Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          // This would open a sound selector in a real app
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Sound selector will be implemented in a future version',
                              ),
                            ),
                          );
                        },
                      ),

                      // Volume
                      ListTile(
                        title: const Text('Volume'),
                        subtitle: Slider(
                          value: _volume,
                          min: 0,
                          max: 1,
                          activeColor: AppTheme.primaryGold,
                          onChanged: (value) {
                            setState(() {
                              _volume = value;
                            });
                          },
                        ),
                      ),

                      // Vibrate
                      SwitchListTile(
                        title: const Text('Vibrate'),
                        value: _vibrate,
                        activeColor: AppTheme.primaryGold,
                        onChanged: (value) {
                          setState(() {
                            _vibrate = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Snooze Settings
                _buildSectionHeader('Snooze Settings'),
                const SizedBox(height: 8),

                PeriCard(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Column(
                    children: [
                      // Snooze Enable
                      SwitchListTile(
                        title: const Text('Enable Snooze'),
                        value: _snoozeEnabled,
                        activeColor: AppTheme.primaryGold,
                        onChanged: (value) {
                          setState(() {
                            _snoozeEnabled = value;
                          });
                        },
                      ),

                      // Snooze Duration (only shown if snooze is enabled)
                      if (_snoozeEnabled)
                        ListTile(
                          title: const Text('Snooze Duration'),
                          subtitle: Text('$_snoozeMinutes minutes'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () {
                                  if (_snoozeMinutes > 1) {
                                    setState(() {
                                      _snoozeMinutes--;
                                    });
                                  }
                                },
                              ),
                              Text('$_snoozeMinutes'),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () {
                                  if (_snoozeMinutes < 30) {
                                    setState(() {
                                      _snoozeMinutes++;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Preview Button
                PeriButton(
                  text: 'Preview Alarm',
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRouter.wakeupAlarm);
                  },
                  type: PeriButtonType.secondary,
                  icon: Icons.play_arrow_rounded,
                  isFullWidth: true,
                ),

                const SizedBox(height: 16),

                // Save Button
                PeriButton(
                  text: 'Save Alarm Settings',
                  onPressed: () {
                    // Save alarm settings logic would go here
                    Navigator.of(context).pop();
                  },
                  isFullWidth: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDaySelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDays[index] = !_selectedDays[index];
            });
          },
          child: CircleAvatar(
            radius: 20,
            backgroundColor:
                _selectedDays[index]
                    ? AppTheme.primaryGold
                    : Colors.grey.withAlphaValue(51), // 0.2 * 255 ≈ 51
            child: Text(
              _dayLabels[index],
              style: TextStyle(
                color: _selectedDays[index] ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        );
      }),
    );
  }

  void _selectTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppTheme.primaryGold,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppTheme.textDark,
            ),
          ),
          child: child!,
        );
      },
    );

    if (time != null) {
      setState(() {
        _selectedTime = time;
      });
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}
