import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

class Sky extends StatelessWidget {
  final sunlight;
  final size;

  Sky({this.sunlight, this.size});

  @override
  Widget build(BuildContext context) {
    return CustomPaint( 
      foregroundPainter: new SkyPainter(
        sunlight: this.sunlight,
        size: size,
      ),
    );
  }
}

class SkyPainter extends CustomPainter {
  double sunlight;
  Size size;

  SkyPainter({this.sunlight, this.size});

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint sky = new Paint()
      ..color = Color.fromARGB((sunlight*255).toInt(), 0, 100, 255)
      ..style = PaintingStyle.fill;
    canvas.drawPaint(sky);
  }
}
