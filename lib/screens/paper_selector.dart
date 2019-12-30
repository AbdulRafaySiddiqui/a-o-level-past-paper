import 'package:past_papers/components/BottomAppBar.dart';
import 'package:past_papers/components/PaperListView.dart';
import 'package:past_papers/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:past_papers/tempData.dart';

bool search = false;

class PaperSelector extends StatefulWidget {
  static String id = 'paperSelector';

  PaperSelector({this.courseName = 'Accounting (9852)'});
  final String courseName;
  @override
  _PaperSelectorState createState() => _PaperSelectorState();
}

class _PaperSelectorState extends State<PaperSelector> {
  FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //to extend the body even behind the bottom app bar
        extendBody: true,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: search
              ? AnimatedContainer(
                duration: Duration(seconds: 1),
                width: double.infinity,
                  child: TextField(
                    focusNode: focusNode,
                    decoration: InputDecoration(
                        hintText: 'Search here...', 
                        border: InputBorder.none),
                  ),
                )
              : Hero(
                  tag: widget.courseName,
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      widget.courseName,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
        ),
        body: PaperListView(paperModels: papermodel,),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: search
              ? const Icon(FontAwesomeIcons.times)
              : const Icon(FontAwesomeIcons.search),
          backgroundColor: Colors.white,
          foregroundColor: kPrimaryColor,
          onPressed: () {
            setState(() {
              search ^= true;
              if (search)
                FocusScope.of(context).requestFocus(focusNode);
              else
                FocusScope.of(context).unfocus();
            });
          },
        ),
        bottomNavigationBar: FilterOptionBar(),
      ),
    );
  }
}