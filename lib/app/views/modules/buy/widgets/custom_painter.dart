
import 'package:flutter/material.dart';

class PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white.withOpacity(0.1)
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 3; j++) {
        final rect = Rect.fromLTWH(
          (size.width / 5) * i - 20,
          (size.height / 3) * j - 10,
          40,
          20,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(10)),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
