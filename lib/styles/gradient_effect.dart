import 'package:flutter/material.dart';

class GradientEffect extends StatefulWidget {
  final Widget _child;
  final List<Color> _colorList;
  final Color _bottom, _top;
  GradientEffect({ colors: dynamic, bottom: Color, top: Color ,child: Widget}) : this._colorList = colors, this._bottom = bottom, this._top = top, this._child = child;

  Widget getChild() {
    return this._child;
  }

  List<Color> getColorList() {
    return this._colorList;
  }

  Color getBottomColor() {
    return this._bottom;
  }

  Color getTopColor() {
    return this._top;
  }


  @override
  _GradientEffectState createState() => _GradientEffectState();
}

class _GradientEffectState extends State<GradientEffect> {
  int index = 0;
  Alignment begin = Alignment.bottomLeft;
  Alignment end = Alignment.topRight;
  Color topColor, bottomColor;
  List<Color> colorList;

  @override
  void initState() {
    colorList = widget.getColorList();
    topColor = widget.getTopColor();
    bottomColor = widget.getBottomColor();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
      bottomColor = Colors.transparent;
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(
      duration: Duration(seconds: 2),
      onEnd: () {
        setState(() {
          index >= colorList.length - 1 ? index = 0 : index += 1;
          bottomColor = colorList[index];
          topColor = colorList[(index + 1) % colorList.length];
        });
      },
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: begin, end: end, colors: [bottomColor, topColor])),
      child: widget.getChild(),
    );
  }
}
