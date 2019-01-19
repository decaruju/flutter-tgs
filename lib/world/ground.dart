import 'package:flutter/material.dart';
import 'dart:ui';

class Ground extends StatelessWidget {
  final size;
  final position;

  Ground({this.size, this.position});

  @override
  Widget build(BuildContext context) {
    return CustomPaint( 
        foregroundPainter: GroundPainter(
          size: this.size,
          position: this.position
        ),
      );
  }
}

class GroundPainter extends CustomPainter {
  Size size;
  double position;

  GroundPainter({this.size, this.position});

  @override
  void paint(Canvas canvas, Size size) {
    this.drawGround(canvas, this.size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void drawGround(Canvas canvas, Size size) {
    Paint groundPaint = new Paint()
      ..color = Colors.brown
      ..style = PaintingStyle.fill;

    canvas.drawRect(new Rect.fromLTRB(0, 2*size.height/3, size.width, size.height), groundPaint);
    groundPaint.color = groundPaint.color.withAlpha(200);
    canvas.drawRect(new Rect.fromLTRB(0, 2*size.height/3 - 10, size.width, size.height), groundPaint);
    groundPaint.color = Colors.black12;
  }
}
