import 'package:flutter/material.dart';
import '../widgets/triangle.dart';
import '../styles/fonts.dart';

class OtherWidgets {
  final FontStyles _fonts = FontStyles();

  Container backButton(BuildContext context, int countPop) {
    return Container(
      child: InkWell(
          onTap: () {
            int counter = 0;
            Navigator.of(context).popUntil((_) => counter++ >= countPop);
          },
          child: Icon(Icons.keyboard_arrow_left, color: Colors.black, size: 25,)
      ),
    );
  }

  Container quitButton(BuildContext context, int countPop) {
    return Container(
      child: InkWell(
          onTap: () {
            int counter = 0;
            Navigator.of(context).popUntil((_) => counter++ >= countPop);
          },
          child: Icon(Icons.backspace, color: Colors.black54, size: 20,)
      ),
    );
  }

  Positioned helpMessage(double totalWidth, double width, double height, String text, double top, double left) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: totalWidth,
        height: 160,
        child: Stack(children: [
          Container(
            height: height,
            width: width,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color(0xff33A3fC),
            ),
            child: Center(
              child: Text(
                text,
                style: _fonts.openSans(16, Colors.black),
              ),
            ),
          ),
          Positioned(
            top: height-1,
            left: 50,
            child: Transform.rotate(
              angle: 3.1415926535897932,
              child: CustomPaint(
                painter: TrianglePainter(
                  strokeColor: Color(0xff33A3fC),
                  paintingStyle: PaintingStyle.fill,
                ),
                child: Container(
                  height: 30,
                  width: 40,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Positioned helpMessageFromBottom(double totalWidth, double width, double height, String text, double bottom, double left) {
    return Positioned(
      bottom: bottom,
      left: left,
      child: Container(
        width: totalWidth,
        height: 160,
        child: Stack(children: [
          Container(
            height: height,
            width: width,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color(0xff33A3fC),
            ),
            child: Center(
              child: Text(
                text,
                style: _fonts.openSans(16, Colors.black),
              ),
            ),
          ),
          Positioned(
            top: height-1,
            left: 50,
            child: Transform.rotate(
              angle: 3.1415926535897932,
              child: CustomPaint(
                painter: TrianglePainter(
                  strokeColor: Color(0xff33A3fC),
                  paintingStyle: PaintingStyle.fill,
                ),
                child: Container(
                  height: 30,
                  width: 40,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Positioned helpMessageRightArrow(double totalWidth, double width, double height, String text, double bottom, double left) {
    return Positioned(
      bottom: bottom,
      left: left,
      child: Container(
        width: totalWidth,
        height: 160,
        child: Stack(children: [
          Container(
            height: height,
            width: width,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color(0xff33A3fC),
            ),
            child: Center(
              child: Text(
                text,
                style: _fonts.openSans(16, Colors.black),
              ),
            ),
          ),
          Positioned(
            top: height/2,
            left: width-5,
            child: Transform.rotate(
              angle: 3.1415926535897932 / 2,
              child: CustomPaint(
                painter: TrianglePainter(
                  strokeColor: Color(0xff33A3fC),
                  paintingStyle: PaintingStyle.fill,
                ),
                child: Container(
                  height: 30,
                  width: 40,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}