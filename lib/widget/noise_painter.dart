import 'dart:math';
import 'package:flutter/material.dart';

class NoisePainter extends CustomPainter {
  final Animation<double> animation;
  final Random _random = Random();

  NoisePainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withOpacity(0.04);
    int numberOfDots = (size.width * size.height * 0.02).toInt();
    for (int i = 0; i < numberOfDots; i++) {
      final double x = _random.nextDouble() * size.width;
      final double y = _random.nextDouble() * size.height;
      final double radius = _random.nextDouble() * 1.0 + 0.5;
      paint.color = Colors.black.withOpacity(0.04 + _random.nextDouble() * 0.02);
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant NoisePainter oldDelegate) =>
      oldDelegate.animation.value != animation.value;
}
