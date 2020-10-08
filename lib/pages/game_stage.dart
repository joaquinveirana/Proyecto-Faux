import 'package:faux_artista_the_game/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameStage extends StatefulWidget {
  final Map<String, dynamic> _data;
  GameStage({Map<String, dynamic> data}) : this._data = data;

  Map<String,dynamic> getData() {
    return this._data;
  }

  @override
  _GameStageState createState() => _GameStageState();
}

class _GameStageState extends State<GameStage> {

  bool _showRole;
  PageController _pageController;

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
          child: PageView(
            controller: _pageController,
            //physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            onPageChanged: (index) {
            },
            children: _createPlayerScreens(_data)
          ),
        ),
      )
    );
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
              child: Text(AppLocalization.of(context).translate("game_stage_first_step"),
                style: GoogleFonts.playfairDisplay(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              )
          ),
          Container(
            margin: EdgeInsets.all(30),
            child: Text(AppLocalization.of(context).translate(data['category']),
              style: GoogleFonts.playfairDisplay(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            )
          ),
          InkWell(
            onTap: (){
              _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
            },
            child: Container(
              width: 250,
              height: 100,
              color: Colors.green[200],
              child: Center(
                  child: Text(AppLocalization.of(context).translate("game_stage_first_button"),
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
            ),
          ),
        ],
      ),
    ));

    // Agrego las pantallas de cada jugador
    int indexPlayer = 1;
    _players.forEach((element) {
      _playerScreens.add(
        _newScreen(element, indexPlayer, data['word'])
      );
      indexPlayer++;
    });
    return _playerScreens;
  }

  Container _newScreen(int typePlayer, int numPlayer, String wordIndex) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Text(AppLocalization.of(context).translate("game_stage_player_title") + "  " + numPlayer.toString(),
                style: GoogleFonts.playfairDisplay(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                )),
          ),
          _showRole == false
              ? InkWell(
            onTap: (){
              setState(() {
                _showRole = true;
              });
            },
            child: Container(
              width: 250,
              height: 100,
              color: Colors.red[200],
              child: Center(
                  child: Text(AppLocalization.of(context).translate("game_stage_button_label"),
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
            ),
          )
              : Container(),
          _showRole == true
              ? Container(
            margin: EdgeInsets.all(20),
            child: typePlayer == 0
                ? Text(AppLocalization.of(context).translate("game_stage_artist_title"),
                style: GoogleFonts.playfairDisplay(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ))
                : Text(AppLocalization.of(context).translate("game_stage_impostor_title"),
                style: GoogleFonts.playfairDisplay(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                )),
          )
              : Container(),
          _showRole == true
              ? Container(
                margin: EdgeInsets.all(20),
            child: typePlayer == 0
              ? Text(AppLocalization.of(context).translate(wordIndex),
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                ))
              : Text(AppLocalization.of(context).translate("game_stage_impostor_hint"),
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                )),
          )
              : Container(),
          _showRole == true
              ? InkWell(
            onTap: (){
              _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
              setState(() {
                _showRole = false;
              });
            },
            child: Container(
              width: 250,
              height: 100,
              color: Colors.green[200],
              child: Center(
                  child: Text(AppLocalization.of(context).translate("game_stage_next_player"),
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
            ),
          )
              : Container()
        ],
      ),
    );
  }

}
