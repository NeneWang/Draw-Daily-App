import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_images_screen.dart';
import '../providers/images_provider.dart';
import 'image_detail_screen.dart';

import '../widgets/bottom_navigator.dart';
import '../widgets/stat_highlights.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.sync),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
            ),
          ],
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  StatHighlight(
                    screenSize: screenSize, title: "5", description: "Streaks",
                  )
                ],
              )
            ]),
        bottomNavigationBar: BottomNavigator(2, context));
  }
}
