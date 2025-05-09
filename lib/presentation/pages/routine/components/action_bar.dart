import 'package:flutter/material.dart';
import '../../../widgets/peri_button.dart';
import '../../../theme/app_theme.dart';
import '../../../../core/util/color_extensions.dart';

class ActionBar extends StatelessWidget {
  final bool isListening;
  final bool isLastActivity;
  final VoidCallback onToggleListening;
  final VoidCallback onCompleteActivity;
  final Animation<double>? pulseAnimation;

  const ActionBar({
    super.key,
    required this.isListening,
    required this.isLastActivity,
    required this.onToggleListening,
    required this.onCompleteActivity,
    this.pulseAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlphaValue(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: PeriButton(
              text: isLastActivity ? 'Complete Routine' : 'Mark as Complete',
              onPressed: onCompleteActivity,
              isFullWidth: true,
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Voice Command Button
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isListening ? AppTheme.primaryGold : Colors.grey.withAlphaValue(0.1),
              shape: BoxShape.circle,
            ),
            child: AnimatedBuilder(
              animation: pulseAnimation ?? const AlwaysStoppedAnimation(0.0),
              builder: (context, child) {
                return IconButton(
                  icon: Icon(
                    isListening ? Icons.mic : Icons.mic_none,
                    color: isListening ? Colors.white : Colors.grey,
                    size: 28,
                  ),
                  onPressed: onToggleListening,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
