// lib/features/onboarding/presentation/widgets/fitness_arc_painter.dart

import 'package:fitness/common/res/colors.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class FitnessArcPainter extends CustomPainter {
  final int level;
  final int maxLevel;
  static const double _strokeWidth = 8.0;
  static const double _thumbRadius = 14.0;
  static const double _thumbBorderWidth = 4.0;

  static const double startAngle = pi * 1.16;
  static const double sweepAngle = pi * 0.66; 

  FitnessArcPainter({required this.level, required this.maxLevel});

  @override
  void paint(Canvas canvas, Size size) {
    _drawInactiveArc(canvas, size);
    _drawLevelMarkers(canvas, size);
    _drawActiveArc(canvas, size);
    _drawThumb(canvas, size);
  }

  void _drawInactiveArc(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.textPrimary
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth
      ..strokeCap = StrokeCap.round;

    final rect = _getArcRect(size);
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  void _drawActiveArc(Canvas canvas, Size size) {
    final paint = Paint()
      ..color =  AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth
      ..strokeCap = StrokeCap.round;

    final rect = _getArcRect(size);
    final activeSweep = (level / maxLevel) * sweepAngle;
    canvas.drawArc(rect, startAngle, activeSweep, false, paint);
  }

  void _drawThumb(Canvas canvas, Size size) {
    final thumbPosition = _calculateThumbPosition(size);

    // Draw white border first (larger circle)
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      thumbPosition,
      _thumbRadius + _thumbBorderWidth,
      borderPaint,
    );

    // Draw teal fill on top (smaller circle)
    final thumbPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;
    canvas.drawCircle(thumbPosition, _thumbRadius, thumbPaint);
  }

  void _drawLevelMarkers(Canvas canvas, Size size) {
    for (int i = 0; i <= maxLevel; i++) {
      _drawLevelMarker(canvas, size, i);
    }
  }

  void _drawLevelMarker(Canvas canvas, Size size, int markerLevel) {
    final markerPosition = _calculateMarkerPosition(size, markerLevel);
    
    final markerPaint = Paint()
      ..color = AppColors.textLightDark
      ..style = PaintingStyle.fill;

    canvas.drawCircle(markerPosition, 3.5, markerPaint);
  }

  Offset _calculateThumbPosition(Size size) {
    final center = _getCenter(size);
    final radius = _getRadius(size);
    final activeSweep = (level / maxLevel) * sweepAngle;
    final thumbAngle = startAngle + activeSweep;

    return Offset(
      center.dx + radius * cos(thumbAngle),
      center.dy + radius * sin(thumbAngle),
    );
  }

  Offset _calculateMarkerPosition(Size size, int markerLevel) {
    final center = _getCenter(size);
    final radius = _getRadius(size);
    final markerAngle = startAngle + (markerLevel / maxLevel) * sweepAngle;

    return Offset(
      center.dx + radius * cos(markerAngle),
      center.dy + radius * sin(markerAngle),
    );
  }

  Offset _getCenter(Size size) {
    return Offset(size.width / 2, size.height * 0.75);
  }

  double _getRadius(Size size) {
    return size.width * 0.55;
  }

  Rect _getArcRect(Size size) {
    final center = _getCenter(size);
    final radius = _getRadius(size);
    return Rect.fromCircle(center: center, radius: radius);
  }

  @override
  bool shouldRepaint(covariant FitnessArcPainter oldDelegate) {
    return oldDelegate.level != level || oldDelegate.maxLevel != maxLevel;
  }
}