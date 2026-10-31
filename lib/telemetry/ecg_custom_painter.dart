import 'dart:math' as math;
import 'package:flutter/material.dart';

class EcgWaveformPainter extends CustomPainter {
  final List<double> dataPoints;
  final Color traceColor;

  EcgWaveformPainter({
    required this.dataPoints,
    this.traceColor = const Color(0xFF10B981),
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (dataPoints.isEmpty) return;

    final paint = Paint()
      ..color = traceColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    final path = Path();
    final double stepX = size.width / math.max(dataPoints.length - 1, 1);
    final double midY = size.height / 2;

    for (int i = 0; i < dataPoints.length; i++) {
      final double x = i * stepX;
      final double y = midY - (dataPoints[i] * (size.height * 0.4));
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant EcgWaveformPainter oldDelegate) => true;
}