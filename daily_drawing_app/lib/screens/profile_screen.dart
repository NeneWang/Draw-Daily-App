import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_images_screen.dart';
import '../providers/images_provider.dart';
import 'image_detail_screen.dart';

import '../widgets/bottom_navigator.dart';

class ProfileScreen extends StatelessWidget {
static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
            ),
          ],
        ),
        body: Column(),
        bottomNavigationBar: BottomNavigator(2, context));
  }
}
