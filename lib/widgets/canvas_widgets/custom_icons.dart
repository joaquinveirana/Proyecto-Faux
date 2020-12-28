import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomIcons {

  Container paintOverFinger(Color color) {
    return Container(
      width: 40,
      child: Stack(children: [
        Positioned(
          bottom: 3,
          left: 5,
          child: FaIcon(
            FontAwesomeIcons.handPointer,
            size: 25,
            color: color,
          ),
        ),
        Positioned(
          top: 8,
          left: 5,
          child: FaIcon(
            FontAwesomeIcons.solidCircle,
            size: 12,
            color: color,
          ),
        ),
        Positioned(
          top: 8,
          left: 15,
          child: FaIcon(
            FontAwesomeIcons.waveSquare,
            size: 15,
            color: color,
          ),
        ),
      ]),
    );
  }

  Container notPaintOverFinger(Color color) {
    return Container(
      width: 40,
      child: Stack(children: [
        Positioned(
          bottom: 3,
          left: 10,
          child: FaIcon(
            FontAwesomeIcons.handPointer,
            size: 25,
            color: color,
          ),
        ),
        Positioned(
          top: 19,
          left: 11,
          child: FaIcon(
            FontAwesomeIcons.solidCircle,
            size: 12,
            color: color,
          ),
        ),
        Positioned(
          top: 18,
          left: 21,
          child: FaIcon(
            FontAwesomeIcons.waveSquare,
            size: 15,
            color: color,
          ),
        ),
      ]),
    );
  }

  Container thinStroke(Color color) {
    return Container(
      width: 40,
      child: Stack(
        children: [
          Positioned(
              top: 22,
              left: 7,
              child: FaIcon(
                FontAwesomeIcons.solidCircle,
                size: 12,
                color: color,
              )
          ),
          Positioned(
            top: 22,
            left: 17,
            child: FaIcon(
              FontAwesomeIcons.paintBrush,
              size: 15,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Container mediumStroke(Color color) {
    return Container(
      width: 50,
      child: Stack(
        children: [
          Positioned(
              top: 20,
              left: 10,
              child: FaIcon(
                FontAwesomeIcons.solidCircle,
                size: 18,
                color: color,
              )
          ),
          Positioned(
            top: 20,
            left: 25,
            child: FaIcon(
              FontAwesomeIcons.paintBrush,
              size: 20,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Container wideStroke(Color color) {
    return Container(
      width: 65,
      child: Stack(
        children: [
          Positioned(
              top: 18,
              left: 9,
              child: FaIcon(
                FontAwesomeIcons.solidCircle,
                size: 25,
                color: color,
              )
          ),
          Positioned(
            top: 18,
            left: 33,
            child: FaIcon(
              FontAwesomeIcons.paintBrush,
              size: 25,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------Landscape Mode Icons-----------------------------------

  Container paintOverFingerVertical(Color color) {
    return Container(
      height: 55,
      child: Stack(children: [
        Positioned(
          bottom: 0,
          left: 40,
          child: FaIcon(
                FontAwesomeIcons.handPointer,
                size: 25,
                color: color,
              ),
        ),
        Positioned(
          top: 5,
          left: 42,
          child: FaIcon(
            FontAwesomeIcons.solidCircle,
            size: 12,
            color: color,
          ),
        ),
        Positioned(
          top: 5,
          left: 52,
          child: FaIcon(
            FontAwesomeIcons.waveSquare,
            size: 15,
            color: color,
          ),
        ),
      ]),
    );
  }

  Container notPaintOverFingerVertical(Color color) {
    return Container(
      height: 55,
      child: Stack(children: [
        Positioned(
          bottom: 0,
          left: 40,
          child: FaIcon(
            FontAwesomeIcons.handPointer,
            size: 25,
            color: color,
          ),
        ),
        Positioned(
          top: 18,
          left: 42,
          child: FaIcon(
            FontAwesomeIcons.solidCircle,
            size: 12,
            color: color,
          ),
        ),
        Positioned(
          top: 18,
          left: 53,
          child: FaIcon(
            FontAwesomeIcons.waveSquare,
            size: 15,
            color: color,
          ),
        ),
      ]),
    );
  }

  Container thinStrokeVertical(Color color) {
    return Container(
      height: 40,
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 42,
            child: FaIcon(
                  FontAwesomeIcons.solidCircle,
                  size: 12,
                  color: color,
                )
          ),
          Positioned(
            top: 8,
            left: 55,
            child: FaIcon(
                  FontAwesomeIcons.paintBrush,
                  size: 15,
                  color: color,
                ),
          ),
        ],
      ),
    );
  }

  Container mediumStrokeVertical(Color color) {
    return Container(
      height: 40,
      child: Stack(
        children: [
          Positioned(
              top: 12,
              left: 37,
              child: FaIcon(
                FontAwesomeIcons.solidCircle,
                size: 18,
                color: color,
              )
          ),
          Positioned(
            top: 10,
            left: 55,
            child: FaIcon(
              FontAwesomeIcons.paintBrush,
              size: 20,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Container wideStrokeVertical(Color color) {
    return Container(
      height: 45,
      child: Stack(
        children: [
          Positioned(
              top: 17,
              left: 32,
              child: FaIcon(
                FontAwesomeIcons.solidCircle,
                size: 25,
                color: color,
              )
          ),
          Positioned(
            top: 15,
            left: 55,
            child: FaIcon(
              FontAwesomeIcons.paintBrush,
              size: 25,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

}