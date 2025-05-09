import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../../../core/util/color_extensions.dart';

class TimerControls extends StatelessWidget {
  final int secondsRemaining;
  final bool isPaused;
  final bool hasPrevious;
  final bool hasNext;
  final VoidCallback onPause;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const TimerControls({
    super.key,
    required this.secondsRemaining,
    required this.isPaused,
    required this.hasPrevious,
    required this.hasNext,
    required this.onPause,
    required this.onPrevious,
    required this.onNext,
  });

  String _formatTimeRemaining(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Timer Display
        Text(
          _formatTimeRemaining(secondsRemaining),
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: isPaused ? Colors.grey : AppTheme.textDark,
          ),
        ),
        
        const SizedBox(height: 8),
        
        Text(
          isPaused ? 'Paused' : 'Remaining',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isPaused ? Colors.grey : AppTheme.textLight,
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Control Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Skip Button (Back)
            if (hasPrevious)
              _buildControlButton(
                icon: Icons.skip_previous,
                label: 'Previous',
                onPressed: onPrevious,
              )
            else
              const SizedBox(width: 72), // Empty space if no previous
            
            // Pause/Resume Button
            _buildControlButton(
              icon: isPaused ? Icons.play_arrow : Icons.pause,
              label: isPaused ? 'Resume' : 'Pause',
              onPressed: onPause,
              isHighlighted: true,
            ),
            
            // Skip Button (Forward)
            if (hasNext)
              _buildControlButton(
                icon: Icons.skip_next,
                label: 'Skip',
                onPressed: onNext,
              )
            else
              const SizedBox(width: 72), // Empty space if no next
          ],
        ),
      ],
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool isHighlighted = false,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isHighlighted 
                  ? AppTheme.primaryGold
                  : AppTheme.primaryGold.withAlphaValue(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isHighlighted ? Colors.white : AppTheme.primaryGold,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: isHighlighted ? AppTheme.primaryGold : AppTheme.textLight,
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
