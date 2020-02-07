import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:past_papers/core/Base/locator.dart';
import 'package:past_papers/core/models/SubjectModel.dart';
import 'package:past_papers/core/view_models/SubjectsViewModel.dart';
import 'package:past_papers/ui/widgets/AddSubject.dart';
import 'package:provider/provider.dart';

class SubjectTile extends StatelessWidget {
  final Subject subject;
  SubjectTile(this.subject);
  @override
  Widget build(BuildContext context) {
    return Consumer<SubjectsViewModel>(
      builder: (context, model, child) => Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Card(
          elevation: 3.0,
          child: ListTile(
            onTap: () => model.navigate(subject),
            title: Hero(
              tag: subject.name,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  subject.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (!isUserVersion) ...{
                  //delete button
                  IconButton(
                    padding: EdgeInsets.all(2.0),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            height: 170,
                            child: Material(
                              clipBehavior: Clip.antiAlias,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Stack(
                                      children: [
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text('Delete Subject')),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(padding: EdgeInsets.all(0),
                                            icon:
                                                Icon(FontAwesomeIcons.times),
                                            color: Colors.red,
                                            onPressed: () =>
                                                model.closeDialoag(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Are you sure you want to delete ${subject.name}?',
                                      overflow: TextOverflow.clip,
                                    ),
                                    model.isDeleting
                                        ? CircularProgressIndicator()
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              RaisedButton(
                                                child: Text(
                                                  'Yes',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                color: Colors.green,
                                                onPressed: () => model
                                                    .deleteSubject(subject),
                                              ),
                                              RaisedButton(
                                                child: Text('No',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                                color: Colors.red,
                                                onPressed: () =>
                                                    model.closeDialoag(),
                                              )
                                            ],
                                          )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                      model.loadSubjects();
                    },
                    icon: Icon(
                      FontAwesomeIcons.trashAlt,
                      color: Colors.red,
                    ),
                  ),
                  //edit button
                  IconButton(
                    padding: EdgeInsets.all(2.0),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => AddSubject(
                          subject: subject,
                        ),
                      );
                      model.loadSubjects();
                    },
                    icon: Icon(
                      FontAwesomeIcons.edit,
                      color: Colors.blue,
                    ),
                  ),
                },
                //favorite button
                IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    model.toggleSubjectFavorite(subject);
                  },
                  icon: Icon(
                    subject.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
