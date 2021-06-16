import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/ImageData.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<ImageData> _events = [];

  List<ImageData> get events {
    return [..._events];
  }

  int get currentStreak {
    // You get the streak by counting backwards the items
    print(_events[_events.length-1].title);

    return 1;
  }


  ImageData findById(String id) {
    return _events.firstWhere((place) => place.id == id);
  }

  Future<void> addImage(String pickedTitle, File pickedImage, String testDate,
      List<String> selectedTags) async {
    // final address = await LocationHelper.getPlaceAddress(
    //     pickedLocation.latitude, pickedLocation.longitude);
    // final updatedLocation = PlaceLocation(
    //   latitude: pickedLocation.latitude,
    //   longitude: pickedLocation.longitude,
    //   address: address,
    // );

    // print("uploading place");
    final newPlace = ImageData(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      dateTime: DateTime.parse(testDate),
      tags: selectedTags,
    );
    _events.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'dateTime': newPlace.dateTime.toIso8601String(),
      'tags': newPlace.tags.join(",")
    });
    // print("Successfully submitted");
    // print(newPlace.tags.join(","));
  }

  Future<void> fetchAndSetImages() async {
    final dataList = await DBHelper.getData('user_places');
    // print("Fetching");
    // print(dataList);
    _events = dataList
        .map(
          (item) => ImageData(
              id: item['id'],
              title: item['title'],
              image: File(item['image']),
              dateTime: DateTime.parse(item['dateTime']),
              tags: item['tags'] != null ? item['tags'].split(',') : null),
        )
        .toList();
    notifyListeners();
  }
}
