import 'dart:ui';
import 'package:flutter/material.dart';

class Mouseover extends StatelessWidget {
  Offset offset;
  double position;
  bool visible;
  var confirmCallback;
  var cancelCallback;
  Text text;

  Mouseover(
      {this.offset,
      this.position,
      this.visible,
      this.confirmCallback,
      this.cancelCallback,
      this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !this.visible,
      child: Container(
        padding: EdgeInsets.only(
            left: this.offset.dx + position, top: this.offset.dy),
        child: Column(
          children: <Widget>[
            text,
            Row(
              children: <Widget>[
                MaterialButton(
                  child: Text("Confirm"),
                  color: Colors.blue,
                  onPressed: this.confirmCallback,
                ),
                MaterialButton(
                  child: Text("Cancel"),
                  color: Colors.blue,
                  onPressed: this.cancelCallback,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
