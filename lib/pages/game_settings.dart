import 'package:carousel_slider/carousel_slider.dart';
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
  Color _allImpostorsColor, _noImpostorsColor, _beginButtonColor;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _allImpostorsColor = Colors.transparent;
    _noImpostorsColor = Colors.transparent;
    _beginButtonColor = Colors.black38;
    _pageController = PageController(initialPage: 0);
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
                  child: InkWell(
                    onTap: () => _validateBeginButton(),
                    child: Center(
                        child: Text(AppLocalization.of(context).translate('game_settings_begin',),
                          style: _fontStyles.openSansBold(18),
                        )
                    )
                  ),
                  color: _beginButtonColor,
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  // ================== Sections ==================

  Container _categorySelector(double containerHeight, ControllerLogic controller) {
    return Container(
      child: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: containerHeight * 0.025),
              child: Text(AppLocalization.of(context).translate('game_settings_main_title'),
                  style: _fontStyles.openSansBold(29)),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: containerHeight * 0.025),
              child: Text(AppLocalization.of(context).translate('game_settings_categories_title'),
                  style: _fontStyles.openSans(22)),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 1), // changes position of shadow
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
    _categoriesSelected.contains(id) ? _categoriesSelected.remove(id) : _categoriesSelected.add(id);
    if(_categoriesSelected.length > 0) {
      setState(() {
        _beginButtonColor = Colors.blue;
      });
    } else {
      setState(() {
        _beginButtonColor = Colors.black38;
      });
    }

  }

  Container _playerSelector(double containerHeight, ControllerLogic controller) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: containerHeight * 0.05),
      child: Column(
        children: [
          SizedBox(
            height: containerHeight * 0.55,
            child: CarouselSlider(
              options: CarouselOptions(
                initialPage: 0,
                enlargeCenterPage: true,
                autoPlay: false,
                reverse: false,
                enableInfiniteScroll: false,
                scrollDirection: Axis.horizontal,
                viewportFraction: 0.4,
              ),
              items: [
                Column(
                  children: [
                    Text(AppLocalization.of(context).translate('game_settings_number_of_players_title') + ":  $_numPlayers",
                        style: _fontStyles.openSans(16)
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
                Column(
                  children: [
                    Text(AppLocalization.of(context).translate('game_settings_number_of_impostors_title') + ":  $_numImpostors",
                        style: _fontStyles.openSans(16)
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _moreOptions(ControllerLogic controller) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Divider(
              thickness: 1.5,
              indent: 20,
              endIndent: 20,
            ),
          ),
          Container(
            child: Text(AppLocalization.of(context).translate('game_settings_more_options_title'),
                style: _fontStyles.openSans(16)
            ),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: (){
                        controller.setAllImpostors();
                        setState(() {
                          _allImpostorsColor == Colors.transparent
                              ? _allImpostorsColor = Colors.blue[100]
                              : _allImpostorsColor = Colors.transparent;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _allImpostorsColor,
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(AppLocalization.of(context).translate('game_settings_more_options_all_impostors'),
                                style: _fontStyles.openSansBold(13)),
                            Text(AppLocalization.of(context).translate('game_settings_more_options_all_impostors_desc'),
                                style: _fontStyles.openSans(12)),
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
                              ? _noImpostorsColor = Colors.blue[100]
                              : _noImpostorsColor = Colors.transparent;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _noImpostorsColor,
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(AppLocalization.of(context).translate('game_settings_more_options_no_impostors'),
                                style: _fontStyles.openSansBold(13)),
                            Text(AppLocalization.of(context).translate('game_settings_more_options_no_impostors_desc'),
                                style: _fontStyles.openSans(12)),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
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
