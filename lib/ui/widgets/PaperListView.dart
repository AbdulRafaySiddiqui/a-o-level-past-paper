import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:past_papers/constants/constants.dart';
import 'package:past_papers/core/Base/locator.dart';
import 'package:past_papers/core/view_models/PapersViewModel.dart';
import 'package:past_papers/ui/widgets/AddPape.dart';
import 'package:provider/provider.dart';

class PaperListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PapersViewModel>(
      builder: (BuildContext context, PapersViewModel model, Widget child) =>
          ListView.builder(
        itemCount: model.papers.length,
        itemBuilder: (BuildContext context, int index) {
          var paper = model.papers[index];
          return Card(
            color: paper.isSelected ? kPrimaryColor : kWhiteColor,
            elevation: 6.0,
            child: ListTileTheme(
              selectedColor: kWhiteColor,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundColor:
                      paper.isSelected ? kWhiteColor : kPrimaryColor,
                  child: Text(
                    paper.year.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: paper.isSelected ? kPrimaryColor : kWhiteColor,
                    ),
                  ),
                ),
                title: Text(paper.title),
                subtitle: Text(paper.subtitle),
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
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Text('Delete Subject')),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: IconButton(
                                                padding: EdgeInsets.all(0),
                                                icon: Icon(
                                                    FontAwesomeIcons.times),
                                                color: Colors.red,
                                                onPressed: () =>
                                                    model.closeDialog(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Are you sure you want to delete this paper?',
                                          overflow: TextOverflow.clip,
                                        ),
                                        model.isDeleting
                                            ? CircularProgressIndicator()
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[
                                                  RaisedButton(
                                                    child: Text(
                                                      'Yes',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    color: Colors.green,
                                                    onPressed: () => model
                                                        .deletePaper(paper),
                                                  ),
                                                  RaisedButton(
                                                    child: Text('No',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                    color: Colors.red,
                                                    onPressed: () =>
                                                        model.closeDialog(),
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
                          model.loadPapers();
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
                            builder: (context) => AddPaper(
                              subjectId: null,
                              paper: paper,
                            ),
                          );
                          model.loadPapers();
                        },
                        icon: Icon(
                          FontAwesomeIcons.edit,
                          color: Colors.blue,
                        ),
                      ),
                    },
                    //season icon
                    Icon(paper.seasonIcon),
                  ],
                ),
                selected: paper.isSelected,
                onTap: () {
                  model.navigate(paper);
                },
                onLongPress: () {
                  model.selectPaper(paper);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
