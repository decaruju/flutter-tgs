import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

class Sun extends StatelessWidget {
  final angle;
  final size;

  Sun({this.angle, this.size});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: this.angle,
      origin: Offset(this.size.width/2, 2*this.size.height/3),
      child: Transform.translate(
        offset: Offset(this.size.width/2, 2*this.size.height/3 + 100),
        child: CustomPaint( 
          foregroundPainter: new SunPainter(
            angle: this.angle,
            size: this.size,
          ),
        ),
      ),
    );
  }
}

class SunPainter extends CustomPainter {
  double angle;
  Size size;

  SunPainter({this.angle, this.size});

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint sun = new Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;
    canvas.drawCircle(new Offset(0, 0), 50, sun);
    sun.color = Colors.orangeAccent;
    canvas.drawCircle(new Offset(0, 0), 40 - 5*sin(50*this.angle), sun);
  }
}
