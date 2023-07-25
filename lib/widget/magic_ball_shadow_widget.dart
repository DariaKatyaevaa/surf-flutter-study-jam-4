import 'package:flutter/material.dart';
import 'dart:math' as math;

class MagicBallShadow extends StatelessWidget {
  const MagicBallShadow({
    Key? key,
    required this.width,
    required this.height,
    required this.blurRadius,
    required this.color,
  }) : super(key: key);

  final double width;
  final double height;
  final double blurRadius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()..rotateX(math.pi / 2.1),
      origin: Offset(0, height + 32.0),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: blurRadius,
              color: color,
            ),
          ],
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
