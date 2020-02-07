import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:past_papers/constants/constants.dart';
import 'package:past_papers/core/Base/BaseView.dart';
import 'package:past_papers/core/widgets_view_models.dart/AddMcqViewModel.dart';
import 'package:past_papers/ui/widgets/McqToggleButton.dart';

class AddMcq extends StatelessWidget {
  AddMcq({@required this.paperId});
  final String paperId;
  @override
  Widget build(BuildContext context) {
    return BaseView<AddMcqViewModel>.withConsumer(
      viewModel: AddMcqViewModel(paperId),
      builder: (BuildContext context, AddMcqViewModel model, Widget child) =>
          ListView(addAutomaticKeepAlives: true, children: [
        //add / remove buttons
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(FontAwesomeIcons.plus),
                onPressed: () => model.addMcq(),
                color: Colors.blue,
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.minus),
                onPressed: () => model.removeMcq(),
                color: Colors.blue,
              ),
            ],
          ),
        ),
        // mcq list
        for (var index = 0; index < model.mcq.mcqAns.length; index++) ...{
          McqToggleButton(
            liveCheck: false,
            index: index,
            correctAns: model.mcq.mcqAns[index],
            isEditable: true,
          )
        },
        // add / update button
        model.uploading
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: RaisedButton(
                  color: Colors.blue,
                  textColor: kWhiteColor,
                  child: Text(model.edit ? 'Update MCQ' : 'Save MCQ'),
                  onPressed: () => model.save(),
                ),
              )
      ]),
    );
  }
}
