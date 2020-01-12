import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:past_papers/constants/constants.dart';
import 'package:past_papers/core/Base/BaseView.dart';
import 'package:past_papers/core/models/SubjectModel.dart';
import 'package:past_papers/core/view_models/PapersViewModel.dart';
import 'package:past_papers/ui/widgets/FilterOptionBar.dart';
import 'package:past_papers/ui/widgets/PaperListView.dart';

class PapersView extends StatelessWidget {
  final Subject subject;
  PapersView({this.subject});
  @override
  Widget build(BuildContext context) {
    return BaseView<PapersViewModel>(
      builder: (BuildContext context, PapersViewModel model, Widget child) =>
          SafeArea(
        child: Scaffold(
          //to extend the body even behind the bottom app bar
          extendBody: true,
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            leading: model.isSearching
                ? IconButton(
                    color: kPrimaryColor,
                    icon: Icon(FontAwesomeIcons.times),
                    onPressed: () {
                      model.cancleSearch();
                    },
                  )
                : null,
            centerTitle: !model.isSearching,
            backgroundColor: Colors.white,
            title: model.isSearching
                ? Container(
                    width: double.infinity,
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                          hintText: 'Search here...', border: InputBorder.none),
                      onChanged: (value) => model.search(value),
                    ),
                  )
                : Hero(
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
          body: PaperListView(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            child: model.isSearching
                ? const Icon(FontAwesomeIcons.times)
                : const Icon(FontAwesomeIcons.search),
            backgroundColor: Colors.white,
            foregroundColor: kPrimaryColor,
            onPressed: () =>
                model.isSearching ? model.cancleSearch() : model.search(''),
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
