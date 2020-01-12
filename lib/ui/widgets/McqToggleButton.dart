import 'package:flutter/material.dart';
import 'package:past_papers/constants/constants.dart';

class McqToggleButton extends StatefulWidget {
  @override
  _McqToggleButtonState createState() => _McqToggleButtonState();
}

class _McqToggleButtonState extends State<McqToggleButton> {
  List<bool> isSelected = List.generate(4, (_)=> false); 
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
  children: <Widget>[
    Text('A'),
    Text('B'),
    Text('C'),
    Text('D'),
  ],
  fillColor: Colors.green,
  borderRadius: BorderRadius.circular(15.0),
  color: kBlackColor,
  selectedColor: kWhiteColor,
  onPressed: (int index) {
    setState(() {
      for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
        if (buttonIndex == index) {
          isSelected[buttonIndex] = true;
        } else {
          isSelected[buttonIndex] = false;
        }
      }
    });
  },
  isSelected: isSelected,
);
  }
}