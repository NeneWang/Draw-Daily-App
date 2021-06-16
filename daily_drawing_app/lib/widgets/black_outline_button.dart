import 'package:flutter/material.dart';

class BlackOutlinedButton extends StatelessWidget {
  String title;

  BlackOutlinedButton({this.title = "Button"});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.symmetric(horizontal: 30),
          primary: Colors.transparent),
      child: Text(title,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      onPressed: () {},
    );
  }
}
