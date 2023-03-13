import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';

class CirclePainter extends CustomPainter {
  final double progress;
  final int circles;
  final bool showDots;
  final bool showPath;

  CirclePainter(
      {required this.circles,
      required this.showDots,
      required this.showPath,
      required this.progress});

  Paint paints = Paint()
    ..color = Colors.black
    ..strokeWidth = 4.0
    ..style = PaintingStyle.stroke
    ..strokeJoin = StrokeJoin.round;

  @override
  void paint(Canvas canvas, Size size) {
    var path = createPath();
    PathMetrics pathMetrics = path.computeMetrics();
    for (PathMetric pathMetric in pathMetrics) {
      Path extractPath = pathMetric.extractPath(
        0.0,
        pathMetric.length * progress,
      );

      if(showPath){
        canvas.drawPath(extractPath, paints);
      }
      if(showDots){
        try {
          var metric = extractPath.computeMetrics().first;
          final offset = metric.getTangentForOffset(metric.length)?.position;
          canvas.drawCircle(offset!, 8.0, Paint());
        } catch (e) {}
      }

    }
    // path.addOval(Rect.fromCircle(center: Offset(0, 0), radius: 80.0));
    // canvas.drawPath(path, paints);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }

  Path createPath() {
    var path = Path();
    var circles = 6;
    int n = circles.toInt();
    var range = List<int>.generate(n, (i) => i + 1);
    var radius = 80.0;
    double angle = 2 * pi / n;
    for (int i in range) {
      double x = radius * cos(i * angle);
      double y = radius * sin(i * angle);
      path.addOval(Rect.fromCircle(center: Offset(x, y), radius: radius));
    }
    return path;
  }
}
