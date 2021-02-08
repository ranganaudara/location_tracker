import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback buttonOnPressed;
  final String name;


  Button({this.buttonOnPressed, this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(32.0),
        color: Colors.blueAccent,
        shadowColor: Colors.blueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          child: Text(name, style: Theme.of(context).textTheme.button),
          minWidth: 150.0,
          height: 45.0,
          onPressed: buttonOnPressed,
        ),
      ),
    );
  }
}
