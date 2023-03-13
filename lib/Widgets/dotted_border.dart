

import 'package:flutter/material.dart';

class DottedBorderPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final PaintingStyle paintingStyle;

  DottedBorderPainter({
    this.strokeWidth = 1.0,
    this.color = Colors.black,
    this.paintingStyle = PaintingStyle.stroke,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = paintingStyle
      ..strokeCap = StrokeCap.round;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    double dashWidth = 5;
    double dashSpace = 5;

    Path dashPath = Path();
    dashPath.moveTo(0, 0);

    double distance = 0;
    bool draw = true;
    while (distance < size.width) {
      if (draw) {
        dashPath.lineTo(dashWidth, 0);
      } else {
        dashPath.moveTo(dashWidth, 0);
      }

      distance += dashWidth;
      draw = !draw;

      if (distance < size.width) {
        if (draw) {
          dashPath.moveTo(distance, 0);
        } else {
          dashPath.lineTo(distance, 0);
        }
      }
      distance += dashSpace;
    }

    canvas.drawPath(path, paint);
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
