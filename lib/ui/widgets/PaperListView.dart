import 'package:flutter/material.dart';
import 'package:past_papers/constants/constants.dart';
import 'package:past_papers/core/Base/BaseView.dart';
import 'package:past_papers/core/view_models/PapersViewModel.dart';

class PaperListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<PapersViewModel>(
      builder: (BuildContext context, PapersViewModel model, Widget child) =>
          ListView.builder(
        itemCount: model.papers.length,
        itemBuilder: (BuildContext context, int index) {
          var paper = model.papers[index];
          return Card(
            elevation: 6.0,
            child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: kPrimaryColor,
                child: Text(
                  paper.year.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: kWhiteColor),
                ),
              ),
              title: Text(paper.title),
              subtitle: Text(paper.subtitle),
              trailing: Icon(paper.seasonIcon),
              onTap: () {
                model.navigate(paper);
              },
              onLongPress: () {
                model.selectPaper(paper);
              },
            ),
          );
        },
      ),
    );
  }
}
