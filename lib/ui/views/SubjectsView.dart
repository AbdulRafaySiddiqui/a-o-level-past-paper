import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:past_papers/core/Base/BaseView.dart';
import 'package:past_papers/core/Base/locator.dart';
import 'package:past_papers/core/view_models/SubjectsViewModel.dart';
import 'package:past_papers/ui/ads/FirebaseAdmobManager.dart';
import 'package:past_papers/ui/widgets/AddSubject.dart';
import 'package:past_papers/ui/widgets/SubjectTile.dart';

class SubjectsView extends StatefulWidget {
  @override
  _SubjectsViewState createState() => _SubjectsViewState();
}

class _SubjectsViewState extends State<SubjectsView> {
  @override
  void initState() {
    super.initState();
    // _admobManager.showBannerAd();
  }

  @override
  void dispose() {
    // _admobManager.removeBannerAd();
    super.dispose();
  }

  final FirebaseAdmobManager _admobManager = FirebaseAdmobManager();

  @override
  Widget build(BuildContext context) {
    int subjectcount = 0;
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
                            itemCount: model.subject.length
                            // + model.subject.length ~/ 5
                            ,
                            itemBuilder: (BuildContext context, int index) {
                              // if (index % 5 == 0)
                              //   return _admobManager.getBanner();
                              return SubjectTile(model.subject[subjectcount++]);
                            }),
                  ),
                  _admobManager.getBanner(),
                ],
              ),
            ],
          ),
          floatingActionButton: isUserVersion
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: FloatingActionButton(
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
      ),
    );
  }
}
