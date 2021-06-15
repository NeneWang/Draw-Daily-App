import 'package:flutter/material.dart';

class BottomNavigator extends StatelessWidget {
  final int indexNavigator;
  final BuildContext context;

  BottomNavigator(this.indexNavigator, this.context);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: true,
      showUnselectedLabels: false,
      backgroundColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.white,
      selectedItemColor: Theme.of(context).accentColor,
      currentIndex: indexNavigator,
      // type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).primaryColor,
          icon: Icon(Icons.photo),
          title: Text('My Images'),
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).primaryColor,
          icon: Icon(Icons.calendar_today_rounded),
          title: Text('Calendar'),
        ),
      ],
    );
  }
}
