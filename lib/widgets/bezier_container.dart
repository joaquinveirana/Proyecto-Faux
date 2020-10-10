import 'dart:math';
import 'package:flutter/material.dart';
import 'clip_container.dart';

class BezierContainer extends StatelessWidget {
  const BezierContainer({Key key, double angle, Color color1, Color color2}) : this._angle = angle, this._color1 = color1, this._color2 = color2, super(key: key);
  final Color _color1;
  final Color _color2;
  final double _angle;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Transform.rotate(
          angle: -pi / _angle,
          child: ClipPath(
            clipper: ClipPainter(),
            child: Container(
              height: MediaQuery.of(context).size.height *.5,
              width: MediaQuery.of(context).size.width * 1.15,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [_color1,_color2]
                  )
              ),
            ),
          ),
        )
    );
  }
}