import 'dart:ui';

import '../clases/touch_point.dart';
import 'package:flutter/material.dart';

class CanvasPainter extends CustomPainter {
  CanvasPainter({this.pointsList, this.totalHeight, this.totalWidth, this.orientation});

  //Keep track of the points tapped on the screen
  List<TouchPoints> pointsList;
  double totalHeight, totalWidth;
  List<Offset> offsetPoints = List();
  Orientation orientation;

  //This is where we can draw on canvas.
  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList.length - 1; i++) {
      int limitDy;
      int limitDx;
      if (orientation == Orientation.portrait) { // Portrait orientation
        limitDy = 210;
        limitDx = 20;
      } else {
        limitDy = 100;
        limitDx = 180;
      }

      if (pointsList[i] != null && pointsList[i + 1] != null) {
        //Drawing line when two consecutive points are available
        if (pointsList[i].points.dy > 0 && pointsList[i].points.dy < totalHeight - limitDy
            && pointsList[i].points.dx > 5 && pointsList[i].points.dx < totalWidth - limitDx) {
          canvas.drawLine(pointsList[i].points, pointsList[i + 1].points,
              pointsList[i].paint);
        }
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(pointsList[i].points);
        offsetPoints.add(Offset(
            pointsList[i].points.dx + 0.1, pointsList[i].points.dy + 0.1));
        if (pointsList[i].points.dy > 0 && pointsList[i].points.dy < totalHeight - limitDy
            && pointsList[i].points.dx > 5 && pointsList[i].points.dx < totalWidth - limitDx) {
          //Draw points when two points are not next to each other
          canvas.drawPoints(
              PointMode.points, offsetPoints, pointsList[i].paint);
        }
      }
    }
  }

  //Called when CustomPainter is rebuilt.
  //Returning true because we want canvas to be rebuilt to reflect new changes.
  @override
  bool shouldRepaint(CanvasPainter oldDelegate) => true;
}