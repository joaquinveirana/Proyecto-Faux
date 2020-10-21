import 'package:flag/flag.dart';
import 'package:flutter/material.dart';

import '../../locale/app_localization.dart';
import '../../styles/fonts.dart';
import '../../language_enum.dart';

class HomePageAlert {
  final FontStyles _fontStyles = FontStyles();

  void showLanguageAlert(BuildContext context, Function changeLang, Language appLang) {
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
                    context,
                    changeLang,
                    Flag('US', height: 35, width: 85),
                    appLang,
                    Language.EN,
                    'home_page_lang_button_label_en'),
                ),
                Spacer(),
                Container(
                  child: _alertLangButton(
                    context,
                    changeLang,
                    Flag('ES', height: 38, width: 85),
                    appLang,
                    Language.ES,
                    'home_page_lang_button_label_es'),
                ),
                Spacer(),
              ],
            ),
          ),
        ));
  }

  Container _alertLangButton(BuildContext context, Function setLang, Flag fl, Language appLang, Language lang, String label) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
        color: appLang == lang ? Colors.blue[100] : Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.all(10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.blue,
          onTap: () {
            setLang(lang);
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
}