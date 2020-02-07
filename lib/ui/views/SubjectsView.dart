import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:past_papers/core/Base/BaseView.dart';
import 'package:past_papers/core/Base/locator.dart';
import 'package:past_papers/core/view_models/SubjectsViewModel.dart';
import 'package:past_papers/ui/widgets/AddSubject.dart';
import 'package:past_papers/ui/widgets/SubjectTile.dart';

class SubjectsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<SubjectsViewModel>.withConsumer(
      viewModel: SubjectsViewModel(),
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 10.0, left: 10.0, top: 10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        hintText: 'Search ...',
                      ),
                      onChanged: (value) {
                        model.search(value);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    child: model.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.all(0.0),
                            itemCount: model.subject.length,
                            itemBuilder: (BuildContext context, int index) =>
                                SubjectTile(model.subject[index]),
                          ),
                  )
                ],
              ),
            ],
          ),
          floatingActionButton: isUserVersion
              ? Container()
              : FloatingActionButton(
                  child: Icon(FontAwesomeIcons.plus),
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) => AddSubject(),
                    );
                    model.loadSubjects();
                  },
                ),
        ),
      ),
    );
  }
}
