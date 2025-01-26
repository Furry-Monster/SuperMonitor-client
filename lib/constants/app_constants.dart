import 'package:flutter/material.dart';

class AppConstants {
  // 平台相关
  static const platforms = {
    'youtube': PlatformInfo(
      name: 'YouTube',
      icon: Icons.play_circle_filled,
      color: Colors.red,
    ),
    'instagram': PlatformInfo(
      name: 'Instagram',
      icon: Icons.camera_alt,
      color: Colors.pink,
    ),
    'bilibili': PlatformInfo(
      name: 'Bilibili',
      icon: Icons.tv,
      color: Colors.blue,
    ),
    'pixiv': PlatformInfo(
      name: 'Pixiv',
      icon: Icons.brush,
      color: Colors.deepPurple,
    ),
  };

  // 主题相关
  static const defaultThemeColor = Colors.blue;
  static const themeColors = [
    ColorInfo(color: Colors.blue, name: '蓝色'),
    ColorInfo(color: Colors.green, name: '绿色'),
    ColorInfo(color: Colors.purple, name: '紫色'),
    ColorInfo(color: Colors.orange, name: '橙色'),
    ColorInfo(color: Colors.red, name: '红色'),
    ColorInfo(color: Colors.teal, name: '青色'),
    ColorInfo(color: Colors.pink, name: '粉色'),
    ColorInfo(color: Colors.indigo, name: '靛蓝'),
  ];

  // 布局相关
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1200;
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 12.0;
}

class PlatformInfo {
  final String name;
  final IconData icon;
  final Color color;

  const PlatformInfo({
    required this.name,
    required this.icon,
    required this.color,
  });
}

class ColorInfo {
  final Color color;
  final String name;

  const ColorInfo({
    required this.color,
    required this.name,
  });
} 