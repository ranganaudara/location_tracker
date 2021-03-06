import 'package:flutter/material.dart';
import 'package:location_tracker/src/widgets/Button.dart';
import 'package:location_tracker/src/widgets/DropDownWidget.dart';
import 'package:location_tracker/src/widgets/TextInputWidget.dart';
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

  set string(String value) => setState(() => _selectedVehicleType = value);

  @override
  void initState() {
    super.initState();
  }

  List<String> _vehicleTypes = [
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
                style: Theme
                    .of(context)
                    .textTheme
                    .headline1,
                textAlign: TextAlign.center,
              ),
              TextInputWidget(
                controller: _vehicleNumberController,
                hintText: "Enter vehicle number",
                validatorMessage: "Please enter your vehicle number!",
              ),
              DropDownWidget(
                hintText: "Select vehicle type",
                validatorMessage: "Please select vehicle type",
                optionList: _vehicleTypes,
                getSelectedOption: (selectedValue)=> setState(()=> _selectedVehicleType = selectedValue),
              ),
              Button(
                name: "Save",
                buttonOnPressed: () {
                  if (_formKey.currentState.validate()) {
                    savePreferences(
                      _selectedVehicleType,
                      _vehicleNumberController.text,
                    ).then((value) => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LocationScreen()),
                          )
                        });
                  } else {
                    print("Not valid");
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> savePreferences(String type, String number) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('number', number);
  prefs.setString('type', type);
}
