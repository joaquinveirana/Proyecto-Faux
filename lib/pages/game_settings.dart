import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import '../controller/controller_logic.dart';
import '../controller/controller_view.dart';
import '../fonts/styles.dart';
import '../locale/app_localization.dart';
import '../pages/game_stage.dart';
import '../language_enum.dart';

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
  final FontStyles _fontStyles = FontStyles();
  ControllerLogic _controllerLogic = ControllerLogic();

  int _numImpostors = 1;
  int _numPlayers = 5;
  List<int> _categoriesSelected = [];
  LinearGradient _allImpostorsColor, _noImpostorsColor, _beginButtonColor;
  LinearGradient _selectedOptionButton = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Color(0xff19c5ff), Color(0xff33A3fC)]
  );
  LinearGradient _unselectedOptionButton = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Colors.black12, Colors.black12]
  );
  LinearGradient _unselectedBeginButton = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Colors.black26, Colors.black26]
  );

  @override
  void initState() {
    super.initState();
    _allImpostorsColor = _unselectedOptionButton;
    _noImpostorsColor = _unselectedOptionButton;
    _beginButtonColor = _unselectedBeginButton;
  }

  @override
  Widget build(BuildContext context) {
    final double _safePadding = MediaQuery.of(context).padding.top;
    final double _heightTotal = MediaQuery.of(context).size.height - _safePadding;

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  color: Colors.black12,
                  child: _categorySelector(_heightTotal * 0.5 , _controllerLogic),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  color: Colors.black12,
                  child: Column(
                    children: [
                      _playerSelector( _heightTotal * 0.42, _controllerLogic),
                      _moreOptions(_controllerLogic)
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: _beginButtonColor
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _validateBeginButton(),
                      child: Center(
                          child: Text(AppLocalization.of(context).translate('game_settings_begin',),
                            style: _fontStyles.openSansBold(18, Colors.black),
                          )
                      )
                    ),
                  )
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  // ============================== SECTIONS ==============================

  Container _categorySelector(double containerHeight, ControllerLogic controller) {
    return Container(
      child: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: containerHeight * 0.025),
              child: Text(AppLocalization.of(context).translate('game_settings_main_title'),
                  style: _fontStyles.openSansSemiBold(29, Colors.black)),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: containerHeight * 0.025),
              child: Text(AppLocalization.of(context).translate('game_settings_categories_title'),
                  style: _fontStyles.openSans(22, Colors.black)),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 0.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 1.5,
                  blurRadius: 3,
                  offset: Offset(0, 2.5),
                ),
              ],
            ),
            height: containerHeight * 0.9 - 60,
            child: _controller.getCategoryList(context, controller, _changeBeginButtonColor),
          )
        ],
      ),
    );
  }

  void _changeBeginButtonColor(int id) {
    _categoriesSelected.contains(id)
        ? _categoriesSelected.remove(id)
        : _categoriesSelected.add(id);
    if (_categoriesSelected.length > 0) {
      setState(() {
        _beginButtonColor = _selectedOptionButton;
      });
    } else {
      setState(() {
        _beginButtonColor = _unselectedBeginButton;
      });
    }
  }

  Container _playerSelector(double containerHeight, ControllerLogic controller) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: containerHeight * 0.05),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(AppLocalization.of(context).translate('game_settings_number_of_players_title') + ":  $_numPlayers",
                    style: _fontStyles.openSans(16, Colors.black)
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
                    style: _fontStyles.openSans(16, Colors.black)
                    ),
                NumberPicker.integer(
                    initialValue: _numImpostors,
                    minValue: 1,
                    maxValue: 2,
                    step: 1,
                    onChanged: (value){
                      controller.setNumberOfImpostors(value);
                      setState(() { _numImpostors = value; });
                    }
                )
              ],
            ),
          )
        ],
      )
    );
  }

  Container _moreOptions(ControllerLogic controller) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Divider(
              thickness: 1,
              color: Colors.black54,
              indent: 20,
              endIndent: 20,
            ),
          ),
          Container(
            child: Text(AppLocalization.of(context).translate('game_settings_more_options_title'),
                style: _fontStyles.openSans(16, Colors.black)
            ),
          ),
          Container(
            child: Row(
              children: [
                _optionButton(
                    controller, () => {
                  setState(() {
                    controller.setNoImpostors();
                    _allImpostorsColor == _unselectedOptionButton
                        ? _allImpostorsColor = _selectedOptionButton
                        : _allImpostorsColor = _unselectedOptionButton;
                  })},
                    _allImpostorsColor,
                    'game_settings_more_options_all_impostors',
                    'game_settings_more_options_all_impostors_desc'
                ),
                _optionButton(
                    controller, () => {
                    setState(() {
                    controller.setNoImpostors();
                    _noImpostorsColor == _unselectedOptionButton
                      ? _noImpostorsColor = _selectedOptionButton
                      : _noImpostorsColor = _unselectedOptionButton;
                    })},
                    _noImpostorsColor,
                    'game_settings_more_options_no_impostors',
                    'game_settings_more_options_no_impostors_desc'
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // ============================== FUNCTIONS ==============================

  Expanded _optionButton(ControllerLogic controller, dynamic tapFunction, LinearGradient color, String title, String subTitle) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap:(){
            tapFunction();
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: color,
              borderRadius: BorderRadius.circular(4),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(AppLocalization.of(context).translate(title),
                    style: _fontStyles.openSansBold(13, Colors.black)),
                Text(AppLocalization.of(context).translate(subTitle),
                    style: _fontStyles.openSans(12, Colors.black)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validateBeginButton() {
    Map<String, dynamic> res = _controllerLogic.returnGame();
    if(res.isNotEmpty) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => GameStage(data: res)));
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(AppLocalization.of(context).translate('game_settings_error_dialog')),
            backgroundColor: Colors.white,
            content: Container(
                height: 40,
                child: Column(
                  children: <Widget>[
                    Material(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.bottomCenter,
                            color: Colors.black12,
                            child: Text(AppLocalization.of(context).translate('game_settings_error_dialog_button'))
                        ),
                      ),
                    )
                  ],
                )
            ),
          )
      );
    }
  }
}
