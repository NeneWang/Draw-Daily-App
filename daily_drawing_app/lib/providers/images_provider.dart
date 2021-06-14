import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/ImageData.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<ImageData> _items = [];

  List<ImageData> get items {
    return [..._items];
  }

  ImageData findById(String id) {
    return _items.firstWhere((place) => place.id == id);
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

    print("uploading place");
    final newPlace = ImageData(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      dateTime: DateTime.parse(testDate),
      tags: selectedTags,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_images', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'dateTime': newPlace.dateTime,
      'tags': selectedTags.join(",")
    });
  }

  Future<void> fetchAndSetImages() async {
    final dataList = await DBHelper.getData('user_images');
    _items = dataList
        .map(
          (item) => ImageData(
              id: item['id'],
              title: item['title'],
              image: File(item['image']),
              dateTime: item['dateTime'],
              tags: item['tags'] != null ? null : item['tags'].split(',')),
        )
        .toList();
    notifyListeners();
  }
}
