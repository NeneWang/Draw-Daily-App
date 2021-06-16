import 'package:flutter/material.dart';

class StatHighlight extends StatelessWidget {
  Size screenSize;
  
  StatHighlight({@required this.screenSize});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenSize.width / 4,
      height: screenSize.height / 8,
      child: Card(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('5',),
          Text('Streaks'),
        ],
      )),
    );
  }
}
