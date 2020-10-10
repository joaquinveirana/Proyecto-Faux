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
  AnimationController _controller;

  @override
  void initState() {
    _appLang = Language.EN;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _controller.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double _widthTotal = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: GradientEffect(
        colors: [
          Colors.blue,
          Colors.deepPurple,
          Colors.deepOrange,
        ],
        bottom: Colors.red,
        top: Colors.yellow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 9,
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: Container(
                              width: 320,
                              height: 320,
                              decoration: BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.blue)),
                              margin: EdgeInsets.all(30)),
                        ),
                        Center(
                          child: Container(
                              width: 300,
                              height: 300,
                              margin: EdgeInsets.all(30),
                              child: Image.asset('images/FauxLogo.png')),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                children: [
                  Expanded(
                      child: _homeButton(
                          () => Navigator.of(context)
                                  .push(_navigator.createRoute(GameSettings(
                                lang: _appLang,
                              ))),
                          AppLocalization.of(context)
                              .translate('home_page_play_button_label'),
                          [Color(0xff30c0cc), Color(0xff33A3fC)],
                          20,
                          false)),
                  Expanded(
                      child: _homeButton(
                          () => {},
                          AppLocalization.of(context)
                              .translate('home_page_how_to_play_button_label'),
                          [Color(0xffffffff), Color(0xffffffff)],
                          20,
                          false)),
                  Expanded(
                      child: _homeButton(
                          () => {},
                          AppLocalization.of(context)
                              .translate('home_page_about_button_label'),
                          [Color(0xffffffff), Color(0xffffffff)],
                          20,
                          false)),
                  Expanded(
                      child: _homeButton(
                          () => _showLanguageAlert(),
                          AppLocalization.of(context)
                              .translate('home_page_language_button_label'),
                          [Color(0xffffffff), Color(0xffffffff)],
                          20,
                          true)),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            )
          ],
        ),
      )),
    );
  }

  // =========================== SECTIONS ===========================

  Container _homeButton(Function navigator, String label,
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

  Container _languageButton() {
    return Container(
        width: 300,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(2, 2), // changes position of shadow
              )
            ]),
        margin: EdgeInsets.all(10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.blue,
            onTap: () {
              _showLanguageAlert();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    AppLocalization.of(context)
                        .translate('home_page_language_button_label'),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  width: 45,
                  child: _appLang == Language.ES
                      ? Flag('ES', height: 18, width: 65)
                      : Flag('US', height: 18, width: 65),
                )
              ],
            ),
          ),
        ));
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
                      child: _langButton(
                          Language.EN,
                          Flag('US', height: 35, width: 85),
                          'home_page_lang_button_label_en'),
                    ),
                    Spacer(),
                    _langButton(Language.ES, Flag('ES', height: 38, width: 85),
                        'home_page_lang_button_label_es'),
                    Spacer(),
                  ],
                ),
              ),
            ));
  }

  Container _langButton(Language lang, Flag fl, String label) {
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
