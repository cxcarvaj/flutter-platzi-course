import 'dart:async';

import 'package:flutter/material.dart';
import 'platzi_trips.dart';
import 'platzi_trips_cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Platzi Trips',
      //home: PlatziTrips()
      home: PlatziTripsCupertino(),
    );
  }
}
