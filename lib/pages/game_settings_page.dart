import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../controller/controller_logic.dart';
import '../controller/controller_view.dart';
import '../styles/fonts.dart';
import '../locale/app_localization.dart';
import '../pages/game_stage_page.dart';
import '../language_enum.dart';
import '../styles/colors.dart';
import '../widgets/other_widgets.dart';
import '../controller/ad_manager.dart';
import '../widgets/game_settings_widgets/more_options.dart';

class GameSettings extends StatefulWidget {
  final Language _lang;

  GameSettings({Language lang}) : _lang = lang;

  Language getLang() => _lang;

  @override
  _GameSettingsState createState() => _GameSettingsState();
}

class _GameSettingsState extends State<GameSettings> {
  final ControllerView _controller = ControllerView();
  final FontStyles _fontStyles = FontStyles();
  final AppColors _colors = AppColors();
  final OtherWidgets _otherWidgets = OtherWidgets();
  final MoreOptions _moreOptionsClass = MoreOptions();
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
  ScrollConfiguration _listOfCategories;
  InterstitialAd _newCategoryAd;

  @override
  void initState() {
    super.initState();
    _newCategoryAd = AdManager.getNewInterstitialAd;
    _newCategoryAd.load();

    _controllerLogic = ControllerLogic();
    _selectedOptionButton = _colors.gameSettingsSelectedButtonGradient();
    _unselectedOptionButton = _colors.gameSettingsUnselectedButtonGradient();
    _unselectedBeginButton = _colors.gameSettingsUnselectedButtonGradient();
    _allImpostorsColor = _unselectedOptionButton;
    _noImpostorsColor = _unselectedOptionButton;
    _beginButtonColor = _unselectedBeginButton;
    _beginButtonText = '';
    _beginButtonIsReady = false;
    _pageController = PageController(initialPage: 0);
    _listOfCategories = _controller.getCategoryList(_controllerLogic, _changeBeginButton, _handleAdButton);
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
                child: Column(
                  children: [
                    Expanded(
                      flex: 7,
                      child: _categorySelector(context, _heightTotal * 0.5),
                    ),
                    Container(
                        height: 320,
                        child: _optionsMenu(_widthTotal)
                    ),
                    _beginButtonIsReady == true
                        ? Expanded(
                      flex: 1,
                      child: _beginGameButton(),
                    )
                        : Container()
                  ],
                ),
              )
        ),
      ),
    );
  }

  // ============================== SECTIONS ==============================

  Container _categorySelector(BuildContext context, double containerHeight) {
    return Container(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: containerHeight * 0.025),
                child: Text(
                    AppLocalization.of(context)
                        .translate('game_settings_main_title'),
                    style: _fontStyles.openSansSemiBold(29, Colors.black)),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: containerHeight * 0.025),
                child: Text(
                    AppLocalization.of(context)
                        .translate('game_settings_categories_title'),
                    style: _fontStyles.openSans(22, Colors.black)),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(color: Colors.black, width: 0.5),
                        bottom: BorderSide(color: Colors.black, width: 0.5)
                    ),
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
                  child: _listOfCategories,
                ),
              )
            ],
          ),
          Positioned(top: 10, left: 5, child: _otherWidgets.backButton(context))
        ],
      ),
    );
  }

  Column _optionsMenu(double width) {
    return Column(
      children: [
        Container(
          height: 295,
          child: PageView(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            children: [
              _playerSelector(_controllerLogic),
              _moreOptionsClass.optionButtons(
                  context,
                  width,
                  _controllerLogic,
                      () => {
                    setState(() {
                      _controllerLogic.setAllImpostors();
                      _allImpostorsColor == _unselectedOptionButton
                          ? _allImpostorsColor = _selectedOptionButton
                          : _allImpostorsColor = _unselectedOptionButton;
                    })
                  },
                      () => {
                    setState(() {
                      _controllerLogic.setNoImpostors();
                      _noImpostorsColor == _unselectedOptionButton
                          ? _noImpostorsColor = _selectedOptionButton
                          : _noImpostorsColor = _unselectedOptionButton;
                    })
                  },
                  _allImpostorsColor,
                  _noImpostorsColor
              )
            ],
          ),
        ),
        Container(
          height: 10,
          child: SmoothPageIndicator(
              controller: _pageController, // PageController
              count: 2,
              effect: WormEffect(), // your preferred effect
              onDotClicked: (index) {}),
        )
      ],
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
                        Divider(),
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
                        Divider(),
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

  void _handleAdButton() {
    // Show ad
    _newCategoryAd.show(
      anchorType: AnchorType.bottom,
      anchorOffset: 0.0,
      horizontalCenterOffset: 0.0
    );
    // Reload categories list with one extra secret category
    setState(() {
      _listOfCategories = _controller.getCategoryList(_controllerLogic, _changeBeginButton, _handleAdButton);
    });
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
                                'game_settings_error_dialog_button'))
                        ),
                      ),
                    )
                  ],
                )),
          ));
    }
  }
}
