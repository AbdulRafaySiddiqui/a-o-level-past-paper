import 'package:flutter/material.dart';

class Splitter extends StatefulWidget {
  const Splitter({
    Key key,
    this.top,
    this.bottom,
    this.touchOverlap = 5.0,
    this.initialWeight = 0.5,
    this.onWeightChanged,
  }) : super(key: key);

  final Widget top;
  final Widget bottom;
  final double touchOverlap;
  final double initialWeight;
  final ValueChanged<double> onWeightChanged;

  @override
  _SplitterState createState() => _SplitterState();
}

class _SplitterState extends State<Splitter> {
  double _weight;

  @override
  void initState() {
    super.initState();
    _weight = widget.initialWeight;
  }

  void _handleDragUpdate(DragUpdateDetails d) {
    final RenderBox container = context.findRenderObject();
    final pos = container.globalToLocal(d.globalPosition);
    setState(() => _weight = pos.dy / container.size.height);
    widget.onWeightChanged?.call(_weight);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double top = constraints.maxHeight * _weight;
        final double bottom = constraints.maxHeight * (1.0 - _weight);
        return Stack(
          children: <Widget>[
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: 
              Offstage(
                offstage: top.round() == 0,
                child:
                 widget.top,
              ),
            ),
            Positioned(
              top: top,
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: 
              Offstage(
                offstage: bottom.round() == 0,
                child: 
                widget.bottom,
              ),
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              top: top - widget.touchOverlap,
              bottom: bottom - widget.touchOverlap,
              child: GestureDetector(
                child: Container(
                  color: Colors.green,
                ),
                behavior: HitTestBehavior.translucent,
                onHorizontalDragUpdate: _handleDragUpdate,
              ),
            ),
          ],
        );
      },
    );
  }
}
