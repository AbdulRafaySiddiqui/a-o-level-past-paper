import 'package:flutter/material.dart';
import 'package:past_papers/ui/widgets/McqToggleButton.dart';

class McqSolver extends StatelessWidget {
  McqSolver({this.mcqList, this.liveCheck});
  final List<int> mcqList;
  final bool liveCheck;
  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    for (var i = 0; i < mcqList.length; i++) {
      list.add(McqToggleButton(
        correctAns: mcqList[i],
        liveCheck: liveCheck,
        index: i,
      ));
    }
    return ListView(children: list, addAutomaticKeepAlives: true);
  }
}
