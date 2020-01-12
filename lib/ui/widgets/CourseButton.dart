import 'package:flutter/material.dart';
import 'package:past_papers/constants/constants.dart';

class CourseButton extends StatelessWidget {
  CourseButton(
      {this.onPressed,
      this.isSelected = false,
      this.text,
      this.mainColor = kPrimaryColor,
      this.selectedColor = kDarkPrimaryColor});

  final Function onPressed;
  final bool isSelected;
  final String text;
  final Color mainColor;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        elevation: 6.0,
        shape: CircleBorder(),
        fillColor: isSelected ? mainColor : Colors.white,
        constraints: BoxConstraints(minHeight: 150, minWidth: 150),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : mainColor,
          ),
        ));
  }
}
