import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/images_provider.dart';

import 'screens/add_images_screen.dart';
import 'screens/images_list_screen.dart';
import 'screens/image_detail_screen.dart';

import 'screens/calendar_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Images List',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: ImagesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
          ImagesListScreen.routeName: (ctx) => ImagesListScreen(),
          CalendarScreen.routeName: (ctx) => CalendarScreen(),

        },
      ),
    );
  }
}
