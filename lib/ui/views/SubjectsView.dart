import 'package:flutter/material.dart';
import 'package:past_papers/core/Base/BaseView.dart';
import 'package:past_papers/core/view_models/SubjectsViewModel.dart';
import 'package:past_papers/ui/widgets/SubjectTile.dart';

class SubjectsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<SubjectsViewModel>(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      gapPadding: 0.0,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: EdgeInsets.all(0.0),
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
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.all(0.0),
                  itemCount: model.subject.length,
                  itemBuilder: (BuildContext context, int index) =>
                      SubjectTile(model.subject[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
