import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:past_papers/constants/constants.dart';
import 'package:past_papers/core/Base/BaseView.dart';
import 'package:past_papers/core/models/SubjectModel.dart';
import 'package:past_papers/core/widgets_view_models.dart/AddSubjectViewModel.dart';

class AddSubject extends StatelessWidget {
  AddSubject({this.subject});
  final Subject subject;
  @override
  Widget build(BuildContext context) {
    return BaseView<AddSubjectViewModel>.withConsumer(
      viewModel: AddSubjectViewModel(subject),
      builder:
          (BuildContext context, AddSubjectViewModel model, Widget child) =>
              Center(
                child: Container(
                  height: 200,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: Material(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Column(
            children: <Widget>[
                Material(
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            model.edit ? 'Update Subject' : 'Add Subject',
                            style: TextStyle(
                                color: kWhiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(FontAwesomeIcons.times),
                          color: Colors.red,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      )
                    ],
                  ),
                  color: Colors.blue,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: model.controller,
                    decoration: InputDecoration(
                      errorText: model.isValid ? null : 'Name cannot be empty',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                      hintText: 'Type subject name...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onChanged: (value) => model.setName(value),
                  ),
                ),
                model.uploading
                    ? CircularProgressIndicator()
                    : RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          model.edit ? 'Update Subject' : 'Add Subject',
                          style: TextStyle(color: kWhiteColor),
                        ),
                        onPressed: () => model.addSubject(),
                      ),
            ],
          ),
        ),
      ),
              ),
    );
  }
}
