import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location_tracker/src/widgets/Button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final Location location = Location();
  String _status = "Stopped";
  String _error;
  bool _backgroundModeEnabled;
  bool _serviceEnabled;
  LocationData _location;
  StreamSubscription<LocationData> _locationSubscription;
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
  Future<bool> _checkBackgroundMode() async {
    setState(() {
      _error = null;
    });
    final bool result = await location.isBackgroundModeEnabled();
    setState(() {
      _backgroundModeEnabled = result;
    });

    return result;
  }

  //Enable Background Mode
  Future<void> _toggleBackgroundMode() async {
    setState(() {
      _error = null;
    });
    try {
      final bool result =
      await location.enableBackgroundMode(enable: !(_backgroundModeEnabled ?? false));
      setState(() {
        _backgroundModeEnabled = result;
      });
    } on PlatformException catch (err) {
      setState(() {
        _error = err.code;
      });
    }
  }

  //Listen Location
  Future<void> _listenLocation() async {
    _locationSubscription =
        location.onLocationChanged.handleError((dynamic err) {
          setState(() {
            _error = err.code;
          });
          _locationSubscription.cancel();
        }).listen((LocationData currentLocation) {
          setState(() {
            _error = null;
            _location = currentLocation;
          });
        });
  }

  //Stop Listen
  Future<void> _stopListen() async {
    _locationSubscription.cancel();
  }

  //Check Service
  Future<bool> _checkService() async {
    final bool serviceEnabledResult = await location.serviceEnabled();
    setState(() {
      _serviceEnabled = serviceEnabledResult;
    });
    return serviceEnabledResult;
  }

  //Request Service
  Future<void> _requestService() async {
    if (_serviceEnabled == null || !_serviceEnabled) {
      final bool serviceRequestedResult = await location.requestService();
      setState(() {
        _serviceEnabled = serviceRequestedResult;
      });
      if (!serviceRequestedResult) {
        return;
      }
    }
  }


  _startOnPress(){
    _checkBackgroundMode().then((value) => {
      if(value){
        _toggleBackgroundMode()
      }
    });

    _listenLocation();
  }

  _pauseOnPress(){
    _stopListen();
  }

  _stopOnPress(){
    _stopListen();
    _toggleBackgroundMode();
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
            'Location: ' + (_error ?? '${_location ?? "unknown"}'),
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Button(
            name: "Start",
            buttonOnPressed: _startOnPress,
          ),
          Button(
            name: "Pause",
            buttonOnPressed: _pauseOnPress,
          ),
          Button(
            name: "Stop",
            buttonOnPressed: _stopOnPress,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    getPreferences();
    _checkPermissions().then((value) => {
          if (value != PermissionStatus.granted)
            _requestPermission()
        });
    _checkService().then((value) => {
      if(!value) _requestService()
    });

    super.initState();
  }
}

getPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("number: " + prefs.getString('number'));
  print("type: " + prefs.getString('type'));
}