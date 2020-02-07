import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:past_papers/constants/constants.dart';
import 'package:past_papers/core/Base/BaseView.dart';
import 'package:past_papers/core/Base/locator.dart';
import 'package:past_papers/core/widgets_view_models.dart/SideMenuViewModel.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;
  const MenuItem({Key key, this.icon, this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 22,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu>
    with SingleTickerProviderStateMixin<SideMenu> {
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return BaseView<SideMenuViewModel>.withConsumer(
          viewModel: SideMenuViewModel(),
          builder: (context, model, child) => AnimatedPositioned(
            duration: _animationDuration,
            top: 0,
            bottom: 0,
            left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
            right: isSideBarOpenedAsync.data ? 0 : screenWidth - 45,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    color: kPrimaryColor,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                        ),
                        ListTile(
                          title: Text(
                            "App Name",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w800),
                          ),
                          subtitle: Text(
                            "www.appwebsite.com",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          leading: CircleAvatar(
                            child: Image(
                              image: AssetImage(
                                  'assets/images/past_paper_logo.png'),
                            ),
                            radius: 40,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Divider(
                          height: 30,
                          thickness: 0.5,
                          color: Colors.white,
                          indent: 32,
                          endIndent: 32,
                        ),
                        MenuItem(
                          icon: FontAwesomeIcons.arrowAltCircleRight,
                          title: "Select Course",
                          onTap: () {
                            onIconPressed();
                            model.navigate('course');
                          },
                        ),
                        if (!isUserVersion) ...{
                          model.isSyncing
                              ? Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      CircularProgressIndicator(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text(
                                          '${model.syncProgress} %',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 22,
                                              color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : MenuItem(
                                  icon: FontAwesomeIcons.syncAlt,
                                  title: "Sync Data",
                                  onTap: () async {
                                    await model.syncDatabase();
                                    onIconPressed();
                                  },
                                ),
                          model.isDeletingDb
                              ? CircularProgressIndicator()
                              : MenuItem(
                                  icon: FontAwesomeIcons.trashAlt,
                                  title: "Delete Database",
                                  onTap: () async {
                                    await model.deleteDatabase();
                                    onIconPressed();
                                  },
                                ),
                          model.isDownloadingDb
                              ? Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      CircularProgressIndicator(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text(
                                          '${model.downloadProgress} %',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 22,
                                              color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : MenuItem(
                                  icon: FontAwesomeIcons.download,
                                  title: "Download Database",
                                  onTap: () async {
                                    await model.downloadDatabase();
                                    onIconPressed();
                                  },
                                ),
                        },
                        MenuItem(
                          icon: FontAwesomeIcons.infoCircle,
                          title: "About",
                          onTap: () {
                            onIconPressed();
                            model.navigate('about');
                          },
                        ),
                        if (enableAdminVersion) ...{
                          Row(
                            children: <Widget>[
                              Switch(
                                value: !isUserVersion,
                                onChanged: (value) {
                                  onIconPressed();
                                  model.changeAdminMode(value);
                                },
                              ),
                              Text(
                                'Admin',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 22,
                                    color: Colors.white),
                              ),
                            ],
                          )
                        }
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0, -0.9),
                  child: GestureDetector(
                    onTap: () {
                      onIconPressed();
                    },
                    child: ClipPath(
                      clipper: CustomMenuClipper(),
                      child: Container(
                        width: 35,
                        height: 110,
                        color: kPrimaryColor,
                        alignment: Alignment.centerLeft,
                        child: AnimatedIcon(
                          progress: _animationController.view,
                          icon: AnimatedIcons.menu_close,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
