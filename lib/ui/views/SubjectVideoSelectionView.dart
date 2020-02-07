import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:past_papers/constants/constants.dart';
import 'package:past_papers/core/Base/BaseView.dart';
import 'package:past_papers/core/view_models/SubjectVideoSelectionViewModel.dart';
import 'package:past_papers/ui/widgets/SideMenu.dart';

class SubjectVideoSelectionView extends StatelessWidget {
  SubjectVideoSelectionView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        BaseView<SubjectVideoSelectionViewModel>.withConsumer(
          viewModel: SubjectVideoSelectionViewModel(),
          builder: (context, model, child) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () => model.navigate('subject'),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.clipboard,
                          color: kPrimaryColor,
                          size: 100,
                        ),
                      ),
                      Text(
                        'Past Papers',
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                FlatButton(
                  onPressed: () => model.navigate('video'),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.playCircle,
                          color: kPrimaryColor,
                          size: 100,
                        ),
                      ),
                      Text(
                        'Video Lectures',
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SideMenu()
      ]),
    );
  }
}
