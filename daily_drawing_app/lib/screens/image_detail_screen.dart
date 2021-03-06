import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/images_provider.dart';
import './map_screen.dart';

class ImageDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';

  List<Widget> tagsWidget = [];

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<GreatPlaces>(context, listen: false).findById(id);


    final List<String> tags = selectedPlace.tags;
    if (tags != null) {
      selectedPlace.tags.forEach((element) {
        tagsWidget.add(Chip(label: Text(element)));
      });
    }

    // print(selectedPlace);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            selectedPlace.dateTime.toIso8601String(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Wrap(
                        spacing: 10,
                        children: tagsWidget,
                      ),
                    ),
                  ],
                ),
              ),
          // FlatButton(
          //   child: Text('View on Map'),
          //   textColor: Theme.of(context).primaryColor,
          //   onPressed: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         fullscreenDialog: true,
          //         builder: (ctx) => MapScreen(
          //           initialLocation: selectedPlace.dateTime,
          //           isSelecting: false,
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
