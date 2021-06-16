import 'package:flutter/material.dart';

class BlackOutlinedButton extends StatelessWidget {
  String title;

  Function onClickHandle;

  BlackOutlinedButton({this.title = "Button", this.onClickHandle});
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(60)),
          minimumSize: Size(screenSize.width * .45, screenSize.height * .075),
          padding: EdgeInsets.symmetric(horizontal: 30),
          primary: Colors.transparent),
      child: Text(title,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      onPressed: onClickHandle,
    );
  }
}
