import 'package:flutter/material.dart';

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final Color cardBackgroundColor;
  final Color secondaryTextColor;
  final BorderRadius defaultBorderRadius;

  const AppThemeExtension({
    required this.cardBackgroundColor,
    required this.secondaryTextColor,
    required this.defaultBorderRadius,
  });

  @override
  ThemeExtension<AppThemeExtension> copyWith({
    Color? cardBackgroundColor,
    Color? secondaryTextColor,
    BorderRadius? defaultBorderRadius,
  }) {
    return AppThemeExtension(
      cardBackgroundColor: cardBackgroundColor ?? this.cardBackgroundColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      defaultBorderRadius: defaultBorderRadius ?? this.defaultBorderRadius,
    );
  }

  @override
  ThemeExtension<AppThemeExtension> lerp(
    covariant ThemeExtension<AppThemeExtension>? other,
    double t,
  ) {
    if (other is! AppThemeExtension) {
      return this;
    }
    return AppThemeExtension(
      cardBackgroundColor: Color.lerp(cardBackgroundColor, other.cardBackgroundColor, t)!,
      secondaryTextColor: Color.lerp(secondaryTextColor, other.secondaryTextColor, t)!,
      defaultBorderRadius: BorderRadius.lerp(defaultBorderRadius, other.defaultBorderRadius, t)!,
    );
  }
} 