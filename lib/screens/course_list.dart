import 'package:past_papers/screens/paper_selector.dart';
import 'package:flutter/material.dart';
import 'package:past_papers/tempData.dart';

class CourseListView extends StatefulWidget {
  static String id = 'courseList';
  @override
  _CourseListViewState createState() => _CourseListViewState();
}

class _CourseListViewState extends State<CourseListView> {
  List<CourseTile> getCourseTile() {
    List<CourseTile> courseList = [];
    for (var course in courseNames) {
      courseList.add(CourseTile(
        title: course,
      ));
    }
    return courseList;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  contentPadding: EdgeInsets.all(0.0),
                  hintText: 'Search ...',
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
                child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(0.0),
              children: getCourseTile(),
            )),
          ],
        ),
      ),
    );
  }
}

//course style
class CourseTile extends StatefulWidget {
  CourseTile({this.title, this.isFavorite = false});

  final String title;
  final bool isFavorite;

  @override
  _CourseTileState createState() => _CourseTileState();
}

class _CourseTileState extends State<CourseTile> {
  _CourseTileState() {
    // isFavorite = widget.isFavorite? true : false;
  }

  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PaperSelector(courseName: widget.title)));
        },
        child: Card(
            elevation: 3.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Hero(
                    tag: widget.title,
                    child: Material(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.all(2.0),
                  onPressed: () {
                    setState(() {
                      isFavorite ^= true;
                    });
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                )
              ],
            )),
      ),
    );
  }
}
