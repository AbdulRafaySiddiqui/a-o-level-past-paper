import 'package:flutter/material.dart';
import 'package:past_papers/constants/constants.dart';
import 'package:past_papers/core/Base/BaseView.dart';
import 'package:past_papers/core/widgets_view_models.dart/AddMcqViewModel.dart';
import 'package:past_papers/core/widgets_view_models.dart/McqViewModel.dart';
import 'package:past_papers/ui/widgets/CustomToggleButton.dart';
import 'package:provider/provider.dart';

class McqToggleButton extends StatefulWidget {
  McqToggleButton(
      {@required this.correctAns,
      @required this.liveCheck,
      @required this.index,
      this.isEditable = false});
  final int correctAns;
  final bool liveCheck;
  final int index;
  final bool isEditable;

  @override
  _McqToggleButtonState createState() => _McqToggleButtonState();
}

class _McqToggleButtonState extends State<McqToggleButton>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LimitedBox(
      maxHeight: 40,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: BaseView<McqViewModel>.withConsumer(
          viewModel: McqViewModel(
              edit: widget.isEditable,
              correctAns: widget.correctAns,
              liveCheck: widget.liveCheck,
              index: widget.index),
          onModelReady: (model) => model.setup(),
          builder: (BuildContext context, McqViewModel model, Widget child) =>
              Row(children: <Widget>[
            CircleAvatar(
              child: Text(
                //because index starts from 0 and we want to start from 1
                (model.index + 1).toString(),
                style:
                    TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.blue,
            ),
            Expanded(
              child: CustomToggleButtons(
                children: <Widget>[
                  Text('A'),
                  Text('B'),
                  Text('C'),
                  Text('D'),
                ],
                fillColor: !widget.liveCheck
                    ? Colors.blue
                    : model.isCorrect ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(15.0),
                color: kBlackColor,
                selectedColor: kWhiteColor,
                borderColor: !widget.liveCheck
                    ? Colors.blue
                    : model.isCorrect ? Colors.green : Colors.red,
                onPressed: (int index) {
                  if (widget.isEditable)
                    Provider.of<AddMcqViewModel>(context, listen: false)
                        .select(widget.index, index);
                  model.select(index);
                },
                isSelected: model.isSelected,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
