// import 'package:dave_portfolio/widget/noise_painter.dart';
import 'package:flutter/material.dart';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({
    super.key,
    required this.cursorPosition,
    required this.screenSize,
    required this.noiseController,
  });

  final Offset cursorPosition;
  final AnimationController noiseController;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    final double alignX =
        (screenSize.width > 0)
            ? (cursorPosition.dx / screenSize.width) * 2 - 1
            : 0;
    final double alignY =
        (screenSize.height > 0)
            ? (cursorPosition.dy / screenSize.height) * 2 - 1
            : 0;
    final Alignment gradientCenter = Alignment(alignX, alignY);

    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: gradientCenter,
              radius: 1.5,
              colors: const [
                Color(0xFFADB5C0),
                Color(0xFF8895A5),
                Color(0xFF6A7D95),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),  
          child: Container(),
        ),
      ],
    );
  }
}
