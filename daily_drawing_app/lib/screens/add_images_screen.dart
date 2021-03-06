import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../widgets/location_input.dart';
import '../providers/images_provider.dart';
import '../models/ImageData.dart';
import 'package:daily_drawing_app/utils/tools.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-images';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  List<String> selectedTags = [];

  final _titleController = TextEditingController();
  final _tagsController = TextEditingController();

  File _pickedImage;
  PlaceLocation _pickedLocation;

  Future<DateTime> selectedDate;
  String inputDate = "";

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _addTag(String tagName) {
  setState(() {
      selectedTags.add(tagName);
    });
    _tagsController.clear();
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
    var registerDate =
        inputDate == "" ? DateTime.now() : DateTime.parse(inputDate);
    Provider.of<GreatPlaces>(context, listen: false).addImage(
        _titleController.text == "" || _titleController.text == null
            ? " Progress ${Tools.getFormattedDateShortDateTime(registerDate)}  ${Tools.getFormattedTimeEventDateTime(DateTime.now())}"
            : _titleController.text,
        _pickedImage,
        registerDate.toIso8601String(),
        selectedTags);
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
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                    TextField(
                      decoration:
                          InputDecoration(labelText: 'Title (optional)'),
                      controller: _titleController,
                    ),
                    TextField(
                      decoration:
                          InputDecoration(labelText: 'Enter a tag (optional)'),
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
                              spacing: 5,
                              children: getTagsWidgets.toList(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          primary: Theme.of(context).accentColor),
                      child: Text(inputDate == "" ? "Today" : inputDate,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        showDialogPicker(context);
                      },
                    ),

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
            label: Text('Upload Image'),
            onPressed: _savePlace,
            elevation: 0,
            // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }

  void showDialogPicker(BuildContext context) {
    selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    selectedDate.then((value) {
      setState(() {
        if (value == null) return;
        inputDate = Tools.getFormattedDateSimple(value.millisecondsSinceEpoch);
      });

      print(DateTime.parse(inputDate).toUtc());
    }, onError: (error) {
      print(error);
    });
  }
}
