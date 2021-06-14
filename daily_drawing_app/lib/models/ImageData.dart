import 'dart:io';

import 'package:flutter/foundation.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });
}

class ImageData {
  final String id;
  final String title; //optional
  List<String> tags = [];
  List<String> meta_tags = [];
  final String user_id; //owners id
  // final PlaceLocation location;
  final File image;
  final DateTime dateTime;

  ImageData({
    @required this.id,
    this.title,
    this.tags,
    this.meta_tags,
    this.user_id,
    // @required this.location,
    @required this.image,
    @required this.dateTime
  });
}
