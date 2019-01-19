import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

class Moon extends StatelessWidget {
  final angle;
  final size;

  Moon({this.angle, this.size});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: this.angle,
      origin: Offset(this.size.width/2, 2*this.size.height/3),
      child: Transform.translate(
        offset: Offset(this.size.width/2, 2*this.size.height/3 - 100),
        child: CustomPaint(
          foregroundPainter: new MoonPainter(
            angle: this.angle,
            size: this.size,
          ),
        ),
      ),
    );
  }
}

class MoonPainter extends CustomPainter {
  double angle;
  Size size;

  MoonPainter({this.angle, this.size});

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint moon = new Paint()
      ..color = Colors.blueGrey
      ..style = PaintingStyle.fill;
    canvas.drawCircle(new Offset(size.width/2, size.height/2), 50, moon);
    moon.color = Colors.grey;
    canvas.drawCircle(new Offset(size.width/2, size.height/2 + 30), 10, moon);
    canvas.drawCircle(new Offset(size.width/2 + 20, size.height/2 - 10), 20, moon);
    canvas.drawCircle(new Offset(size.width/2 - 30, size.height/2), 15, moon);
  }
}
