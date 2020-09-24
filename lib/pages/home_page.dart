import 'package:faux_artista_the_game/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:faux_artista_the_game/pages/game_settings.dart';
import 'package:faux_artista_the_game/language_enum.dart';

class HomePage extends StatefulWidget {



  @override
  State<StatefulWidget> createState() => _HomePageState();
}

/*
setState(() {
  AppLocalization.load(Locale('es', 'ESP'));
});
Text(
  AppLocalization.of(context).heyWorld,
  style: TextStyle(fontSize: 20),
)
 */


class _HomePageState extends State<HomePage> {
  Language _lang = Language.EN;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                color: Colors.blue,
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  _startGameButton(),
                  _languageButton(),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.green,
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _startGameButton() {
    return Container(
      height: 80,
      width: 200,
      margin: EdgeInsets.all(20),
      child: Material(
        color: Colors.red,
        child: InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GameSettings(lang: _lang))),
          child: Text("Play"),
        ),
      ),
    );
  }

  Container _languageButton() {
    return Container(
      height: 60,
      width: 150,
      margin: EdgeInsets.all(10),
      child: Material(
        color: Colors.green,
        child: InkWell(
          onTap: () {
            _setLanguage(Language.ES);
          },
          child: Text(AppLocalization.of(context).translate('lang')),
        ),
      ),
    );
  }

  void _setLanguage(Language lang) async {

    switch(lang) {
      case Language.ES:
        await AppLocalization.of(context).setLocale(Locale('es', 'ESP'));
        setState(() {});
        break;
      case Language.EN:
        setState(() {
          //AppLocalization.load(Locale('en', 'US'));
        });
        print("Ingles");
        break;
    }

  }
}