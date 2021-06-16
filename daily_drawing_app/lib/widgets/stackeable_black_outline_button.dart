import 'package:flutter/material.dart';

class StackeableBlackOutlinedButton extends StatelessWidget {
  String title;

  Function onClickHandle;

  StackeableBlackOutlinedButton({this.title = "Button", this.onClickHandle});
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black26, width: .1),
                borderRadius: BorderRadius.circular(15)),
            minimumSize: Size(screenSize.width * .9, screenSize.height * .08),
            padding: EdgeInsets.symmetric(horizontal: 30),
            primary: Colors.transparent),
        child: Text(title, textAlign: TextAlign.right,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal)),
        onPressed: onClickHandle,
      ),
    );
  }
}
