import 'package:flutter/material.dart';

class DashedLinePainter extends CustomPainter {
  DashedLinePainter({
    this.isDashed = true,
    this.strokeWidth = 3,
    this.dashSpace = 0,
    this.color = Colors.grey,
  });
  final bool isDashed;
  final Color color;
  final double dashSpace;
  final double strokeWidth;
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 7;
    double startX = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;
    while (startX < size.height) {
      canvas.drawLine(
        // Offset(startX, 0),
        // Offset(startX + dashWidth, 0),
        Offset(0, startX),
        Offset(0, startX + dashWidth),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
