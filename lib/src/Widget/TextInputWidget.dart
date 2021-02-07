import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {

  final TextEditingController controller;
  final String validatorMessage;
  final String hintText;


  TextInputWidget({this.controller, this.validatorMessage, this.hintText});

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: Theme.of(context).textTheme.bodyText1,
      validator: (value) {
        if (value.isEmpty) {
          return widget.validatorMessage;
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: widget.hintText,
      ),
    );
  }
}
