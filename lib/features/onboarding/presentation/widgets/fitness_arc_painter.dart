// lib/features/onboarding/presentation/widgets/fitness_arc_painter.dart

import 'package:flutter/material.dart';
import 'dart:math';

class FitnessArcPainter extends CustomPainter {
  final int level;
  final int maxLevel;
  static const Color primaryColor = Colors.teal;
  static const double _strokeWidth = 6.0;
  static const double _thumbRadius = 12.0;
  static const double _thumbBorderRadius = 16.0;

  // Arc parameters (210° to 330°)
  static const double _startAngle = pi * 1.1667; // 210 degrees
  static const double _sweepAngle = pi * 0.6667; // 120 degrees
  static const double _centerOffset = 1.5;

  FitnessArcPainter({required this.level, required this.maxLevel});

  @override
  void paint(Canvas canvas, Size size) {
    _drawInactiveArc(canvas, size);
    _drawActiveArc(canvas, size);
    _drawThumb(canvas, size);
    _drawLevelMarkers(canvas, size);
  }

  void _drawInactiveArc(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white24
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth
      ..strokeCap = StrokeCap.round;

    final rect = _getArcRect(size);
    canvas.drawArc(rect, _startAngle, _sweepAngle, false, paint);
  }

  void _drawActiveArc(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth
      ..strokeCap = StrokeCap.round;

    final rect = _getArcRect(size);
    final activeSweep = (level / maxLevel) * _sweepAngle;
    canvas.drawArc(rect, _startAngle, activeSweep, false, paint);
  }

  void _drawThumb(Canvas canvas, Size size) {
    final thumbPosition = _calculateThumbPosition(size);

    // Draw thumb fill
    final thumbPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(thumbPosition, _thumbRadius, thumbPaint);

    // Draw thumb border
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;
    canvas.drawCircle(thumbPosition, _thumbBorderRadius, borderPaint);
  }

  void _drawLevelMarkers(Canvas canvas, Size size) {
    for (int i = 0; i <= maxLevel; i++) {
      _drawLevelMarker(canvas, size, i);
    }
  }

  void _drawLevelMarker(Canvas canvas, Size size, int markerLevel) {
    final markerPosition = _calculateMarkerPosition(size, markerLevel);
    final isActive = markerLevel == level;

    final markerPaint = Paint()
      ..color = isActive ? primaryColor : Colors.white54
      ..style = PaintingStyle.fill;

    final markerRadius = isActive ? 4.0 : 3.0;
    canvas.drawCircle(markerPosition, markerRadius, markerPaint);
  }

  Offset _calculateThumbPosition(Size size) {
    final center = Offset(size.width / 2, size.height * _centerOffset);
    final radius = size.width * 0.9;
    final activeSweep = (level / maxLevel) * _sweepAngle;
    final thumbAngle = _startAngle + activeSweep;

    return Offset(
      center.dx + radius * cos(thumbAngle),
      center.dy + radius * sin(thumbAngle),
    );
  }

  Offset _calculateMarkerPosition(Size size, int markerLevel) {
    final center = Offset(size.width / 2, size.height * _centerOffset);
    final radius = size.width * 0.9;
    final markerAngle = _startAngle + (markerLevel / maxLevel) * _sweepAngle;

    return Offset(
      center.dx + radius * cos(markerAngle),
      center.dy + radius * sin(markerAngle),
    );
  }

  Rect _getArcRect(Size size) {
    final center = Offset(size.width / 2, size.height * _centerOffset);
    final radius = size.width * 0.9;
    return Rect.fromCircle(center: center, radius: radius);
  }

  @override
  bool shouldRepaint(covariant FitnessArcPainter oldDelegate) {
    return oldDelegate.level != level || oldDelegate.maxLevel != maxLevel;
  }
}
