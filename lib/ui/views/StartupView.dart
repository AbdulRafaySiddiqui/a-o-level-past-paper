import 'package:flutter/material.dart';
import 'package:past_papers/core/Base/BaseView.dart';
import 'package:past_papers/core/widgets_view_models.dart/StartupViewModel.dart';

class StartupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<StartupViewModel>.withConsumer(
        viewModel: StartupViewModel(),
        builder: (context, model, child) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image(
                height: 250,
                image: AssetImage('assets/images/past_paper_logo.png'),
              ),
              CircularProgressIndicator(),
              if (model.isDownloading)
                Text(
                  'Please wait while we setup things for you \n\t ${model.downloadProgress}%',
                  textAlign: TextAlign.center,
                )
            ],
          ),
        ),
      ),
    );
  }
}
