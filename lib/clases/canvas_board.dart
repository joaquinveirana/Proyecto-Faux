import 'package:faux_the_game/locale/app_localization.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';
import 'dart:math' as math;

import '../widgets/other_widgets.dart';
import '../clases/touch_point.dart';
import '../styles/fonts.dart';
import '../clases/painter_override.dart';
import 'package:flutter/material.dart';

class CanvasBoard extends StatefulWidget {
  final Map<String, dynamic> _data;
  final Function _backButtonCallback;

  CanvasBoard({Map<String, dynamic> data, Function backButtonCallback})
      : this._data = data,
        this._backButtonCallback = backButtonCallback;

  Map<String, dynamic> getData() {
    return this._data;
  }

  Function getBackButtonCallback() {
    return this._backButtonCallback;
  }

  @override
  _CanvasBoardState createState() => _CanvasBoardState();
}

class _CanvasBoardState extends State<CanvasBoard> {
  final FontStyles _fonts = FontStyles();
  final OtherWidgets _otherWidgets = OtherWidgets();
  final _random = new Random();

  Map<String, dynamic> _data;
  List<TouchPoints> points = List();
  bool _paintOverFinger;
  bool _endgame;

  // Paint Properties
  double opacity = 1.0;
  StrokeCap strokeType = StrokeCap.round;
  double strokeWidth = 3.0;
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
  List<Color> _listOfRandomColors = List();

  @override
  void initState() {
    _data = widget.getData();
    _paintOverFinger = false;
    for (var i = 0; i < _data['players'].length; i++) {
      int randIndex = 0 + _random.nextInt(10);
      _listOfRandomColors.add(_listOfColors[randIndex]);
      _listOfColors.removeAt(randIndex);
    }

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
        print(orientation);
        return Stack(children: [
          Container(
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
        color: Colors.black12,
      ),
      child: Row(
        children: [
          Expanded(child: Container()),
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
        color: Colors.black12,
      ),
      child: Row(
        children: [
          Expanded(child: Container()),
        ],
      ),
    );
  }

  Expanded _drawCanvas(Orientation orientation) {
    final _offsets = <Offset>[];

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
            _paintOverFinger
                ? offset = Offset(
                    details.globalPosition.dx, details.globalPosition.dy - 140)
                : offset = Offset(
                    details.globalPosition.dx, details.globalPosition.dy - 100);
            setState(() {
              RenderBox renderBox = context.findRenderObject();
              points.add(TouchPoints(
                  points: renderBox.globalToLocal(offset),
                  paint: Paint()
                    ..strokeCap = strokeType
                    ..isAntiAlias = true
                    ..color = _selectedColor.withOpacity(opacity)
                    ..strokeWidth = strokeWidth));
            });
          },
          onPanUpdate: (details) {
            Offset offset;
            _paintOverFinger
                ? offset = Offset(
                    details.globalPosition.dx, details.globalPosition.dy - 140)
                : offset = Offset(
                    details.globalPosition.dx, details.globalPosition.dy - 100);
            setState(() {
              RenderBox renderBox = context.findRenderObject();
              points.add(TouchPoints(
                  points: renderBox.globalToLocal(offset),
                  paint: Paint()
                    ..strokeCap = strokeType
                    ..isAntiAlias = true
                    ..color = _selectedColor.withOpacity(opacity)
                    ..strokeWidth = strokeWidth));
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
          child: CustomPaint(
            size: Size.infinite,
            painter: CanvasPainter(
              pointsList: points,
              totalHeight: MediaQuery.of(context).size.height,
              totalWidth: MediaQuery.of(context).size.width
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
        color: Colors.black12,
      ),
      child: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  AppLocalization.of(context).translate("game_round_label") +
                      (_round).toString() +
                      "/2",
                  style: _fonts.openSansSemiBold(18, Colors.black),
                ),
              ),
              Container(
                child: Text(
                  AppLocalization.of(context).translate("game_player_label") +
                      (_currentPlayer + 1).toString(),
                  style: _fonts.openSansBold(17, _selectedColor),
                ),
              ),
            ],
          )),
          VerticalDivider(
            thickness: 1,
            indent: 10,
            endIndent: 10,
            color: Colors.black45,
          ),
          _paintOverFingerIcon(),
          _notPaintOverFingerIcon(),
          VerticalDivider(
            thickness: 1,
            indent: 10,
            endIndent: 10,
            color: Colors.black45,
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  Container _drawOptionsVertical() {
    return Container(
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18), bottomLeft: Radius.circular(18)),
        color: Colors.green,
      ),
    );
  }

  // -----------------------------------DrawOptionsIcons-----------------------------------

  Stack _paintOverFingerIcon() {
    return Stack(children: [
      Align(
        alignment: Alignment.bottomCenter,
        child: IconButton(
            icon: FaIcon(
              FontAwesomeIcons.handPointer,
              size: _paintOverFinger ? 27 : 22,
              color: _paintOverFinger ? Colors.black : Colors.black26,
            ),
            onPressed: () {
              setState(() {
                _paintOverFinger = true;
              });
            }),
      ),
      Positioned(
        top: _paintOverFinger ? 5 : 9,
        left: _paintOverFinger ? 14 : 14,
        child: FaIcon(
          FontAwesomeIcons.solidCircle,
          size: _paintOverFinger ? 11 : 10,
          color: _paintOverFinger ? Colors.black : Colors.black26,
        ),
      ),
      Positioned(
        top: _paintOverFinger ? 4 : 7,
        left: _paintOverFinger ? 25 : 23,
        child: FaIcon(
          FontAwesomeIcons.waveSquare,
          size: _paintOverFinger ? 13 : 12,
          color: _paintOverFinger ? Colors.black : Colors.black26,
        ),
      ),
    ]);
  }

  Stack _notPaintOverFingerIcon() {
    return Stack(children: [
      Align(
        alignment: Alignment.bottomCenter,
        child: IconButton(
            icon: FaIcon(
              FontAwesomeIcons.handPointer,
              size: !_paintOverFinger ? 27 : 22,
              color: !_paintOverFinger ? Colors.black : Colors.black26,
            ),
            onPressed: () {
              setState(() {
                _paintOverFinger = false;
              });
            }),
      ),
      Positioned(
        top: !_paintOverFinger ? 15 : 18,
        left: !_paintOverFinger ? 15 : 16,
        child: FaIcon(
          FontAwesomeIcons.solidCircle,
          size: !_paintOverFinger ? 11 : 9,
          color: !_paintOverFinger ? Colors.black : Colors.black26,
        ),
      ),
      Positioned(
        top: !_paintOverFinger ? 14 : 18,
        left: !_paintOverFinger ? 25 : 24,
        child: FaIcon(
          FontAwesomeIcons.waveSquare,
          size: !_paintOverFinger ? 14 : 12,
          color: !_paintOverFinger ? Colors.black : Colors.black26,
        ),
      ),
    ]);
  }
}
