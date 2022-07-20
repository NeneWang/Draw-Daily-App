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
                  builder: (ctx, imagesData, ch) =>
                      imagesData.events.length <= 0
                          ? ch
                          : ListView.builder(
                              itemCount: imagesData.events.length,
                              itemBuilder: (ctx, i) => ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: FileImage(
                                    imagesData.events[i].image,
                                  ),
                                ),
                                title: Text(imagesData.events[i].title),
                                subtitle: Text(imagesData.events[i].dateTime
                                    .toIso8601String()),
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    ImageDetailScreen.routeName,
                                    arguments: imagesData.events[i].id,
                                  );
                                },
                              ),
                            ),
                ),
        ),
        bottomNavigationBar: BottomNavigator(0, context));
  }
}

