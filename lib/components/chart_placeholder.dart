import 'package:flutter/material.dart';

class ChartPlaceholder extends StatelessWidget {
  final String label;
  final double height;
  final Color? color;

  const ChartPlaceholder({
    super.key,
    required this.label,
    this.height = 200,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color ?? Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
          ),
        ),
      ),
    );
  }
} 