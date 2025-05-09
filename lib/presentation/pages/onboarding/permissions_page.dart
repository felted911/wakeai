import 'package:flutter/material.dart';
import '../../widgets/peri_button.dart';
import '../../widgets/peri_app_bar.dart';
import '../../widgets/peri_card.dart';
import '../../theme/app_theme.dart';
import '../../routes/app_router.dart';
import '../../../core/util/color_extensions.dart';

class PermissionsPage extends StatefulWidget {
  const PermissionsPage({super.key});

  @override
  State<PermissionsPage> createState() => _PermissionsPageState();
}

class _PermissionsPageState extends State<PermissionsPage> {
  final Map<String, bool> _permissions = {
    'microphone': false,
    'notifications': false,
    'alarm': false,
  };

  bool get _allPermissionsGranted => 
      _permissions.values.every((granted) => granted);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceWhite,
      appBar: const PeriAppBar(
        title: 'Required Permissions',
        showBackButton: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Peri needs a few permissions to help you with your morning routine',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 8),
              
              Text(
                'These permissions are required for basic functionality',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textLight,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 32),
              
              // Permission Cards
              Expanded(
                child: ListView(
                  children: [
                    _buildPermissionCard(
                      title: 'Microphone Access',
                      description: 'Allows Peri to understand your voice commands and confirm activities',
                      icon: Icons.mic,
                      permissionKey: 'microphone',
                    ),
                    
                    const SizedBox(height: 16),
                    
                    _buildPermissionCard(
                      title: 'Notification Access',
                      description: 'Enables Peri to send you reminders and notifications about your routine',
                      icon: Icons.notifications,
                      permissionKey: 'notifications',
                    ),
                    
                    const SizedBox(height: 16),
                    
                    _buildPermissionCard(
                      title: 'Alarm & Background Access',
                      description: 'Required for Peri to wake you up and run your morning routine',
                      icon: Icons.alarm,
                      permissionKey: 'alarm',
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Continue Button
              PeriButton(
                text: 'Continue',
                onPressed: _allPermissionsGranted
                    ? () {
                        Navigator.of(context).pushNamed(AppRouter.voiceStyle);
                      }
                    : null, // Disabled if not all permissions granted
                isFullWidth: true,
              ),
              
              const SizedBox(height: 16),
              
              // Skip for now (in a real app, this might not be an option for required permissions)
              if (!_allPermissionsGranted)
                Center(
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Permissions Required'),
                          content: const Text(
                            'Peri needs these permissions to function properly. Without them, the app may not work as expected.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text(
                      'Why are these required?',
                      style: TextStyle(color: AppTheme.textLight),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionCard({
    required String title,
    required String description,
    required IconData icon,
    required String permissionKey,
  }) {
    final isGranted = _permissions[permissionKey] ?? false;
    
    return PeriCard(
      elevation: 2,
      backgroundColor: isGranted
          ? AppTheme.primaryGold.withAlphaValue(0.1)
          : Colors.white,
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isGranted
                  ? AppTheme.primaryGold
                  : Colors.grey.withAlphaValue(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: isGranted ? Colors.white : Colors.grey,
              size: 28,
            ),
          ),
          
          const SizedBox(width: 16),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isGranted ? AppTheme.primaryGold : AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textLight,
                  ),
                ),
              ],
            ),
          ),
          
          // Fake Grant Button (in a real app, this would request actual permissions)
          ElevatedButton(
            onPressed: isGranted
                ? null // Already granted
                : () {
                    // Simulate granting the permission
                    setState(() {
                      _permissions[permissionKey] = true;
                    });
                    
                    // Show a toast message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$title granted'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: isGranted ? Colors.grey.withAlphaValue(0.1) : AppTheme.primaryGold,
              foregroundColor: isGranted ? Colors.grey : Colors.white,
              elevation: isGranted ? 0 : 2,
            ),
            child: Text(isGranted ? 'Granted' : 'Grant'),
          ),
        ],
      ),
    );
  }
}
