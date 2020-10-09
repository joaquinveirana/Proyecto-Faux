import 'package:flutter/material.dart';
import '../pages/game_settings.dart';
import '../language_enum.dart';
import '../styles/fonts.dart';
import '../locale/app_localization.dart';
import '../widgets/bezier_container.dart';
import 'package:flag/flag.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  final FontStyles _fontStyles = FontStyles();
  final Tween<double> turnsTween = Tween<double>(begin: 1, end: 2,);
  Language _lang;
  AnimationController _controller;

  @override
  void initState() {
    _lang = Language.EN;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _controller.repeat(reverse: true);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: -height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: BezierContainer()),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: RotationTransition(
                      turns: turnsTween.animate(_controller),
                      child: Container(
                        child: Container(
                          width: 200,
                          height: 200,
                          padding: EdgeInsets.all(20),
                          child: FlutterLogo(),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      _startGameButton(),
                      _languageButtons(),
                      _howToPlayButton(),
                      _moreInformationButton()
                    ],
                  ),
                )
              ],
            ),
          ]
        ),
      ),
    );
  }

  // =========================== SECTIONS ===========================

  Container _startGameButton() {
    return Container(
      height: 80,
      width: 200,
      margin: EdgeInsets.all(10),
      child: Material(
        color: Colors.red,
        child: InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GameSettings(lang: _lang))),
          child: Center(
              child: Text(AppLocalization.of(context).translate('home_page_play_button_label'), style: _fontStyles.openSansSemiBold(30, Colors.black),)),
        ),
      ),
    );
  }

  Container _languageButtons() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Spacer(),
          _langButton(Language.EN, Flag('US', height: 30, width: 80),'home_page_lang_button_label_en'),
          Spacer(),
          _langButton(Language.ES, Flag('ES', height: 33, width: 80),'home_page_lang_button_label_es'),
          Spacer(),
        ],
      ),
    );
  }

  Container _langButton(Language lang, Flag fl, String label) {
    return Container(
      decoration: _lang == lang ? _selectedLangButton() : _unselectedLangButton(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _setLanguage(lang);
          },
          child: Column(
            children: [
              fl,
              Text(AppLocalization.of(context).translate(label), style: _fontStyles.openSans(16, Colors.black),),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _selectedLangButton(){
    return BoxDecoration(
      color: Colors.red
    );
  }

  BoxDecoration _unselectedLangButton(){
    return BoxDecoration(
      color: Colors.transparent
    );
  }

  Container _howToPlayButton() {
    return Container(
      height: 60,
      width: 150,
      margin: EdgeInsets.all(10),
      child: Material(
        color: Colors.green,
        child: InkWell(
          onTap: () {
          },
          child: Center(child: Text(AppLocalization.of(context).translate('home_page_how_to_play_button_label'), style: TextStyle(fontSize: 15),)),
        ),
      ),
    );
  }

  Container _moreInformationButton() {
    return Container(
      height: 60,
      width: 150,
      margin: EdgeInsets.all(10),
      child: Material(
        color: Colors.green,
        child: InkWell(
          onTap: () {
          },
          child: Center(child: Text(AppLocalization.of(context).translate('home_page_about_button_label'), style: TextStyle(fontSize: 15),)),
        ),
      ),
    );
  }

  // =========================== FUNCTIONS ===========================

  void _setLanguage(Language lang) async {
    switch(lang) {
      case Language.ES:
        await AppLocalization.of(context).setLocale(Locale('es', 'ESP'));
        setState(() {
          _lang = Language.ES;
        });
        break;
      case Language.EN:
        await AppLocalization.of(context).setLocale(Locale('en', 'US'));
        setState(() {
          _lang = Language.EN;
        });
        break;
    }

  }
}