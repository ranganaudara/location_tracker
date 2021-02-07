import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  String _status = "Stopped";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Press \"Start\" to feed the location...",
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
          ),
          Text(
            "Status: $_status",
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Material(
              borderRadius: BorderRadius.circular(32.0),
              color: Colors.blueAccent,
              shadowColor: Colors.blueAccent.shade100,
              elevation: 5.0,
              child: MaterialButton(
                minWidth: 150.0,
                height: 45.0,
                onPressed: () {

                },
                child: Text('Start', style: Theme.of(context).textTheme.button),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Material(
              borderRadius: BorderRadius.circular(32.0),
              color: Colors.blueAccent,
              shadowColor: Colors.blueAccent.shade100,
              elevation: 5.0,
              child: MaterialButton(
                minWidth: 150.0,
                height: 45.0,
                onPressed: () {

                },
                child: Text('Pause', style: Theme.of(context).textTheme.button),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Material(
              borderRadius: BorderRadius.circular(32.0),
              color: Colors.blueAccent,
              shadowColor: Colors.blueAccent.shade100,
              elevation: 5.0,
              child: MaterialButton(
                minWidth: 150.0,
                height: 45.0,
                onPressed: () {

                },
                child: Text('Stop', style: Theme.of(context).textTheme.button),
              ),
            ),
          ),
        ],
      ),
    );
  }



  @override
  void initState() {
    getPreferences();
  }
}

getPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("number: "+prefs.getString('number'));
  print("type: "+ prefs.getString('type'));
}