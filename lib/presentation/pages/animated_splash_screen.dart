import 'package:flutter/material.dart';
//import 'dart:developer' as developer;

class AnimatedSplashScreen extends StatefulWidget {
  final Widget child;

  const AnimatedSplashScreen({super.key, required this.child});

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen> {
  @override
  Widget build(BuildContext context) {
    // Your splash screen UI implementation here
    return widget.child; // For now, just returning the child widget
  }
}
