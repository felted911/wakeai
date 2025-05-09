import 'package:flutter/material.dart';
import '../../widgets/peri_app_bar.dart';
import '../../widgets/peri_card.dart';
import '../../widgets/peri_button.dart';
import '../../theme/app_theme.dart';
import '../../routes/app_router.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Notification Settings
  bool _alarmsEnabled = true;
  bool _routineRemindersEnabled = true;
  bool _achievementNotificationsEnabled = true;

  // Voice Settings
  String _selectedVoiceStyle = 'Encouraging';
  double _voiceSpeed = 1.0;
  double _voiceVolume = 0.8;

  // App Settings
  bool _darkModeEnabled = false;
  bool _vibrateEnabled = true;
  String _selectedLanguage = 'English';

  // Privacy Settings
  bool _dataCollectionEnabled = true;
  bool _locationEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceWhite,
      appBar: const PeriAppBar(title: 'Settings', showBackButton: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            _buildProfileSection(),

            const SizedBox(height: 32),

            // Notification Settings
            _buildSectionHeader('Notifications'),
            const SizedBox(height: 16),
            _buildNotificationSettings(),

            const SizedBox(height: 32),

            // Voice Settings
            _buildSectionHeader('Voice Settings'),
            const SizedBox(height: 16),
            _buildVoiceSettings(),

            const SizedBox(height: 32),

            // App Settings
            _buildSectionHeader('App Settings'),
            const SizedBox(height: 16),
            _buildAppSettings(),

            const SizedBox(height: 32),

            // Privacy Settings
            _buildSectionHeader('Privacy'),
            const SizedBox(height: 16),
            _buildPrivacySettings(),

            const SizedBox(height: 32),

            // About & Help
            _buildSectionHeader('About & Help'),
            const SizedBox(height: 16),
            _buildAboutAndHelp(),

            const SizedBox(height: 32),

            // Sign Out Button
            Center(
              child: PeriButton(
                text: 'Sign Out',
                onPressed: _signOut,
                type: PeriButtonType.secondary,
                icon: Icons.logout,
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildProfileSection() {
    return PeriCard(
      child: Row(
        children: [
          // Profile Picture
          CircleAvatar(
            radius: 36,
            backgroundColor: AppTheme.primaryGold.withValues(),
            child: const Icon(
              Icons.person,
              size: 40,
              color: AppTheme.primaryGold,
            ),
          ),

          const SizedBox(width: 24),

          // Profile Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mark Johnson',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'mark.johnson@example.com',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppTheme.textLight),
                ),
                const SizedBox(height: 8),
                Text(
                  'Premium Member',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.primaryGold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Edit Button
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: AppTheme.primaryGold),
            onPressed: () {
              // Show edit profile dialog or navigate to edit profile page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Edit profile will be available in a future update',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return PeriCard(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('Alarm Notifications'),
            subtitle: const Text('Receive wake-up notifications'),
            value: _alarmsEnabled,
            activeColor: AppTheme.primaryGold,
            onChanged: (value) {
              setState(() {
                _alarmsEnabled = value;
              });
            },
          ),

          const Divider(),

          SwitchListTile(
            title: const Text('Routine Reminders'),
            subtitle: const Text('Get reminded about your scheduled routines'),
            value: _routineRemindersEnabled,
            activeColor: AppTheme.primaryGold,
            onChanged: (value) {
              setState(() {
                _routineRemindersEnabled = value;
              });
            },
          ),

          const Divider(),

          SwitchListTile(
            title: const Text('Achievement Notifications'),
            subtitle: const Text('Get notified when you earn achievements'),
            value: _achievementNotificationsEnabled,
            activeColor: AppTheme.primaryGold,
            onChanged: (value) {
              setState(() {
                _achievementNotificationsEnabled = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVoiceSettings() {
    final voiceStyles = ['Encouraging', 'Calm', 'Efficient', 'Friendly'];

    return PeriCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Voice Style
          Text(
            'Voice Style',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _selectedVoiceStyle,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.withValues(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            items:
                voiceStyles
                    .map(
                      (style) =>
                          DropdownMenuItem(value: style, child: Text(style)),
                    )
                    .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedVoiceStyle = value;
                });
              }
            },
          ),

          const SizedBox(height: 24),

          // Voice Speed
          Row(
            children: [
              const Icon(Icons.speed, size: 20, color: AppTheme.textLight),
              const SizedBox(width: 8),
              Text(
                'Voice Speed',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Slider(
            value: _voiceSpeed,
            min: 0.5,
            max: 1.5,
            divisions: 4,
            label: _getSpeedLabel(_voiceSpeed),
            activeColor: AppTheme.primaryGold,
            onChanged: (value) {
              setState(() {
                _voiceSpeed = value;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Slower',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppTheme.textLight),
              ),
              Text(
                'Faster',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppTheme.textLight),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Voice Volume
          Row(
            children: [
              const Icon(Icons.volume_up, size: 20, color: AppTheme.textLight),
              const SizedBox(width: 8),
              Text(
                'Voice Volume',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Slider(
            value: _voiceVolume,
            min: 0.0,
            max: 1.0,
            activeColor: AppTheme.primaryGold,
            onChanged: (value) {
              setState(() {
                _voiceVolume = value;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quiet',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppTheme.textLight),
              ),
              Text(
                'Loud',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppTheme.textLight),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Try Voice Button
          Center(
            child: PeriButton(
              text: 'Try Voice',
              onPressed: () {
                // This would play a sample of the selected voice
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Voice preview will be available in a future update',
                    ),
                  ),
                );
              },
              type: PeriButtonType.secondary,
              icon: Icons.play_arrow,
            ),
          ),
        ],
      ),
    );
  }

  String _getSpeedLabel(double speed) {
    if (speed <= 0.5) return 'Very Slow';
    if (speed <= 0.75) return 'Slow';
    if (speed <= 1.0) return 'Normal';
    if (speed <= 1.25) return 'Fast';
    return 'Very Fast';
  }

  Widget _buildAppSettings() {
    final languages = [
      'English',
      'Spanish',
      'French',
      'German',
      'Chinese',
      'Japanese',
    ];

    return PeriCard(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Use dark theme throughout the app'),
            value: _darkModeEnabled,
            activeColor: AppTheme.primaryGold,
            onChanged: (value) {
              setState(() {
                _darkModeEnabled = value;
              });
              // This would actually change the theme in a real app
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Dark mode will be available in a future update',
                  ),
                ),
              );
            },
          ),

          const Divider(),

          SwitchListTile(
            title: const Text('Vibration'),
            subtitle: const Text('Enable haptic feedback'),
            value: _vibrateEnabled,
            activeColor: AppTheme.primaryGold,
            onChanged: (value) {
              setState(() {
                _vibrateEnabled = value;
              });
            },
          ),

          const Divider(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Language'),
                    const SizedBox(height: 4),
                    Text(
                      'Change app language',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textLight,
                      ),
                    ),
                  ],
                ),
                DropdownButton<String>(
                  value: _selectedLanguage,
                  items:
                      languages
                          .map(
                            (lang) => DropdownMenuItem(
                              value: lang,
                              child: Text(lang),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedLanguage = value;
                      });
                      // This would change the app language in a real app
                    }
                  },
                  underline: Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacySettings() {
    return PeriCard(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('Data Collection'),
            subtitle: const Text(
              'Allow anonymous usage data to improve the app',
            ),
            value: _dataCollectionEnabled,
            activeColor: AppTheme.primaryGold,
            onChanged: (value) {
              setState(() {
                _dataCollectionEnabled = value;
              });
            },
          ),

          const Divider(),

          SwitchListTile(
            title: const Text('Location Services'),
            subtitle: const Text(
              'Personalize experience based on your location',
            ),
            value: _locationEnabled,
            activeColor: AppTheme.primaryGold,
            onChanged: (value) {
              setState(() {
                _locationEnabled = value;
              });
            },
          ),

          const Divider(),

          ListTile(
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to privacy policy
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Privacy policy will be available in a future update',
                  ),
                ),
              );
            },
          ),

          const Divider(),

          ListTile(
            title: const Text('Delete My Data'),
            textColor: Colors.red,
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.red,
            ),
            onTap: () {
              // Show delete confirmation dialog
              _showDeleteDataDialog();
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteDataDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete My Data'),
            content: const Text(
              'This will permanently delete all your data including routines, progress, and achievements. This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Data deletion will be available in a future update',
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildAboutAndHelp() {
    return PeriCard(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.info_outline,
              color: AppTheme.primaryGold,
            ),
            title: const Text('About Peri'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to about page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'About page will be available in a future update',
                  ),
                ),
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(
              Icons.help_outline,
              color: AppTheme.primaryGold,
            ),
            title: const Text('Help & Support'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to help page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Help & Support will be available in a future update',
                  ),
                ),
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(
              Icons.star_outline,
              color: AppTheme.primaryGold,
            ),
            title: const Text('Rate the App'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Open app store rating
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'App rating will be available in a future update',
                  ),
                ),
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(
              Icons.share_outlined,
              color: AppTheme.primaryGold,
            ),
            title: const Text('Share with Friends'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Open share dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sharing will be available in a future update'),
                ),
              );
            },
          ),

          // Version information
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Version 1.0.0 (Build 100)',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppTheme.textLight),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  void _signOut() {
    // Show sign out confirmation dialog
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Sign Out'),
            content: const Text('Are you sure you want to sign out?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // In a real app, this would sign the user out
                  // and navigate to the login or welcome screen
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRouter.welcome,
                    (route) => false,
                  );
                },
                child: const Text('Sign Out'),
              ),
            ],
          ),
    );
  }
}
