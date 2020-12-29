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
      Function playOnThisDeviceFunction,
      bool impostorValue,
      bool noImpostorValue,
      bool playOnThisDeviceValue,
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
                    false,
                    impostorValue,
                    width,
                    controller,
                    impostorFunction,
                    'game_settings_more_options_all_impostors',
                    'game_settings_more_options_all_impostors_desc',
                    context),
                _optionButton(
                    false,
                    noImpostorValue,
                    width,
                    controller,
                    noImpostorFunction,
                    'game_settings_more_options_no_impostors',
                    'game_settings_more_options_no_impostors_desc',
                    context),
                _optionButton(
                    true,
                    playOnThisDeviceValue,
                    width,
                    controller,
                    playOnThisDeviceFunction,
                    'game_settings_more_options_play_device',
                    'game_settings_more_options_play_device_desc',
                    context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _optionButton(
      bool isLast,
      bool state,
      double width,
      ControllerLogic controller,
      Function tapFunction,
      String title,
      String subTitle,
      BuildContext context) {
    return Container(
      height: isLast
          ? 70
          : 60,
      width: width * 0.9,
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          border: Border(
            bottom: isLast
                ? BorderSide(color: Colors.transparent, width: 0)
                : BorderSide(color: Colors.black, width: 1),
          ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(AppLocalization.of(context).translate(title),
                        style: _fontStyles.openSansBold(14, Colors.black)),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(AppLocalization.of(context).translate(subTitle),
                        style: _fontStyles.openSans(13, Colors.black)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
                child: Switch(
                  value: state,
                  onChanged: (value) {
                    tapFunction(value);
                  },
                ),
              )
          )
        ],
      ),
    );
  }
}