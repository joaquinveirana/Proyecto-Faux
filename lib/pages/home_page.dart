import 'package:flutter/material.dart';
import 'package:flag/flag.dart';
import '../pages/how_to_play_page.dart';
import '../pages/game_settings_page.dart';
import '../language_enum.dart';
import '../styles/fonts.dart';
import '../locale/app_localization.dart';
import '../functions/navigator_transition.dart';
import '../styles/gradient_effect.dart';
import '../pages/about_page.dart';
import '../widgets/home_page_widgets/home_page_alerts.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final FontStyles _fontStyles = FontStyles();
  final NavigatorTransition _navigator = NavigatorTransition();
  final HomePageAlert _homePageAlert = HomePageAlert();
  Language _appLang;

  @override
  void initState() {
    _appLang = Language.EN;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: _logoGradient(),
                  ),
                  Container(
                    child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: 'Faux', style: _fontStyles.dancingScript(90, Colors.black)),
                            TextSpan(text: '  The Game', style: _fontStyles.openSans(22, Colors.black))
                          ],
                        )
                    ),
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
                    colors: [Color(0xff33A3fC), Color(0xffff3389), Color(0xff5ad3a9), Color(0xffe7c90b)],
                    bottom: Color(0xff30c0cc),
                    top: Color(0xff33A3fC),
                    shape: 0,
                    borderRadius: 0.0,
                    child: Container(
                        width: 280,
                        height: 280,
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
                    width: 280,
                    height: 280,
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
                    () => Navigator.of(context)
                        .push(_navigator.createRoute(About())),
                AppLocalization.of(context)
                    .translate('home_page_about_button_label'),
                [Color(0xff30c0cc), Color(0xff33A3fC)],
                20,
                false)),
        Expanded(
            child: _button(
                () => _homePageAlert.showLanguageAlert(context, _setLanguage, _appLang),
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