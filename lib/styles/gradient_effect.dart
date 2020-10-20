import 'package:flutter/material.dart';

class GradientEffect extends StatefulWidget {
  final Widget _child;
  final List<Color> _colorList;
  final Color _bottom, _top;
  final int _shape;
  final double _borderRadius;
  GradientEffect({ colors: dynamic, bottom: Color, top: Color, child: Widget, shape: int, borderRadius: double})
      : this._colorList = colors,
        this._bottom = bottom,
        this._top = top,
        this._child = child,
        this._shape = shape,
        this._borderRadius = borderRadius;

  Widget getChild() => this._child;
  List<Color> getColorList() => this._colorList;
  Color getBottomColor() =>  this._bottom;
  Color getTopColor() => this._top;
  int getShape() => this._shape;
  double getBorderRadius() => this._borderRadius;


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
      bottomColor = Colors.blue;
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
          borderRadius: widget.getShape() == 0 ? null : BorderRadius.circular(widget.getBorderRadius()),
          shape: widget.getShape() == 0 ? BoxShape.circle : BoxShape.rectangle,
          gradient: LinearGradient(
              begin: begin, end: end, colors: [bottomColor, topColor])),
      child: widget.getChild(),
    );
  }
}
