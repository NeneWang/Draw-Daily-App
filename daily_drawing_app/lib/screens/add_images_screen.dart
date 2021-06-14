import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../widgets/location_input.dart';
import '../providers/images_provider.dart';
import '../models/ImageData.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  List<String> selectedTags = [];

  final _titleController = TextEditingController();
  final _tagsController = TextEditingController();

  File _pickedImage;
  PlaceLocation _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _addTag(String tagName) {
    setState(() {
      selectedTags.add(tagName);
    });
    print(selectedTags);
  }

  Iterable<Widget> get getTagsWidgets sync* {
    for (final String tagName in selectedTags) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: Chip(
          label: Text(tagName),
          onDeleted: () {
            setState(() {
              selectedTags.removeWhere((itemName) {
                return tagName == itemName;
              });
            });
          },
        ),
      );
    }
  }

  void _savePlace() {
    //Only the picked Image is necessary
    if (_pickedImage == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false).addImage(
        _titleController.text, _pickedImage, DateTime.now().toIso8601String());
    Navigator.of(context).pop();

    // print("Saving Place");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration:
                          InputDecoration(labelText: 'Title (optional)'),
                      controller: _titleController,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Tags (optional)'),
                      controller: _tagsController,
                      onSubmitted: _addTag,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Wrap(
                              spacing: 10,
                              children: getTagsWidgets.toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                    SizedBox(
                      height: 10,
                    ),
                    // LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            onPressed: _savePlace,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}
