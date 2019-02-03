import 'package:flutter/material.dart';

class Stats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              "Statsss",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ]
        ),
      )
    );
  }
}
