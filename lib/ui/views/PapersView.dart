import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:past_papers/constants/constants.dart';
import 'package:past_papers/core/Base/BaseView.dart';
import 'package:past_papers/core/Base/locator.dart';
import 'package:past_papers/core/models/SubjectModel.dart';
import 'package:past_papers/core/view_models/PapersViewModel.dart';
import 'package:past_papers/ui/widgets/AddMcq.dart';
import 'package:past_papers/ui/widgets/AddPape.dart';
import 'package:past_papers/ui/widgets/AddSubject.dart';
import 'package:past_papers/ui/widgets/FilterBar.dart';
import 'package:past_papers/ui/widgets/PaperListView.dart';

class PapersView extends StatelessWidget {
  final Subject subject;
  PapersView({this.subject});
  @override
  Widget build(BuildContext context) {
    return BaseView<PapersViewModel>.withConsumer(
      viewModel: PapersViewModel(subject),
      builder: (BuildContext context, PapersViewModel model, Widget child) =>
          SafeArea(
        child: Scaffold(
          //to extend the body even behind the bottom app bar
          extendBody: true,
          resizeToAvoidBottomPadding: false,
          appBar: model.selectedPaper != null
              //paper selection dismiss bar
              ? AppBar(
                  backgroundColor: kWhiteColor,
                  leading: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.times,
                      color: kPrimaryColor,
                    ),
                    onPressed: () {
                      model.canclePaperSelection();
                    },
                  ),
                  title: Text(
                    'Select one more to view both together',
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: kBlackColor,
                    ),
                  ),
                )
              : model.isSearching
                  //search bar
                  ? AppBar(
                      leading: IconButton(
                        color: kPrimaryColor,
                        icon: Icon(FontAwesomeIcons.times),
                        onPressed: () {
                          model.cancleSearch();
                        },
                      ),
                      centerTitle: false,
                      backgroundColor: Colors.white,
                      title: Container(
                        width: double.infinity,
                        child: TextField(
                          autofocus: true,
                          decoration: InputDecoration(
                              hintText: 'Search here...',
                              border: InputBorder.none),
                          onChanged: (value) => model.search(value),
                        ),
                      ),
                    )
                  //subject name bar
                  : AppBar(
                      backgroundColor: kWhiteColor,
                      centerTitle: true,
                      title: Hero(
                        tag: subject.name,
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            subject.name,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              PaperListView(),
              if (!isUserVersion)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0, bottom: 60.0),
                    child: FloatingActionButton(
                      child: Icon(FontAwesomeIcons.plus),
                      heroTag: 'addPaper',
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (context) =>
                              AddPaper(subjectId: subject.subjectId),
                        );
                        model.loadPapers();
                      },
                    ),
                  ),
                )
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            heroTag: 'search',
            child: model.isSearching
                ? const Icon(FontAwesomeIcons.times)
                : const Icon(FontAwesomeIcons.search),
            backgroundColor: Colors.white,
            foregroundColor: kPrimaryColor,
            onPressed: () =>
                model.isSearching ? model.cancleSearch() : model.startSearch(),
          ),
          bottomNavigationBar: BottomAppBar(
            child: FilterBar(),
            notchMargin: 6.0,
            shape: CircularNotchedRectangle(),
            clipBehavior: Clip.antiAlias,
          ),
        ),
      ),
    );
  }
}
