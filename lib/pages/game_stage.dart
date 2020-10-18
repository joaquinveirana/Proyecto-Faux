import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../locale/app_localization.dart';
import '../styles/colors.dart';
import '../styles/fonts.dart';
import '../pages/end_page.dart';

class GameStage extends StatefulWidget {
  final Map<String, dynamic> _data;

  GameStage({Map<String, dynamic> data}) : this._data = data;

  Map<String, dynamic> getData() {
    return this._data;
  }

  @override
  _GameStageState createState() => _GameStageState();
}

class _GameStageState extends State<GameStage> {
  bool _showRole;
  PageController _pageController;
  final FontStyles _fonts = FontStyles();
  final AppColors _colors = AppColors();

  @override
  void initState() {
    _showRole = false;
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double _safePadding = MediaQuery.of(context).padding.top;
    final _heightTotal = MediaQuery.of(context).size.height - _safePadding;

    // Obtengo los datos de la partida
    Map<String, dynamic> _data = widget.getData();
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
              child: PageView(
                  controller: _pageController,
                  //physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index) {},
                  children: _createPlayerScreens(_data)),
            ),
          ),
        ));
  }

  // Creo las pantallas de cada jugador
  List<Container> _createPlayerScreens(Map<String, dynamic> data) {
    List<int> _players = data['players'];
    List<Container> _playerScreens = [];
    // Agrego la pantalla de Inicio
    _playerScreens.add(Container(
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.all(20),
              child: Text(
                  AppLocalization.of(context).translate("game_stage_first_step"),
                  style: _fonts.openSansSemiBold(28, Colors.black)
              )
          ),
          Divider(
            thickness: 1,
            indent: 30,
            endIndent: 30,
            color: Colors.black54,
          ),
          Container(
              margin: EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 10),
              child: Text(
                  AppLocalization.of(context).translate("game_stage_category_subtitle"),
                  style: _fonts.openSans(18, Colors.black)
              )),
          Container(
              margin: EdgeInsets.all(10),
              child: Text(
                  AppLocalization.of(context).translateTopic(data['category'],"title"),
                  style: _fonts.openSansSemiBold(30, Colors.black)
              )),
          Expanded(flex: 4, child: Container()),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 900),
                      curve: Curves.easeInOut);
                },
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                      gradient: _colors.gameSettingsBannerGradient()
                  ),
                  child: Center(
                      child: Text(
                          AppLocalization.of(context)
                              .translate("game_stage_first_button"),
                          style: _fonts.openSansSemiBold(22, Colors.black)
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    ));

    // Agrego las pantallas de cada jugador
    _players.asMap().forEach((index, element) {
      _playerScreens.add(_newScreen(element, index+1, data['category'], data['word'], index == _players.length-1));
    });
    return _playerScreens;
  }

  Container _newScreen(int typePlayer, int numPlayer, String category, String wordIndex, bool lastPlayer) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(30),
            child: Text(
                AppLocalization.of(context)
                    .translate("game_stage_player_title") +
                    "  " +
                    numPlayer.toString(),
                style: _fonts.openSans(30, Colors.black)),
          ),
          Divider(
            thickness: 1,
            indent: 30,
            endIndent: 30,
            color: Colors.black,
          ),
          _showRole == true
              ? Column(
            children: [
              Container(
                height: 100,
                padding: EdgeInsets.all(20),
                child: typePlayer == 0
                    ? Text(
                    AppLocalization.of(context)
                        .translate("game_stage_artist_title"),
                    style: _fonts.openSansSemiBold(30, Colors.black))
                    : Text(
                    AppLocalization.of(context)
                        .translate("game_stage_impostor_title"),
                    style: _fonts.openSansSemiBold(30, Colors.black)),
              ),
              Container(
                height: 40,
                padding: EdgeInsets.all(10),
                child: typePlayer == 0
                    ? Text(AppLocalization.of(context).translate("game_stage_artist_subtitle"),
                    style: _fonts.openSans(18, Colors.black))
                    : Text(""),
              ),
              Container(
                height: 80,
                padding: EdgeInsets.all(10),
                child: typePlayer == 0
                    ? Text(AppLocalization.of(context).translateTopic(category, wordIndex),
                    style: _fonts.openSansSemiBold(30, Colors.black))
                    : Text(
                    AppLocalization.of(context)
                        .translate("game_stage_impostor_hint"),
                    style: _fonts.openSans(20, Colors.black)),
              ),
              Container(
                height: 230,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    if(!lastPlayer) {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 1100),
                          curve: Curves.easeInOut);
                      setState(() {
                        _showRole = false;
                      });
                      } else {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EndPage()));
                    }
                  },
                  child: Container(
                    width: 280,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                        child: !lastPlayer
                            ? Text(
                          AppLocalization.of(context)
                              .translate("game_stage_next_player"),
                          style: _fonts.openSans(20, Colors.black),
                        )
                            : Text(
                          AppLocalization.of(context)
                              .translate("game_stage_end_button"),
                          style: _fonts.openSans(20, Colors.black),
                        )
                    ),
                  ),
                ),
              ),
            ],
          ) : Column(
            children: [
              Container(
                height: 450,
                child: Center(child: FaIcon(FontAwesomeIcons.question, size: 80,)),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _showRole = true;
                    });
                  },
                  child: Container(
                    width: 280,
                    height: 100,
                    decoration: BoxDecoration(
                        gradient: _colors.gameSettingsSelectedButtonGradient(),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                        child: Text(
                          AppLocalization.of(context)
                              .translate("game_stage_button_label"),
                          style: _fonts.openSans(20, Colors.black),
                        )),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
