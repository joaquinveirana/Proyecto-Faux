import 'package:flutter/material.dart';
import '../../locale/app_localization.dart';
import '../../styles/colors.dart';
import '../../styles/fonts.dart';

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
    color = _colors.gameSettingsSelectedButtonGradient();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          gradient: _colors.gameSettingsSelectedButtonGradient(),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(2, 2), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(16)
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {
            // Llamo funcion en el padre para modificar color de comenzar
            widget.getNotifyParentFunction()();
          },
          child: ListTile(
            title: RichText(
                text: TextSpan(
                    style: _fontStyles.openSans(20, Colors.black),
                    children: [
                      TextSpan(text: AppLocalization.of(context).translate("game_settings_ad_title")+" "),
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
