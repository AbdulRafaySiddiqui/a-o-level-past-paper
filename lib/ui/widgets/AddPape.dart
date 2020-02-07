import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:past_papers/constants/constants.dart';
import 'package:past_papers/core/Base/BaseView.dart';
import 'package:past_papers/core/models/PaperModel.dart';
import 'package:past_papers/core/widgets_view_models.dart/AddPaperViewModel.dart';
import 'package:past_papers/ui/widgets/FilterToggleButton.dart';

class AddPaper extends StatelessWidget {
  AddPaper({@required this.subjectId, this.paper});
  final String subjectId;
  final Paper paper;
  @override
  Widget build(BuildContext context) {
    return BaseView<AddPaperViewModel>.withConsumer(
      viewModel: AddPaperViewModel(subjectId: subjectId, paper: paper),
      builder: (BuildContext context, AddPaperViewModel model, Widget child) =>
          Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: Material(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //Header
                Material(
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            model.edit ? 'Update paper' : 'Add Paper',
                            style: TextStyle(
                                color: kWhiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(FontAwesomeIcons.times),
                          color: Colors.red,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      )
                    ],
                  ),
                  color: Colors.blue,
                ),

                //Body
                Center(
                  child: DropdownButton(
                      style: TextStyle(fontSize: 20, color: kBlackColor),
                      value: model.year,
                      items: model
                          .getYears()
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (value) => model.selectYear(value)),
                ),
                //select season
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
                  child: BaseFilterToggleButton(
                    children: <IconModel>[
                      IconModel(icon: model.getSeasonIcon(1), title: 'Summer'),
                      IconModel(icon: model.getSeasonIcon(2), title: 'March'),
                      IconModel(icon: model.getSeasonIcon(3), title: 'Winter'),
                    ],
                    isSelected: model.seasons,
                    addTitle: true,
                    onPressed: (int value) => model.selectSeason(value),
                  ),
                ),

                //paper type
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
                  child: BaseFilterToggleButton(
                    children: <IconModel>[
                      IconModel(icon: model.getPaperTypeIcon(1)),
                      IconModel(icon: model.getPaperTypeIcon(2)),
                      IconModel(icon: model.getPaperTypeIcon(3)),
                      IconModel(icon: model.getPaperTypeIcon(4)),
                    ],
                    isSelected: model.paperTypes,
                    onPressed: (int value) => model.selectPaperType(value),
                  ),
                ),
                //paper number
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
                  child: BaseFilterToggleButton(
                    children: <IconModel>[
                      IconModel(icon: model.getPaperNumberIcon(0)),
                      IconModel(icon: model.getPaperNumberIcon(1)),
                      IconModel(icon: model.getPaperNumberIcon(2)),
                      IconModel(icon: model.getPaperNumberIcon(3)),
                      IconModel(icon: model.getPaperNumberIcon(4)),
                    ],
                    isSelected: model.paperNumberTypes,
                    onPressed: (int value) => model.selectPaperNumber(value),
                  ),
                ),
                //paper vairant
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
                  child: BaseFilterToggleButton(
                    children: <IconModel>[
                      IconModel(icon: model.getVariantIcon(0), title: 'All'),
                      IconModel(
                          icon: model.getVariantIcon(1), title: 'Variant 1'),
                      IconModel(
                          icon: model.getVariantIcon(2), title: 'Variant 2'),
                      IconModel(
                          icon: model.getVariantIcon(3), title: 'Variant 3'),
                      IconModel(
                          icon: model.getVariantIcon(4), title: 'Variant 4'),
                    ],
                    isSelected: model.paperVariantTypes,
                    addTitle: true,
                    onPressed: (int value) => model.selectPaperVariant(value),
                  ),
                ),
                if (model.fileName.isNotEmpty)
                  Text(model.fileName),
                model.attachingFile
                    ? CircularProgressIndicator()
                    : RaisedButton(
                        color: Colors.blue,
                        textColor: kWhiteColor,
                        child: Text('Attach PDF'),
                        onPressed: () => model.attachPdf(),
                      ),
                if (model.showError)
                  Text(
                    'Error: Paper already exist!',
                    style: TextStyle(color: Colors.red),
                  ),
                model.uploading
                    ? CircularProgressIndicator()
                    : RaisedButton(
                        color: Colors.blue,
                        textColor: kWhiteColor,
                        child: Text(model.edit ? 'Update paper' : 'Add Paper'),
                        onPressed: () => model.add(),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
