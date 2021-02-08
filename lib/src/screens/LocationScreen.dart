import 'package:flutter/material.dart';
import 'package:location_tracker/src/widgets/Button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String _status = "Stopped";
  final Location location = Location();
  bool _enabled;
  String _error;

  PermissionStatus _permissionGranted;

  //Check Permission
  Future<PermissionStatus> _checkPermissions() async {
    final PermissionStatus permissionGrantedResult =
        await location.hasPermission();
    return permissionGrantedResult;
  }

  //Request Permission
  Future<void> _requestPermission() async {
    if (_permissionGranted != PermissionStatus.granted) {
      final PermissionStatus permissionRequestedResult =
          await location.requestPermission();
      setState(() {
        _permissionGranted = permissionRequestedResult;
      });
    }
  }

  //Check Background Mode
  Future<void> _checkBackgroundMode() async {
    setState(() {
      _error = null;
    });
    final bool result = await location.isBackgroundModeEnabled();
    setState(() {
      _enabled = result;
    });
  }

  //Enable Background Mode
  Future<void> _toggleBackgroundMode() async {
    setState(() {
      _error = null;
    });
    try {
      final bool result =
      await location.enableBackgroundMode(enable: !(_enabled ?? false));
      setState(() {
        _enabled = result;
      });
    } on PlatformException catch (err) {
      setState(() {
        _error = err.code;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "LOCATION TRACKER",
            style: Theme.of(context).textTheme.headline1,
            textAlign: TextAlign.center,
          ),
          Text(
            "Press \"Start\" to feed the location...",
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          Text(
            "Status: $_status",
            style: Theme.of(context).textTheme.bodyText2,
            textAlign: TextAlign.center,
          ),
          Button(
            name: "Start",
            buttonOnPressed: () {},
          ),
          Button(
            name: "Pause",
          ),
          Button(
            name: "Stop",
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    getPreferences();
    _checkPermissions().then((value) => {
          if (_permissionGranted != PermissionStatus.granted)
            {_requestPermission()}
        });
    super.initState();
  }
}

getPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("number: " + prefs.getString('number'));
  print("type: " + prefs.getString('type'));
}
