import 'package:flutter/material.dart';

import 'add_images_screen.dart';
import 'package:provider/provider.dart';
import '../providers/images_provider.dart';

import '../widgets/bottom_navigator.dart';
import '../widgets/stat_highlights.dart';

import '../widgets/black_outline_button.dart';

import '../widgets/stackeable_black_outline_button.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool firstTimeRendered = false;
  String streaksText;

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<GreatPlaces>(context, listen: false);
    final Size screenSize = MediaQuery.of(context).size;

    if (!firstTimeRendered) {
      firstTimeRendered = true;
      streaksText = imageProvider.currentStreak.toString();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.sync),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              StatHighlight(
                screenSize: screenSize,
                title: streaksText,
                description: "Streaks",
              ),
              StatHighlight(
                screenSize: screenSize,
                title: "1",
                description: "Weeks",
              ),
              StatHighlight(
                screenSize: screenSize,
                title: "6",
                description: "Drawings",
              ),
              StatHighlight(
                screenSize: screenSize,
                title: "5",
                description: "Max Streaks",
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlackOutlinedButton(
                title: "Upload Image",
                onClickHandle: () {
                  Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
                },
              ),
              SizedBox(
                width: 20,
              ),
              BlackOutlinedButton(
                title: "Get Prompt",
                onClickHandle: () {},
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              StackeableBlackOutlinedButton(
                title: "Settings",
                onClickHandle: () {},
              ),
              StackeableBlackOutlinedButton(
                title: "Notifications",
                onClickHandle: () {},
              ),
              StackeableBlackOutlinedButton(
                title: "About",
                onClickHandle: () {},
              ),
              StackeableBlackOutlinedButton(
                title: "Friends",
                onClickHandle: () {},
              ),
              StackeableBlackOutlinedButton(
                title: "Request Feature",
                onClickHandle: () {},
              ),
            ],
          )
        ]),
        bottomNavigationBar: BottomNavigator(2, context));
  }
}
