import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_images_screen.dart';
import '../providers/images_provider.dart';
import 'image_detail_screen.dart';

import '../widgets/bottom_navigator.dart';

class ImagesListScreen extends StatelessWidget {
  static const routeName = '/images-list';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Images'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_a_photo),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetImages(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<GreatPlaces>(
                  child: Center(
                    child: const Text('Got no places yet, start adding some!'),
                  ),
                  builder: (ctx, greatPlaces, ch) =>
                      greatPlaces.events.length <= 0
                          ? ch
                          : ListView.builder(
                              itemCount: greatPlaces.events.length,
                              itemBuilder: (ctx, i) => ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: FileImage(
                                    greatPlaces.events[i].image,
                                  ),
                                ),
                                title: Text(greatPlaces.events[i].title),
                                subtitle: Text(greatPlaces.events[i].dateTime
                                    .toIso8601String()),
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    PlaceDetailScreen.routeName,
                                    arguments: greatPlaces.events[i].id,
                                  );
                                },
                              ),
                            ),
                ),
        ),
        bottomNavigationBar: BottomNavigator(0, context));
  }
}

