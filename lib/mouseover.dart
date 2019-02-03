import 'dart:ui';
import 'package:flutter/material.dart';

class Mouseover extends StatelessWidget {
  bool visible;
  var confirmCallback;
  var cancelCallback;
  Text text;

  Mouseover(
      {this.visible,
      this.confirmCallback,
      this.cancelCallback,
      this.text,
  });

  @override
  Widget build(BuildContext context) {
         print(this.visible);
    return Offstage(
      offstage: !this.visible,
      child: Container(
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
