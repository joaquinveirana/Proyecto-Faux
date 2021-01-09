import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../controller/controller_logic.dart';
import '../controller/controller_category_list_view.dart';
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
  final ControllerCategoryListView _controller = ControllerCategoryListView();
  final FontStyles _fontStyles = FontStyles();
  final AppColors _colors = AppColors();
  final OtherWidgets _otherWidgets = OtherWidgets();
  final MoreOptions _moreOptionsClass = MoreOptions();
  ControllerLogic _controllerLogic = ControllerLogic();

  int _helpIndex;
  Positioned _helpMsg1, _helpMsg2, _helpMsg3;

  int _numImpostors = 1;
  int _numPlayers = 5;
  List<int> _categoriesSelected = [];
  LinearGradient _beginButtonColor,
      _selectedOptionButton,
      _unselectedBeginButton;
  PageController _pageController;
  String _beginButtonText, _searchText;
  bool _beginButtonIsReady,
      _showSecretCategory,
      _allImpostorsValue,
      _noImpostorsValue,
      _playOnThisDeviceValue;
  InterstitialAd _newCategoryAd;

  @override
  void initState() {
    _newCategoryAd = AdManager.getNewInterstitialAd;
    _newCategoryAd.load();

    _controllerLogic = ControllerLogic();
    _selectedOptionButton = _colors.gameSettingsSelectedButtonGradient();
    _unselectedBeginButton = _colors.gameSettingsUnselectedButtonGradient();
    _playOnThisDeviceValue = false;
    _allImpostorsValue = false;
    _noImpostorsValue = false;
    _beginButtonColor = _unselectedBeginButton;
    _beginButtonText = '';
    _searchText = '';
    _showSecretCategory = false;
    _beginButtonIsReady = false;
    _pageController = PageController(initialPage: 0);
    _helpIndex = 0;
    _helpMsg1 = Positioned(top: 0, left: 0, child: Container(),);
    _helpMsg2 = Positioned(top: 0, left: 0, child: Container(),);
    _helpMsg3 = Positioned(top: 0, left: 0, child: Container(),);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double _safePadding = MediaQuery.of(context).padding.top;
    final double _heightTotal =
        MediaQuery.of(context).size.height - _safePadding;
    final double _widthTotal = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: [
            Container(
                color: Colors.grey[200],
                child: Container(
                  margin: EdgeInsets.all(5),
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
                        child: _categorySelector(context, _heightTotal * 0.5, _widthTotal),
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
            _helpIndex != 0
                ? InkWell(
                  onTap: () {
                    if (_helpIndex == 1) {
                      setState(() {
                        _helpMsg1 = Positioned(top: 0, left: 0, child: Container(),);
                        _helpMsg2 = _otherWidgets.helpMessage(_widthTotal, _widthTotal * 0.8, 130,  AppLocalization.of(context).translate('help_msj_2'), _heightTotal * 0.45, _widthTotal * 0.1 - 5);
                        _helpMsg3 = Positioned(top: 0, left: 0, child: Container(),);
                        _helpIndex = 2;
                      });
                    } else if (_helpIndex == 2) {
                      setState(() {
                        _helpMsg1 = Positioned(top: 0, left: 0, child: Container(),);
                        _helpMsg2 = Positioned(top: 0, left: 0, child: Container(),);
                        _helpMsg3 = _otherWidgets.helpMessageFromBottom(_widthTotal, _widthTotal * 0.8, 130,  AppLocalization.of(context).translate('help_msj_3'), 40, _widthTotal * 0.1 - 5);
                        _helpIndex = 3;
                      });
                    } else if (_helpIndex == 3) {
                      setState(() {
                        _helpMsg1 = Positioned(top: 0, left: 0, child: Container(),);
                        _helpMsg2 = Positioned(top: 0, left: 0, child: Container(),);
                        _helpMsg3 = Positioned(top: 0, left: 0, child: Container(),);
                        _helpIndex = 0;
                      });
                    }
                  },
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.black38,
                  ),
                )
                : Container(),
            _helpMsg1,
            _helpMsg2,
            _helpMsg3,
          ]
        ),
      ),
    );
  }

  // ============================== SECTIONS ==============================

  Container _categorySelector(BuildContext context, double containerHeight, double width) {
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
                        top: BorderSide(color: Colors.black, width: 0.2),
                        bottom: BorderSide(color: Colors.black, width: 0.3)
                    )
                  ),
                  height: containerHeight * 0.9 - 60,
                  child: _controller
                      .getCategoryList(context, _controllerLogic, _changeBeginButton, _handleAdButton, _handleSearch, _searchText, _showSecretCategory),
                ),
              )
            ],
          ),
          Positioned(top: 10, left: 5, child: _otherWidgets.backButton(context,1)),
          Positioned(top: 9, right: 10,
              child: Container(
                child: IconButton(
                  icon: Icon(Icons.help, color: Colors.black, size: 25,),
                  onPressed: () {
                    setState(() {
                      _helpMsg1 = _otherWidgets.helpMessage(width, width * 0.8, 130,  AppLocalization.of(context).translate('help_msj_1'), 20, width * 0.1 - 5);
                      _helpIndex = 1;
                    });
                  },
                ),
              )
          )
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
                      (val) => {
                    setState(() {
                      _controllerLogic.setAllImpostors();
                      _allImpostorsValue = val;
                    })
                  },
                      (val) => {
                    setState(() {
                      _controllerLogic.setNoImpostors();
                      _noImpostorsValue = val;
                    })
                  },
                      (val) => {
                    setState(() {
                      _controllerLogic.setPlayOnThisDevice();
                      _playOnThisDeviceValue = val;
                    })
                  },
                  _allImpostorsValue,
                  _noImpostorsValue,
                  _playOnThisDeviceValue
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
                        color: Color(0xfff6f7f8),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0.7,
                            blurRadius: 1,
                            offset: Offset(2.5, 2.5),
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
                        Divider(
                          thickness: 0.5,
                          color: Colors.black45,
                        ),
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
                        color: Color(0xfff6f7f8),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0.8,
                            blurRadius: 1,
                            offset: Offset(2.5, 2.5),
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
                        Divider(
                          thickness: 0.5,
                          color: Colors.black45,
                        ),
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
      _showSecretCategory = true;
    });
  }

  void _handleSearch(String searchText) {
    setState(() {
      _searchText = searchText;
    });
  }

  void _validateBeginButton() {
    Map<String, dynamic> res = _controllerLogic.returnGame();
    res.putIfAbsent('categoryDecoded', () => AppLocalization.of(context).translateTopic(res['category'], 'title'));
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
