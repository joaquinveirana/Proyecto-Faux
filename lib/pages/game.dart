import 'package:flutter/material.dart';
import '../locale/app_localization.dart';
import '../styles/colors.dart';
import '../styles/fonts.dart';
import '../widgets/other_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Game extends StatefulWidget {
  final bool _playOnThisDevice;
  Game({bool playOnThisDevice}) : this._playOnThisDevice = playOnThisDevice;

  bool getPlayOnThisDevice() {
    return this._playOnThisDevice;
  }

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  final FontStyles _fonts = FontStyles();
  final AppColors _colors = AppColors();
  final OtherWidgets _otherWidgets = OtherWidgets();
  bool _showCanvas;

  @override
  void initState() {
    _showCanvas = widget.getPlayOnThisDevice();
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
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.black54,
                      width: 2
                  )
              ),
              child: Stack(
                  children: [
                    _showCanvas
                        ? _canvas()
                        : _selectionMenu(_widthTotal),
                    Positioned(top: 10, left: 5, child: _otherWidgets.backButton(context,2))
                  ]
              ),
            ),
          ),
        ));
  }

  Container _canvas() {
    return Container();
  }
  
  Container _selectionMenu(double totalWidth) {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
        child: Column(
          children: [
            Text(
                AppLocalization.of(context).translate("game_choice_title"),
                style: _fonts.openSansSemiBold(28, Colors.black)
            ),
            Container(
              margin: EdgeInsets.only(top: totalWidth/4, bottom: 20),
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
                          child: FaIcon(FontAwesomeIcons.mobileAlt, size: 100,)
                        ),
                        Text(
                            AppLocalization.of(context).translate("game_choice_option_1"),
                            style: _fonts.openSans(25, Colors.black)
                        )
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
                Text(AppLocalization.of(context).translate("game_choice_divider"), style: _fonts.openSans(13, Colors.black),),
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
                  },
                  child: Container(
                    height: 150,
                    child: Column(
                      children: [
                        Container(
                            child: FaIcon(FontAwesomeIcons.chalkboard, size: 100,)
                        ),
                        Text(
                            AppLocalization.of(context).translate("game_choice_option_2"),
                            style: _fonts.openSans(25, Colors.black)
                        )
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
