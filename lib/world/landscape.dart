import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';

class Landscape extends StatelessWidget {
  final size;
  final position;
  final pointToScreen;

  Landscape({this.size, this.position, this.pointToScreen});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        foregroundPainter: LandscapePainter(
          size: this.size,
          position: this.position,
          pointToScreen: this.pointToScreen,
        ),
      );
  }
}

class LandscapePainter extends CustomPainter {
  Size size;
  double position;
  final pointToScreen;

  LandscapePainter({this.size, this.position, this.pointToScreen});

  @override
  void paint(Canvas canvas, Size size) {
    this.drawLandscape(canvas, this.size, this.position);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void drawLandscape(Canvas canvas, Size size, double position) {
    for (double depth = 8; depth >= 5; depth -= 0.05) {
      drawMountain(canvas, 5000*(pow(103, depth) % 100 - 50)/100, pow(2, depth), pow(2, depth), position, 2*depth);
    }
    for (double depth = 5; depth >= 2; depth -= 0.1) {
      drawHill(canvas, 300*sin(depth*100), pow(2, depth)*300, pow(2, depth)*10, position, depth*2);
    }
    for (double depth = 2; depth >= 1.5; depth -= 0.05) {
      drawMountain(canvas, 5000*(pow(103, depth) % 100 - 50)/100, pow(2, depth-0.5)*200, pow(2, depth-0.5)*100, position, 2*depth);
    }
    // for (double depth = 1.5; depth >= 1; depth -= 0.1) {
    //   drawHill(canvas, 5000*sin(depth*100), pow(2, depth)*1000, pow(2, depth)*100, position, depth);
    // }
  }

  void drawHill(Canvas canvas, double mountainPosition, double width, double height, double position, double depth) {
    Paint groundPaint = new Paint()
    ..color = Colors.green[200]
    ..style = PaintingStyle.fill;

    Path path = Path();
    path.addOval(
      Rect.fromPoints(
        pointToScreen(Offset(mountainPosition, 0 - height/3,), depth, false),
        pointToScreen(Offset(mountainPosition + width, 0 - height/3 + height,), depth, false),
      )
    );
    canvas.drawPath(path, groundPaint);

    path = Path();
    groundPaint.color = Colors.green[400];
    path.addOval(
      Rect.fromPoints(
        pointToScreen(Offset(mountainPosition, 0 - height/3,), depth, false),
        pointToScreen(Offset(mountainPosition + width-10, 0 - height/3 + height,), depth, false),
      )
    );
    canvas.drawPath(path, groundPaint);
  }

  void drawMountain(Canvas canvas, double mountainPosition, double width, double height, double position, double depth) {
    Paint groundPaint = new Paint()
    ..color = Colors.blueGrey
    ..style = PaintingStyle.fill;

    Path path = Path();
    path.addPolygon(
      [
        pointToScreen(Offset(mountainPosition, 0), depth, false,),
        pointToScreen(Offset(mountainPosition + width/2, 0 - height), depth, false,),
        pointToScreen(Offset(mountainPosition + width, 0), depth, false,),
      ],
      true
    );
    canvas.drawPath(path, groundPaint);

    path = Path();
    groundPaint.color = Colors.grey;
    path.addPolygon(
      [
        pointToScreen(Offset(mountainPosition + width/2, 0 - height), depth, false,),
        pointToScreen(Offset(mountainPosition + width, 0), depth, false,),
        pointToScreen(Offset(mountainPosition + width - width/10, 0), depth, false,),
      ],
      true
    );
    canvas.drawPath(path, groundPaint);

    path = Path();
    groundPaint.color = Colors.black45;
    path.addPolygon(
      [
        pointToScreen(Offset(mountainPosition, 0), depth, false,),
        pointToScreen(Offset(mountainPosition + width/2, 0 - height), depth, false,),
        pointToScreen(Offset(mountainPosition + width/20, 0), depth, false,),
      ],
      true
    );
    canvas.drawPath(path, groundPaint);

    path = Path();
    groundPaint.color = Colors.white;
    path.addPolygon(
      [
        pointToScreen(Offset(mountainPosition + width/2 - width/10, 0 - height + height/5), depth, false,),
        pointToScreen(Offset(mountainPosition + width/2, 0 - height), depth, false,),
        pointToScreen(Offset(mountainPosition + width/2 + width/10, 0 - height + height/5), depth, false,),
        pointToScreen(Offset(mountainPosition + width/2 - width/50, 0 - height + height/8), depth, false,),
      ],
      true
    );
    canvas.drawPath(path, groundPaint);
  }

}
