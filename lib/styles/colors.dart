import 'package:flutter/material.dart';

class AppColors {
  LinearGradient gameSettingsSelectedButtonGradient() {
    return LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xff19c5ff), Color(0xff33A3fC)]
    );
  }

  LinearGradient gameSettingsBannerGradient() {
    return LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xff30c0cc), Color(0xff33A3fC)]
    );
  }

  LinearGradient gameSettingsUnselectedButtonGradient() {
    return LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Colors.black12, Colors.black12]
    );
  }

}