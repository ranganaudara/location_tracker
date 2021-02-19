import 'package:flutter/material.dart';
import 'package:location_tracker/src/widgets/CustomProgressIndicator.dart';
import 'package:location_tracker/src/widgets/Error.dart';
import 'screens/HomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
          button: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
      ),
      // home: SafeArea(child: HomeScreen()),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            print(snapshot.error.toString());
            return CustomErrorWidget(errorMessage: snapshot.error.toString(),);
            // return CustomErrorWidget(errorMessage: "Error connecting to firebase. Try again!",);
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return SafeArea(child: HomeScreen());
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return CustomProgressIndicator();
        },
      ),
    );
  }
}
