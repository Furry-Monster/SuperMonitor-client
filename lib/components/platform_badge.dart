import 'package:flutter/material.dart';

class PlatformBadge extends StatelessWidget {
  final String platform;
  final Color color;
  final IconData? icon;

  const PlatformBadge({
    super.key,
    required this.platform,
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon!, color: color, size: 16),
            const SizedBox(width: 4),
          ],
          Text(
            platform,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
} 