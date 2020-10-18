import 'package:faux_artista_the_game/pages/how_to_play.dart';
import 'package:flutter/material.dart';
import 'package:flag/flag.dart';
import '../pages/game_settings.dart';
import '../language_enum.dart';
import '../styles/fonts.dart';
import '../locale/app_localization.dart';
import '../functions/navigator_transition.dart';
import '../styles/gradient_effect.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final FontStyles _fontStyles = FontStyles();
  final NavigatorTransition _navigator = NavigatorTransition();
  Language _appLang;

  @override
  void initState() {
    _appLang = Language.EN;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: _logoGradient(),
                  ),
                  Container(
                    child: Text("Faux", style: _fontStyles.dancingScript(60, Colors.black),),
                  ),
                  Expanded(
                    flex: 6,
                    child: _homeButtons(),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  )
                ],
              ),
            ),
          )),
    );
  }

  // =========================== SECTIONS ===========================

  Container _logoGradient() {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 10),
      width: double.infinity,
      child: Column(
        children: [
          Stack(
            children: [
              Center(
                child: Container(
                  child: GradientEffect(
                    colors: [Colors.lightBlueAccent, Colors.green, Colors.deepPurple, Colors.red,],
                    bottom: Colors.blue,
                    top: Colors.blueAccent,
                    shape: 0,
                    borderRadius: 0.0,
                    child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.blue
                          ),
                          boxShadow:  [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              spreadRadius: 1.5,
                              blurRadius: 3,
                              offset: Offset(0, 2.5),
                            ),
                          ],
                        )
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                    width: 300,
                    height: 300,
                    child: Image.asset('images/FauxLogo.png')),
              )
            ],
          ),
        ],
      ),
    );
  }

  Column _homeButtons() {
    return Column(
      children: [
        Expanded(
            child: _button(
                    () => Navigator.of(context)
                    .push(_navigator.createRoute(GameSettings(lang: _appLang,))),
                AppLocalization.of(context)
                    .translate('home_page_play_button_label'),
                [Color(0xff30c0cc), Color(0xff33A3fC)],
                20,
                false)),
        Expanded(
            child: _button(
                    () => Navigator.of(context)
                    .push(_navigator.createRoute(HowToPlay())),
                AppLocalization.of(context)
                    .translate('home_page_how_to_play_button_label'),
                [Color(0xff30c0cc), Color(0xff33A3fC)],
                20,
                false)),
        Expanded(
            child: _button(
                    () => {},
                AppLocalization.of(context)
                    .translate('home_page_about_button_label'),
                [Color(0xff30c0cc), Color(0xff33A3fC)],
                20,
                false)),
        Expanded(
            child: _button(
                    () => _showLanguageAlert(),
                AppLocalization.of(context)
                    .translate('home_page_language_button_label'),
                [Color(0xff30c0cc), Color(0xff33A3fC)],
                20,
                true)),
      ],
    );
  }

  Container _button(Function navigator, String label,
      List<Color> backgroundColors, double fontSize, bool showFlag) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: backgroundColors),
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(2, 2), // changes position of shadow
            )
          ]),
      margin: EdgeInsets.all(10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.blue,
          onTap: () {
            navigator();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label, style: _fontStyles.openSans(fontSize, Colors.black)),
              showFlag == true
                  ? Container(
                width: 30,
                margin: EdgeInsets.only(left: 10),
                child: _appLang == Language.ES ? Flag('ES', height: 18, width: 65) : Flag('US', height: 18, width: 65),)
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguageAlert() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            height: 150,
            width: 300,
            child: Row(
              children: [
                Spacer(),
                Container(
                  child: _alertLangButton(
                      Language.EN,
                      Flag('US', height: 35, width: 85),
                      'home_page_lang_button_label_en'),
                ),
                Spacer(),
                _alertLangButton(Language.ES, Flag('ES', height: 38, width: 85),
                    'home_page_lang_button_label_es'),
                Spacer(),
              ],
            ),
          ),
        ));
  }

  Container _alertLangButton(Language lang, Flag fl, String label) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
        color: _appLang == lang ? Colors.blue[100] : Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.all(10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.blue,
          onTap: () {
            _setLanguage(lang);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              fl,
              Text(
                AppLocalization.of(context).translate(label),
                style: _fontStyles.openSans(14, Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================== FUNCTIONS ===========================

  void _setLanguage(Language lang) async {
    switch (lang) {
      case Language.ES:
        await AppLocalization.of(context).setLocale(Locale('es', 'ESP'));
        setState(() {
          _appLang = Language.ES;
        });
        Navigator.pop(context);
        break;
      case Language.EN:
        await AppLocalization.of(context).setLocale(Locale('en', 'US'));
        setState(() {
          _appLang = Language.EN;
        });
        Navigator.pop(context);
        break;
    }
  }
}
