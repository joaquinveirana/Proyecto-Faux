import 'package:faux_artista_the_game/controller/controller_logic.dart';
import 'package:faux_artista_the_game/locale/app_localization.dart';
import 'package:faux_artista_the_game/styles/colors.dart';
import 'package:faux_artista_the_game/styles/fonts.dart';
import 'package:faux_artista_the_game/styles/gradient_effect.dart';
import 'package:flutter/material.dart';

class CustomAdTile extends StatefulWidget {

  final dynamic _notifyParentFunction;
  CustomAdTile({dynamic notifyParentFunction}) : this._notifyParentFunction = notifyParentFunction;

  dynamic getNotifyParentFunction() => this._notifyParentFunction;

  @override
  _CustomAdTileState createState() => _CustomAdTileState();
}

class _CustomAdTileState extends State<CustomAdTile> {
  final FontStyles _fontStyles = FontStyles();
  final AppColors _colors = AppColors();
  LinearGradient color;

  @override
  void initState() {
    super.initState();
    color = _colors.gameSettingsAdButtonGradient();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          gradient: _colors.gameSettingsSelectedButtonGradient(),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(2, 2), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(8)
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () {
            // Llamo funcion en el padre para modificar color de comenzar
            widget.getNotifyParentFunction()();
          },
          child: ListTile(
            title: RichText(
                text: TextSpan(
                    style: _fontStyles.openSansSemiBold(20, Colors.black),
                    children: [
                      TextSpan(text: AppLocalization.of(context).translate("game_settings_ad_title")+" "),
                      WidgetSpan(
                        child: Icon(Icons.add, size: 25),
                      ),
                      TextSpan(text: " (ad)", style: TextStyle(fontSize: 12)),
                    ]
                )
            ),
          ),
        ),
      ),
    );
  }
}
