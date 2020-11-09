import 'package:flutter/material.dart';
import '../../styles/fonts.dart';
import '../../controller/controller_logic.dart';
import '../../locale/app_localization.dart';

class MoreOptions {
  FontStyles _fontStyles = FontStyles();

  Container optionButtons(
      BuildContext context,
      double width,
      ControllerLogic controller,
      Function impostorFunction,
      Function noImpostorFunction,
      LinearGradient impostorColor,
      LinearGradient noImpostorColor
      ) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
                AppLocalization.of(context)
                    .translate('game_settings_more_options_title'),
                style: _fontStyles.openSans(22, Colors.black)),
          ),
          Container(
            child: Column(
              children: [
                _optionButton(
                    true,
                    width,
                    controller,
                    impostorFunction,
                    impostorColor,
                    'game_settings_more_options_all_impostors',
                    'game_settings_more_options_all_impostors_desc',
                    context),
                _optionButton(
                    false,
                    width,
                    controller,
                    noImpostorFunction,
                    noImpostorColor,
                    'game_settings_more_options_no_impostors',
                    'game_settings_more_options_no_impostors_desc',
                    context)
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _optionButton(
      bool isFirst,
      double width,
      ControllerLogic controller,
      Function tapFunction,
      LinearGradient color,
      String title,
      String subTitle,
      BuildContext context) {
    return Container(
      height: 60,
      width: width * 0.9,
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black, width: 1),
            top: isFirst == true
                ? BorderSide(color: Colors.black, width: 1)
                : BorderSide(width: 0),
          ),
          gradient: color
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            tapFunction();
          },
          child: Column(
            children: [
              Text(AppLocalization.of(context).translate(title),
                  style: _fontStyles.openSansBold(13, Colors.black)),
              Text(AppLocalization.of(context).translate(subTitle),
                  style: _fontStyles.openSans(12, Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}