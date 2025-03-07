import 'package:flutter/material.dart';

class BoomboxPainter extends CustomPainter {
  BoomboxPainter({required this.volumeRadius});

  final double volumeRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height * 0.5;
    final width = size.width;
    final circleRadius = size.height * 0.12;

    final rectanglePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    final circlePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = circleRadius;

    final Paint soundPaint = Paint()
      ..color = Colors.grey.shade500
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final leftOffset = Offset(size.width * 0.25, size.height * 0.5);
    final rightOffset = Offset(size.width * 0.75, size.height * 0.5);

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(width * 0.5, size.height * 0.5),
        width: width,
        height: height,
      ),
      rectanglePaint,
    );

    canvas.drawRect(
      Rect.fromLTWH(width * 0.125, height * 0.25, width * 0.75, height * 0.25),
      rectanglePaint,
    );

    canvas.drawCircle(leftOffset, circleRadius, circlePaint);
    canvas.drawCircle(rightOffset, circleRadius, circlePaint);

    canvas.drawCircle(leftOffset, volumeRadius, soundPaint);
    canvas.drawCircle(rightOffset, volumeRadius, soundPaint);
  }

  @override
  bool shouldRepaint(covariant BoomboxPainter oldDelegate) =>
      oldDelegate.volumeRadius != volumeRadius;
}
