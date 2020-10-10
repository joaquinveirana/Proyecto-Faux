import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import '../controller/controller_logic.dart';
import '../controller/controller_view.dart';
import '../styles/fonts.dart';
import '../locale/app_localization.dart';
import '../pages/game_stage.dart';
import '../language_enum.dart';
import '../styles/colors.dart';
import '../styles/gradient_effect.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
  final AppColors _colors = AppColors();
  ControllerLogic _controllerLogic = ControllerLogic();

  int _numImpostors = 1;
  int _numPlayers = 5;
  List<int> _categoriesSelected = [];
  LinearGradient _allImpostorsColor,
      _noImpostorsColor,
      _beginButtonColor,
      _selectedOptionButton,
      _unselectedOptionButton,
      _unselectedBeginButton;
  PageController _pageController;
  String _beginButtonText;
  bool _beginButtonIsReady;

  @override
  void initState() {
    super.initState();
    _selectedOptionButton = _colors.gameSettingsSelectedButtonGradient();
    _unselectedOptionButton = _colors.gameSettingsUnselectedButtonGradient();
    _unselectedBeginButton = _colors.gameSettingsUnselectedButtonGradient();
    _allImpostorsColor = _unselectedOptionButton;
    _noImpostorsColor = _unselectedOptionButton;
    _beginButtonColor = _unselectedBeginButton;
    _beginButtonText = '';
    _beginButtonIsReady = false;
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    final double _safePadding = MediaQuery.of(context).padding.top;
    final double _heightTotal =
        MediaQuery.of(context).size.height - _safePadding;
    final double _widthTotal = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
            child: Column(
          children: [
            Expanded(
              flex: _beginButtonIsReady == true ? 7 : 5,
              child: GradientEffect(
                  colors: [Color(0xff30c0cc), Color(0xff33A3fC)],
                  bottom: Color(0xff30c0cc),
                  top: Color(0xff33A3fC),
                  child:
                      _categorySelector(_heightTotal * 0.5, _controllerLogic)),
            ),
            Expanded(
              flex: _beginButtonIsReady == true ? 6 : 5,
              child: _optionsMenu(_widthTotal),
            ),
            _beginButtonIsReady == true
                ? Expanded(
                    flex: 1,
                    child: _beginGameButton(),
                  )
                : Container()
          ],
        )),
      ),
    );
  }

  // ============================== SECTIONS ==============================

  Container _categorySelector(
      double containerHeight, ControllerLogic controller) {
    return Container(
      child: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: containerHeight * 0.025),
              child: Text(
                  AppLocalization.of(context)
                      .translate('game_settings_main_title'),
                  style: _fontStyles.openSansBold(29, Colors.black)),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: containerHeight * 0.025),
              child: Text(
                  AppLocalization.of(context)
                      .translate('game_settings_categories_title'),
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
            child: _controller.getCategoryList(
                context, controller, _changeBeginButton),
          )
        ],
      ),
    );
  }

  Container _optionsMenu(double width) {
    return Container(
      color: Colors.black12,
      child: Column(
        children: [
          Expanded(
            flex: 10,
            child: PageView(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              children: [
                _playerSelector(_controllerLogic),
                _moreOptions(width, _controllerLogic)
              ],
            ),
          ),
          Expanded(
            child: SmoothPageIndicator(
                controller: _pageController, // PageController
                count: 2,
                effect: WormEffect(), // your preferred effect
                onDotClicked: (index) {}),
          )
        ],
      ),
    );
  }

  Container _playerSelector(ControllerLogic controller) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Text(
                  AppLocalization.of(context)
                      .translate('game_settings_number_of_players_label'),
                  style: _fontStyles.openSans(22, Colors.black)),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 1.5,
                          blurRadius: 2,
                          offset: Offset(0, 2.5),
                        )
                      ]
                    ),
                    margin: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                            AppLocalization.of(context).translate(
                                    'game_settings_number_of_players_title') +
                                ":  $_numPlayers",
                            style: _fontStyles.openSans(18, Colors.black)),
                        NumberPicker.integer(
                            initialValue: _numPlayers,
                            minValue: 5,
                            maxValue: 10,
                            step: 1,
                            onChanged: (value) {
                              controller.setNumberOfPlayers(value);
                              setState(() {
                                _numPlayers = value;
                              });
                            })
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 1.5,
                            blurRadius: 2,
                            offset: Offset(0, 2.5),
                          )
                        ]
                    ),
                    margin: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                            AppLocalization.of(context).translate(
                                    'game_settings_number_of_impostors_title') +
                                ":  $_numImpostors",
                            style: _fontStyles.openSans(18, Colors.black)),
                        NumberPicker.integer(
                            initialValue: _numImpostors,
                            minValue: 1,
                            maxValue: 2,
                            step: 1,
                            onChanged: (value) {
                              controller.setNumberOfImpostors(value);
                              setState(() {
                                _numImpostors = value;
                              });
                            })
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }

  Container _moreOptions(double width, ControllerLogic controller) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
                AppLocalization.of(context)
                    .translate('game_settings_more_options_title'),
                style: _fontStyles.openSans(22, Colors.black)),
          ),
          Container(
            child: Column(
              children: [
                _optionButton(
                    true,
                    width,
                    controller,
                    () => {
                          setState(() {
                            controller.setNoImpostors();
                            _allImpostorsColor == _unselectedOptionButton
                                ? _allImpostorsColor = _selectedOptionButton
                                : _allImpostorsColor = _unselectedOptionButton;
                          })
                        },
                    _allImpostorsColor,
                    'game_settings_more_options_all_impostors',
                    'game_settings_more_options_all_impostors_desc'),
                _optionButton(
                    false,
                    width,
                    controller,
                    () => {
                          setState(() {
                            controller.setNoImpostors();
                            _noImpostorsColor == _unselectedOptionButton
                                ? _noImpostorsColor = _selectedOptionButton
                                : _noImpostorsColor = _unselectedOptionButton;
                          })
                        },
                    _noImpostorsColor,
                    'game_settings_more_options_no_impostors',
                    'game_settings_more_options_no_impostors_desc')
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _optionButton(
      bool isFirst,
      double width,
      ControllerLogic controller,
      dynamic tapFunction,
      LinearGradient color,
      String title,
      String subTitle) {
    return Container(
      height: 60,
      width: width * 0.9,
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 1),
          top: isFirst == true
              ? BorderSide(color: Colors.black, width: 1)
              : BorderSide(width: 0),
        ),
        gradient: color
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            tapFunction();
          },
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
    );
  }

  Container _beginGameButton() {
    return Container(
        decoration: BoxDecoration(gradient: _beginButtonColor),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
              onTap: () => _validateBeginButton(),
              child: Center(
                  child: Text(
                _beginButtonText,
                style: _fontStyles.openSansBold(18, Colors.black),
              ))),
        ));
  }

  // ============================== FUNCTIONS ==============================

  void _changeBeginButton(int id) {
    _categoriesSelected.contains(id)
        ? _categoriesSelected.remove(id)
        : _categoriesSelected.add(id);
    if (_categoriesSelected.length > 0) {
      setState(() {
        _beginButtonText = AppLocalization.of(context).translate(
          'game_settings_begin',
        );
        _beginButtonColor = _selectedOptionButton;
        _beginButtonIsReady = true;
      });
    } else {
      setState(() {
        _beginButtonText = "";
        _beginButtonColor = _unselectedBeginButton;
        _beginButtonIsReady = false;
      });
    }
  }

  void _validateBeginButton() {
    Map<String, dynamic> res = _controllerLogic.returnGame();
    if (res.isNotEmpty) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => GameStage(data: res)));
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(AppLocalization.of(context)
                    .translate('game_settings_error_dialog')),
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
                                child: Text(AppLocalization.of(context)
                                    .translate(
                                        'game_settings_error_dialog_button'))),
                          ),
                        )
                      ],
                    )),
              ));
    }
  }
}
