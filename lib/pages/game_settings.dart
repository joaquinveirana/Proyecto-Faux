import 'package:faux_artista_the_game/controller/controller_logic.dart';
import 'package:faux_artista_the_game/controller/controller_view.dart';
import 'package:faux_artista_the_game/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:faux_artista_the_game/language_enum.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';

class GameSettings extends StatefulWidget {
  final Language _lang;
  GameSettings({Language lang}) : _lang = lang;

  Language getLang() {
    return _lang;
  }

  @override
  _GameSettingsState createState() => _GameSettingsState();
}

class _GameSettingsState extends State<GameSettings> {

  final ControllerView _controller = ControllerView();
  ControllerLogic _controllerLogic = ControllerLogic();
  int _numImpostors = 1;
  int _numPlayers = 5;
  Color _allImpostorsColor, _noImpostorsColor;

  @override
  void initState() {
    super.initState();
    _allImpostorsColor = Colors.transparent;
    _noImpostorsColor = Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    final double _safePadding = MediaQuery.of(context).padding.top;
    final double _widthTotal = MediaQuery.of(context).size.width;
    final double _heightTotal = MediaQuery.of(context).size.height - _safePadding;

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: _heightTotal * 0.525,
                width: _widthTotal,
                child: Container(
                  color: Colors.black12,
                  child: _categorySelector(_widthTotal, _heightTotal * 0.525, _controllerLogic),
                ),
              ),
              SizedBox(
                height: _heightTotal * 0.4,
                width: _widthTotal,
                child: Container(
                  color: Colors.black12,
                  child: _playerSelector(_widthTotal, _heightTotal * 0.4, _controllerLogic),
                ),
              ),
              SizedBox(
                height: _heightTotal * 0.075,
                width: _widthTotal,
                child: Container(
                  child: InkWell(
                    onTap: () {
                      Map<String, dynamic> res = _controllerLogic.returnGame();
                      print(res);
                    },
                    child: Center(
                        child: Text(AppLocalization.of(context).translate('game_settings_begin')
                        )
                    )
                  ),
                  color: Colors.green,
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  Container _categorySelector(double parentWidth, double parentHeight, ControllerLogic controller) {
    return Container(
      width: parentWidth,
      height: parentHeight,
      child: Column(
        children: [
          Center(
            child: Container(
              height: parentHeight * 0.1,
              margin: EdgeInsets.only(top: parentHeight * 0.025),
              child: Text(AppLocalization.of(context).translate('game_settings_main_title'),
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  )),
            ),
          ),
          Center(
            child: Container(
              height: parentHeight * 0.1,
              child: Text(AppLocalization.of(context).translate('game_settings_topic_title'),
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  )),
            ),
          ),
          Container(
            height: parentHeight * 0.01,
            child: Divider(
              thickness: 1.5,
              indent: 20,
              endIndent: 20,
            ),
          ),
          Center(
            child: Container(
              height: parentHeight * 0.765,
              width: parentWidth,
              child: Scrollbar(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      _controller.getCategoryList(context, controller),
                    ],
                  ),
                ),
              ),
            )
          )
        ],
      ),
    );
  }

  Container _playerSelector(double parentWidth, double parentheight, ControllerLogic controller) {
    return Container(
      child: Column(
        children: [
          Divider(
            thickness: 1.5,
            indent: 20,
            endIndent: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(AppLocalization.of(context).translate('game_settings_number_of_players_title') + ":  $_numPlayers",
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        )
                    ),
                    NumberPicker.integer(
                        initialValue: _numPlayers,
                        minValue: 5,
                        maxValue: 10,
                        step: 1,
                        onChanged: (value){
                          controller.setNumberOfPlayers(value);
                          setState(() { _numPlayers = value; });
                        }
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(AppLocalization.of(context).translate('game_settings_number_of_impostors_title') + ":  $_numImpostors",
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        )
                    ),
                    NumberPicker.integer(
                        initialValue: _numImpostors,
                        minValue: 1,
                        maxValue: 2,
                        step: 1,
                        onChanged: (value){
                          controller.setNumberOfImpostors(value);
                          setState(() { _numImpostors = value; });
                        print(value);
                        }
                    )
                  ],
                ),
              )
            ],
          ),
          Divider(
            thickness: 1.5,
            indent: 20,
            endIndent: 20,
          ),
          Text(AppLocalization.of(context).translate('game_settings_more_options_title'),
              style: GoogleFonts.playfairDisplay(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              )
          ),
          Row(
            children: [
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: (){
                      controller.setAllImpostors();
                      setState(() {
                        _allImpostorsColor == Colors.transparent
                            ? _allImpostorsColor = Colors.deepPurple[300]
                            : _allImpostorsColor = Colors.transparent;
                      });
                    },
                    child: Container(
                      color: _allImpostorsColor,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(AppLocalization.of(context).translate('game_settings_more_options_all_impostors'),
                              style: GoogleFonts.openSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              )),
                          Text(AppLocalization.of(context).translate('game_settings_more_options_all_impostors_desc'),
                              style: GoogleFonts.openSans(
                                fontSize: 12,
                                color: Colors.black87
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap:(){
                      controller.setNoImpostors();
                      setState(() {
                        _noImpostorsColor == Colors.transparent
                            ? _noImpostorsColor = Colors.deepPurple[300]
                            : _noImpostorsColor = Colors.transparent;
                      });
                    },
                    child: Container(
                      color: _noImpostorsColor,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(AppLocalization.of(context).translate('game_settings_more_options_no_impostors'),
                              style: GoogleFonts.openSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              )),
                          Text(AppLocalization.of(context).translate('game_settings_more_options_no_impostors_desc'),
                              style: GoogleFonts.openSans(
                                fontSize: 12,
                                color: Colors.black87
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
