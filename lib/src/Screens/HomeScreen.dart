import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LocationScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, double> userLocation;
  final _formKey = GlobalKey<FormState>();
  String _selectedVehicleType;
  final _vehicleNumberController = TextEditingController();
  bool _validate = false;

  @override
  void initState() {
    super.initState();
  }

  List<String> _locations = [
    'Car',
    'Van',
    'Bus',
    'Bike',
    'Three Wheeler',
    'Lorry',
    'Other'
  ];

  @override
  void dispose() {
    _vehicleNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "LOCATION TRACKER",
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
              TextFormField(
                controller: _vehicleNumberController,
                style: Theme.of(context).textTheme.bodyText1,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your vehicle number';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Enter Vehicle Number',
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 8.0),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 0.0001),
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodyText1,
                  hint: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Vehicle Type'),
                  ),
                  value: _selectedVehicleType,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedVehicleType = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your vehicle type';
                    }
                    return null;
                  },
                  items: _locations.map((location) {
                    return DropdownMenuItem(
                      child: Text(location),
                      value: location,
                    );
                  }).toList(),
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
                      if (_formKey.currentState.validate()) {
                        savePreferences(_selectedVehicleType, _vehicleNumberController.text, );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LocationScreen()),
                        );
                      } else {
                        print("Not valid");
                      }
                    },
                    child: Text('Save', style: Theme.of(context).textTheme.button),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



savePreferences(String type, String number) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('number', number);
  prefs.setString('type', type);
}
