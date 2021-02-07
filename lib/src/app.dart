import 'package:flutter/material.dart';

import 'Screens/HomeScreen.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.grey,
        accentColor: Colors.blueGrey,
        disabledColor: Colors.grey,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        buttonColor: Colors.blue,
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
          button: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal, color: Colors.white),

          // headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          // title: TextStyle(
          //     fontSize: 30.0,
          //     fontStyle: FontStyle.normal,
          //     fontWeight: FontWeight.bold),
          // subtitle: TextStyle(
          //   fontSize: 18.0,
          //   fontStyle: FontStyle.normal,
          // ),
          // body1: TextStyle(
          //   fontSize: 14.0,
          //   fontFamily: 'Hind',
          // ),
        ),
      ),
      home: SafeArea(child: HomeScreen()),
    );
  }
}
