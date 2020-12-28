import 'package:faux_the_game/locale/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';

import '../widgets/canvas_widgets/custom_icons.dart';
import '../widgets/other_widgets.dart';
import '../clases/touch_point.dart';
import '../styles/fonts.dart';
import '../clases/painter_override.dart';
import 'package:flutter/material.dart';

class CanvasBoard extends StatefulWidget {
  final Map<String, dynamic> _data;

  CanvasBoard({Map<String, dynamic> data}) : this._data = data;

  Map<String, dynamic> getData() {
    return this._data;
  }

  @override
  _CanvasBoardState createState() => _CanvasBoardState();
}

class _CanvasBoardState extends State<CanvasBoard> {
  final FontStyles _fonts = FontStyles();
  final OtherWidgets _otherWidgets = OtherWidgets();
  final _random = new Random();
  final CustomIcons _customIcons = CustomIcons();

  Map<String, dynamic> _data;
  List<TouchPoints> points = [];
  bool _paintOverFinger;
  bool _endgame;

  // Paint Properties
  int _selectedStoke = 1;
  double opacity = 1.0;
  StrokeCap strokeType = StrokeCap.round;
  double _strokeWidth = 4.0;
  Color _selectedColor;

  // Players Info
  int _currentPlayer, _round;
  List<Color> _listOfColors = [
    Colors.red[700],
    Colors.yellow,
    Colors.lightBlue,
    Colors.green[600],
    Colors.purple,
    Colors.brown,
    Colors.pink[200],
    Colors.deepOrange[400],
    Colors.cyan[300],
    Colors.blue[800]
  ];
  List<Color> _listOfRandomColors = [];

  @override
  void initState() {
    _data = widget.getData();
    _paintOverFinger = false;
    for (var i = 0; i < _data['players'].length; i++) {
      _listOfColors.shuffle();
      _listOfRandomColors.add(_listOfColors.first);
      _listOfColors.removeAt(0);
    }

    points = [];
    _currentPlayer = 0;
    _selectedColor = _listOfRandomColors[_currentPlayer];
    _round = 1;
    _endgame = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return OrientationBuilder(
      builder: (context, orientation) {
        return Stack(children: [
          Container(
            color: _selectedColor.withOpacity(0.15),
            child: orientation == Orientation.portrait
                ? Column(children: [
                    _toolBar(),
                    _drawCanvas(orientation),
                    _drawOptions()
                  ])
                : Row(children: [
                    _toolBarVertical(),
                    _drawCanvas(orientation),
                    _drawOptionsVertical()
                  ]),
          )
        ]);
      },
    );
  }

  Container _toolBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(18), bottomRight: Radius.circular(18)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.only(left: 15),
              child: _otherWidgets.quitButton(context, 3)),
          Expanded(child: Container()),
          Container(
            width: 50,
          ),
          Container(
            width: 50,
            child: _otherWidgets.helpButtonCanvasMenu(context),
          )
        ],
      ),
    );
  }

  Container _toolBarVertical() {
    return Container(
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(18), bottomRight: Radius.circular(18)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(child: Container()),
        ],
      ),
    );
  }

  Expanded _drawCanvas(Orientation orientation) {
    return Expanded(
        child: Column(children: [
      Container(
        height: 50,
        child: Column(
          children: [
            Center(
              child: Text(_data['categoryDecoded'],
                  style: orientation == Orientation.portrait
                      ? _fonts.openSans(25, Colors.black)
                      : _fonts.openSans(22, Colors.black)),
            ),
            Divider(
              thickness: 1,
              indent: orientation == Orientation.portrait ? 40 : 150,
              endIndent: orientation == Orientation.portrait ? 40 : 150,
              color: Colors.black54,
            )
          ],
        ),
      ),
      Expanded(
        child: GestureDetector(
          onPanStart: (details) {
            Offset offset;
            orientation == Orientation.portrait
                ? _paintOverFinger
                  ? offset = Offset(
                    details.globalPosition.dx, details.globalPosition.dy - 140)
                  : offset = Offset(
                    details.globalPosition.dx, details.globalPosition.dy - 100)
                : _paintOverFinger
                  ? offset = Offset(
                  details.globalPosition.dx - 50, details.globalPosition.dy - 90)
                  : offset = Offset(
                  details.globalPosition.dx - 50, details.globalPosition.dy - 50);
            setState(() {
              RenderBox renderBox = context.findRenderObject();
              points.add(TouchPoints(
                  points: renderBox.globalToLocal(offset),
                  paint: Paint()
                    ..strokeCap = strokeType
                    ..isAntiAlias = true
                    ..color = _selectedColor.withOpacity(opacity)
                    ..strokeWidth = _strokeWidth));
            });
          },
          onPanUpdate: (details) {
            Offset offset;
            orientation == Orientation.portrait
                ? _paintOverFinger
                  ? offset = Offset(
                  details.globalPosition.dx, details.globalPosition.dy - 140)
                  : offset = Offset(
                  details.globalPosition.dx, details.globalPosition.dy - 100)
                : _paintOverFinger
                  ? offset = Offset(
                  details.globalPosition.dx - 50, details.globalPosition.dy - 90)
                  : offset = Offset(
                  details.globalPosition.dx - 50, details.globalPosition.dy - 50);
            setState(() {
              RenderBox renderBox = context.findRenderObject();
              points.add(TouchPoints(
                  points: renderBox.globalToLocal(offset),
                  paint: Paint()
                    ..strokeCap = strokeType
                    ..isAntiAlias = true
                    ..color = _selectedColor.withOpacity(opacity)
                    ..strokeWidth = _strokeWidth));
            });
          },
          onPanEnd: (details) {
            setState(() {
              _currentPlayer += 1;
              if (_currentPlayer == _data['players'].length) {
                _round += 1;
                _currentPlayer = 0;
                if (_round == 2) {
                  _endgame = true;
                }
              }
              _selectedColor = _listOfRandomColors[_currentPlayer];
              points.add(null);
            });
          },
          child: Container(
            child: CustomPaint(
              size: Size.infinite,
              painter: CanvasPainter(
                  pointsList: points,
                  totalHeight: MediaQuery.of(context).size.height,
                  totalWidth: MediaQuery.of(context).size.width,
                  orientation: orientation
              ),
            ),
          ),
        ),
      ),
    ]));
  }

  Container _drawOptions() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 5, left: 5),
                child: Text(
                  AppLocalization.of(context).translate("game_round_label") +
                      (_round).toString() +
                      "/2",
                  style: _fonts.openSansSemiBold(18, Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  AppLocalization.of(context).translate("game_player_label") + " " +
                      AppLocalization.of(context).translate("game_player") +
                      " " +
                      (_currentPlayer + 1).toString(),
                  style: _fonts.openSansBold(17, _selectedColor),
                ),
              ),
            ],
          ),
          VerticalDivider(
            thickness: 1,
            indent: 10,
            endIndent: 10,
            color: Colors.black45,
          ),
          InkWell(
            child: _paintOverFinger
                ? _customIcons.paintOverFinger(Colors.black)
                : _customIcons.paintOverFinger(Colors.black26),
            onTap: () {
              setState(() {
                _paintOverFinger = true;
              });
            },
          ),
          InkWell(
            child: !_paintOverFinger
                ? _customIcons.notPaintOverFinger(Colors.black)
                : _customIcons.notPaintOverFinger(Colors.black26),
            onTap: () {
              setState(() {
                _paintOverFinger = false;
              });
            },
          ),
          VerticalDivider(
            thickness: 1,
            indent: 10,
            endIndent: 10,
            color: Colors.black45,
          ),
          InkWell(
            child: _selectedStoke == 0
                ? _customIcons.thinStroke(Colors.black)
                : _customIcons.thinStroke(Colors.black26),
            onTap: () {
              setState(() {
                _selectedStoke = 0;
                _strokeWidth = 2.0;
              });
            },
          ),
          InkWell(
            child: _selectedStoke == 1
                ? _customIcons.mediumStroke(Colors.black)
                : _customIcons.mediumStroke(Colors.black26),
            onTap: () {
              setState(() {
                _selectedStoke = 1;
                _strokeWidth = 5.0;
              });
            },
          ),
          InkWell(
            child: _selectedStoke == 2
                ? _customIcons.wideStroke(Colors.black)
                : _customIcons.wideStroke(Colors.black26),
            onTap: () {
              setState(() {
                _selectedStoke = 2;
                _strokeWidth = 9.0;
              });
            },
          )
        ],
      ),
    );
  }

  Container _drawOptionsVertical() {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18), bottomLeft: Radius.circular(18)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  AppLocalization.of(context).translate("game_round_label") +
                      (_round).toString() +
                      "/2",
                  style: _fonts.openSansSemiBold(16, Colors.black),
                ),
              ),
              Container(
                child: Text(
                  " " +
                      AppLocalization.of(context)
                          .translate("game_player_label") +
                      "\n" +
                      AppLocalization.of(context).translate("game_player") +
                      (_currentPlayer + 1).toString(),
                  style: _fonts.openSansBold(16, _selectedColor),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 1,
            indent: 10,
            endIndent: 10,
            color: Colors.black45,
          ),
          InkWell(
            child: _paintOverFinger
                ? _customIcons.paintOverFingerVertical(Colors.black)
                : _customIcons.paintOverFingerVertical(Colors.black26),
            onTap: () {
              setState(() {
                _paintOverFinger = true;
              });
            },
          ),
          InkWell(
            child: !_paintOverFinger
                ? _customIcons.notPaintOverFingerVertical(Colors.black)
                : _customIcons.notPaintOverFingerVertical(Colors.black26),
            onTap: () {
              setState(() {
                _paintOverFinger = false;
              });
            },
          ),
          Divider(
            thickness: 1,
            indent: 10,
            endIndent: 10,
            color: Colors.black45,
          ),
          InkWell(
            child: _selectedStoke == 0
                ? _customIcons.thinStrokeVertical(Colors.black)
                : _customIcons.thinStrokeVertical(Colors.black26),
            onTap: () {
              setState(() {
                _selectedStoke = 0;
                _strokeWidth = 2.0;
              });
            },
          ),
          InkWell(
            child: _selectedStoke == 1
                ? _customIcons.mediumStrokeVertical(Colors.black)
                : _customIcons.mediumStrokeVertical(Colors.black26),
            onTap: () {
              setState(() {
                _selectedStoke = 1;
                _strokeWidth = 5.0;
              });
            },
          ),
          InkWell(
            child: _selectedStoke == 2
                ? _customIcons.wideStrokeVertical(Colors.black)
                : _customIcons.wideStrokeVertical(Colors.black26),
            onTap: () {
              setState(() {
                _selectedStoke = 2;
                _strokeWidth = 9.0;
              });
            },
          )
        ],
      ),
    );
  }
}
