import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              "Developped by Aubrgin in Shawinigan",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            CustomPaint(
              foregroundPainter: LogoPainter(
                size: MediaQuery.of(context).size
              )
            ),
          ]
        ),
      )
    );
  }
}

class LogoPainter extends CustomPainter {
  Size size;

  LogoPainter({this.size});

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromPoints(
        Offset(-100,100),
        Offset(100,300),
      ),
      paint
    );
    Path path = Path();
    paint.color = Colors.green;
    path.addPolygon(
      [
        Offset(-100, 100),
        Offset(0, 100),
        Offset(-100, 200),
      ],
      true
    );
    canvas.drawPath(path, paint);
  }
}
