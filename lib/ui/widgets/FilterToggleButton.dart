import 'package:flutter/material.dart';
import 'package:past_papers/constants/constants.dart';
import 'package:past_papers/ui/widgets/CustomToggleButton.dart';

class IconModel {
  IconModel({this.icon, this.title});
  IconData icon;
  String title;
}

class FilterButton extends StatelessWidget {
  FilterButton(
      {@required this.children,
      @required this.isSelected,
      @required this.onPressed,
      this.addTitle = false});
  final List<IconModel> children;
  final List<bool> isSelected;
  final Function(int) onPressed;
  final bool addTitle;
  @override
  Widget build(BuildContext context) {
    IconData selectedIcon = children[isSelected
                .indexOf(isSelected.firstWhere((value) => value == true)) ??
            0]
        .icon;
    return IconButton(
      icon: Icon(selectedIcon),
      color: kWhiteColor,
      onPressed: () {
        showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  topLeft: Radius.circular(15.0)),
            ),
            context: context,
            builder: (context) {
              return BaseFilterToggleButton(
                children: children,
                isSelected: isSelected,
                addTitle: addTitle,
                onPressed: (int value) {
                  onPressed(value);
                  Navigator.of(context).pop();
                },
              );
            });
      },
    );
  }
}

class BaseFilterToggleButton extends StatelessWidget {
  BaseFilterToggleButton(
      {@required this.children,
      @required this.isSelected,
      @required this.onPressed,
      this.addTitle = false});
  final List<IconModel> children;
  final List<bool> isSelected;
  final Function(int) onPressed;
  final bool addTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.0,
      child: Center(
        child: CustomToggleButtons(
          selectedColor: Colors.blue,
          isSelected: isSelected,
          renderBorder: false,
          fillColor: Colors.transparent,
          borderColor: Colors.transparent,
          children: addTitle
              ? children
                  .map(
                    (value) =>
                        Column(children: [Icon(value.icon), Text(value.title)]),
                  )
                  .toList()
              : children
                  .map(
                    (value) => Icon(value.icon),
                  )
                  .toList(),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
