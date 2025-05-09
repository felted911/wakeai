import 'package:flutter/material.dart';
import '../../../widgets/peri_button.dart';
import '../../../theme/app_theme.dart';

class CompletionDialog extends StatelessWidget {
  final VoidCallback onHome;
  
  const CompletionDialog({
    super.key,
    required this.onHome, 
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      title: const Text(
        'Routine Completed!',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppTheme.primaryGold,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: AppTheme.primaryGold,
            size: 64,
          ),
          const SizedBox(height: 16),
          const Text(
            'Great job! You\'ve completed your morning routine.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          PeriButton(
            text: 'Return to Home',
            onPressed: onHome,
            isFullWidth: true,
          ),
        ],
      ),
    );
  }
}
