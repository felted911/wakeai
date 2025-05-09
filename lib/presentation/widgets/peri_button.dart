import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum PeriButtonType { primary, secondary, text }

class PeriButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final PeriButtonType type;
  final bool isFullWidth;
  final IconData? icon;
  final bool isLoading;

  const PeriButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = PeriButtonType.primary,
    this.isFullWidth = false,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonWidth = isFullWidth ? double.infinity : null;

    Widget child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon),
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ],
    );

    if (isLoading) {
      child = const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    switch (type) {
      case PeriButtonType.primary:
        return SizedBox(
          width: buttonWidth,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGold,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: child,
          ),
        );
      
      case PeriButtonType.secondary:
        return SizedBox(
          width: buttonWidth,
          child: OutlinedButton(
            onPressed: isLoading ? null : onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.primaryGold,
              side: const BorderSide(color: AppTheme.primaryGold, width: 2),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: child,
          ),
        );
      
      case PeriButtonType.text:
        return SizedBox(
          width: buttonWidth,
          child: TextButton(
            onPressed: isLoading ? null : onPressed,
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.primaryGold,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: child,
          ),
        );
    }
  }
}
