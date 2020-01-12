import 'package:flutter/material.dart';
import 'package:past_papers/core/Base/BaseView.dart';
import 'package:past_papers/core/models/SubjectModel.dart';
import 'package:past_papers/core/view_models/SubjectsViewModel.dart';

class SubjectTile extends StatelessWidget {
  final Subject subject;
  SubjectTile(this.subject);
  @override
  Widget build(BuildContext context) {
    return BaseView<SubjectsViewModel>(
      builder: (context, model, child) => Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: FlatButton(
          padding: EdgeInsets.all(0.0),
          onPressed: () {
            model.navigate(subject);
          },
          child: Card(
              elevation: 3.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Hero(
                      tag: subject.name,
                      child: Material(
                        child: Text(
                          subject.name,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.all(2.0),
                    onPressed: () {
                      model.toggleSubjectFavorite(subject);
                    },
                    icon: Icon(
                      subject.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
