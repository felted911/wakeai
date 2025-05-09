import 'package:flutter/material.dart';

/// Helper class with modern replacements for deprecated Material Design properties
class MaterialThemeUpdates {
  /// Replace deprecated 'background' and 'onBackground' with appropriate alternatives
  static ThemeData updateColorScheme(ThemeData theme) {
    final colorScheme = theme.colorScheme.copyWith(
      // Use 'surface' and related properties instead of background
      surface: theme.colorScheme.surface,
      onSurface: theme.colorScheme.onSurface,
    );

    return theme.copyWith(colorScheme: colorScheme);
  }

  /// Replace deprecated WidgetStateProperty with newer APIs
  static WidgetStateProperty<Color> createColorProperty(
    Color defaultColor,
    Color selectedColor,
  ) {
    return WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) return selectedColor;
      return defaultColor;
    });
  }

  /// Replace deprecated background property with appropriate surface property
  static Color getSurfaceColor(ThemeData theme) {
    return theme.colorScheme.surface;
  }

  /// Replace deprecated onBackground property with appropriate onSurface property
  static Color getOnSurfaceColor(ThemeData theme) {
    return theme.colorScheme.onSurface;
  }

  /// Replace deprecated Material color/state properties with newer alternatives
  static Widget createCompatibleContainer({
    required Widget child,
    required Color color,
    double? width,
    double? height,
    BorderRadius? borderRadius,
    BoxShape shape = BoxShape.rectangle,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: shape == BoxShape.rectangle ? borderRadius : null,
        shape: shape,
      ),
      child: child,
    );
  }

  /// Create a modern Material card with proper styling
  static Widget createCard({
    required Widget child,
    Color? color,
    double elevation = 1.0,
    ShapeBorder? shape,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? borderRadius,
  }) {
    return Card(
      elevation: elevation,
      color: color,
      shape:
          shape ??
          RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
          ),
      margin: margin ?? EdgeInsets.zero,
      child: padding != null ? Padding(padding: padding, child: child) : child,
    );
  }
}
