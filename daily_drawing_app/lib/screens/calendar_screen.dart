// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:daily_drawing_app/providers/images_provider.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'utils.dart';

import 'add_images_screen.dart';

import '../widgets/bottom_navigator.dart';

import 'package:provider/provider.dart';

import '../providers/images_provider.dart';

class CalendarScreen extends StatefulWidget {
  static const routeName = '/calendar';
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  bool firstTimeRendered = false;

  final ValueNotifier<List<Event>> _selectedEvents = ValueNotifier([]);

  // Using a `LinkedHashSet` is recommended due to equality comparison override
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    // print(kEvents);
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForDays(Set<DateTime> days) {
    // Implementation example
    // Note that days are in selection order (same applies to events)
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDays.clear();
      _selectedDays.add(selectedDay);
    });

    _selectedEvents.value = _getEventsForDays(_selectedDays);
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<GreatPlaces>(context, listen: false);
    final imagesDatas = imageProvider.events;

    var myDates = {
      DateTime.utc(2020, 5, 8): [
        Event('error'),
      ],
    };

    if (!firstTimeRendered) {
      firstTimeRendered = true;

      // print("First TIme");
      // print(_refreshImages(context));
      var imagesData = Provider.of<GreatPlaces>(context, listen: false).events;
      var lastKey = DateTime.utc(2020, 5, 1);
      List<Event> individualdateEvents = [];
      var thisEventDate;

      imagesData.forEach((element) {
        thisEventDate = DateTime.utc(element.dateTime.year,
            element.dateTime.month, element.dateTime.day);

        //also missed if there is now new one well you should o that then a third iteration is neeeded
        if (thisEventDate != lastKey) {
          individualdateEvents.clear();
        }

        lastKey = thisEventDate;

        individualdateEvents.add(Event(element.title));
        // print("I will add"+thisEventDate);
        // print(individualdateEvents);
        myDates.addAll({
          thisEventDate: [...individualdateEvents],
        });

        // print("Today Events:");
        // print(individualdateEvents);
        // print(myDates);

        //try finding the dates of the first one
      });

      // myDates.forEach((key, value) {
      //   print(key);
      //   print(value);
      // });
      kEvents..addAll(myDates);
    }

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
        body: Column(
          children: [
            // ##TODO add the counter here
            Text("${imageProvider.currentStreak}"),
            TableCalendar<Event>(
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              eventLoader: _getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              selectedDayPredicate: (day) {
                // Use values from Set to mark multiple days as selected
                return _selectedDays.contains(day);
              },
              onDaySelected: _onDaySelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          onTap: () => print('${value[index]}'),
                          title: Text('${value[index]}'),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigator(1, context));
  }
}
