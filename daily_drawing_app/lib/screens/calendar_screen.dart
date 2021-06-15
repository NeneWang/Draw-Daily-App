import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_images_screen.dart';
import '../providers/images_provider.dart';
import 'image_detail_screen.dart';

import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';

import '../widgets/bottom_navigator.dart';

import 'pages/basics_example.dart';
// import 'pages/complex_example.dart';
// import 'pages/events_example.dart';
import 'pages/multi_example.dart';
import 'pages/range_example.dart';


class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

class CalendarScreen extends StatelessWidget {
  static const routeName = '/calendar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('View Progress'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_a_photo),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0),
              ElevatedButton(
                child: Text('Basics'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TableBasicsExample()),
                ),
              ),
              const SizedBox(height: 12.0),
              ElevatedButton(
                child: Text('Range Selection'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TableRangeExample()),
                ),
              ),
              const SizedBox(height: 12.0),
              ElevatedButton(
                child: Text('Multiple Selection'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TableMultiExample()),
                ),
              ),
              const SizedBox(height: 12.0),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigator(1, context));
  }
}
