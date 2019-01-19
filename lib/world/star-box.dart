import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

class StarBox extends StatelessWidget {
  final angle;
  final size;
  final seed;

  StarBox({this.angle, this.size, this.seed});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: this.angle,
      origin: new Offset(size.width/2, size.height/2-200),
      child: new CustomPaint( 
        foregroundPainter: new StarPainter(
          angle: this.angle,
          size: size,
          seed: this.seed
        ),
      ),
    );
  }
}

class StarPainter extends CustomPainter {
  double angle;
  Size size;
  int seed;

  StarPainter({this.angle, this.size, this.seed});

  @override
  void paint(Canvas canvas, Size size) {
    this.drawStars(canvas, this.size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void drawStars(Canvas canvas, Size size) {
    double bound = max(size.height, size.width);
    Paint starPaint = new Paint()
      ..color = Colors.white30
      ..style = PaintingStyle.fill;
    for (double x = -bound; x < bound; x++) {
      canvas.drawCircle(new Offset(x, sin(x)*bound), sin(20*x*this.seed) + 2, starPaint);
    }
  }
}