import 'package:flutter/material.dart';
import 'package:faux_artista_the_game/language_enum.dart';

class GameSettings extends StatefulWidget {
  Language _lang;
  GameSettings({Language lang}) : _lang = lang;

  Language getLang() {
    return _lang;
  }

  @override
  _GameSettingsState createState() => _GameSettingsState();
}

class _GameSettingsState extends State<GameSettings> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
