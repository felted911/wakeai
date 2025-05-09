import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PeriAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final double elevation;
  final Widget? leading;

  const PeriAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.actions,
    this.elevation = 0,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: AppTheme.primaryGold,
      elevation: elevation,
      centerTitle: true,
      leading: showBackButton 
          ? leading ?? IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
