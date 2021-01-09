import 'package:flutter/material.dart';
import '../locale/app_localization.dart';
import '../styles/fonts.dart';
import '../widgets/other_widgets.dart';
import '../clases/canvas_board.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';

class Game extends StatefulWidget {
  final Map<String, dynamic> _matchData;

  Game({Map<String, dynamic> data}) : this._matchData = data;

  Map<String, dynamic> getData() {
    return this._matchData;
  }

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  final FontStyles _fonts = FontStyles();
  final OtherWidgets _otherWidgets = OtherWidgets();
  Map<String, dynamic> _matchData;
  bool _showCanvas;

  @override
  void initState() {
    @override
    dispose() {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    }

    _matchData = widget.getData();
    _showCanvas = _matchData['playOnThisDevice'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double _widthTotal = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
      child: Container(
        color: Colors.grey[200],
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black54, width: 2)),
          child: Stack(children: [
            _showCanvas
                ? CanvasBoard(data: widget.getData())
                : _selectionMenu(_widthTotal),
            !_showCanvas
                ? Positioned(
                    top: 10,
                    left: 5,
                    child: _otherWidgets.backButton(context, 2))
                : Container()
          ]),
        ),
      ),
    ));
  }

  Container _selectionMenu(double totalWidth) {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
        child: Column(
          children: [
            Text(AppLocalization.of(context).translate("game_choice_title"),
                style: _fonts.openSansSemiBold(28, Colors.black)),
            Container(
              margin: EdgeInsets.only(top: totalWidth / 4, bottom: 20),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Color(0xff33A3fC),
                  onTap: () {
                    setState(() {
                      _showCanvas = true;
                    });
                  },
                  child: Container(
                    height: 150,
                    child: Column(
                      children: [
                        Container(
                            child: FaIcon(
                          FontAwesomeIcons.mobileAlt,
                          size: 100,
                        )),
                        Text(
                            AppLocalization.of(context)
                                .translate("game_choice_option_1"),
                            style: _fonts.openSans(25, Colors.black))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Colors.black38,
                    indent: 20,
                    endIndent: 20,
                  ),
                ),
                Text(
                  AppLocalization.of(context).translate("game_choice_divider"),
                  style: _fonts.openSans(13, Colors.black),
                ),
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Colors.black38,
                    indent: 20,
                    endIndent: 20,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 40, bottom: 20),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Color(0xff33A3fC),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 150,
                    child: Column(
                      children: [
                        Container(
                            child: FaIcon(
                          FontAwesomeIcons.chalkboard,
                          size: 100,
                        )),
                        Text(
                            AppLocalization.of(context)
                                .translate("game_choice_option_2"),
                            style: _fonts.openSans(25, Colors.black))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
