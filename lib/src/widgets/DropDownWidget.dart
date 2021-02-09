import 'package:flutter/material.dart';

typedef void StringCallback(String val);

class DropDownWidget extends StatefulWidget {
  final String validatorMessage;
  final String hintText;
  final List<String> optionList;
  final StringCallback getSelectedOption;

  DropDownWidget(
      {this.validatorMessage, this.hintText, this.optionList, this.getSelectedOption});

  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          child: Text(widget.hintText),
        ),
        value: selectedValue,
        onChanged: (newValue) {
          widget.getSelectedOption(newValue);
          setState(() {
            selectedValue = newValue;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return widget.hintText;
          }
          return null;
        },
        items: widget.optionList.map((option) {
          return DropdownMenuItem(
            child: Text(option),
            value: option,
          );
        }).toList(),
      ),
    );
  }
}
