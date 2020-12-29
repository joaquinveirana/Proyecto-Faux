import 'package:flutter/material.dart';

class AppColors {
  LinearGradient gameSettingsSelectedButtonGradient() {
    return LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [Color(0xff19c5ff), Color(0xff33A3fC)]
    );
  }

  LinearGradient gameSettingsBannerGradient() {
    return LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [Color(0xff30c0cc), Color(0xff33A3fC)]
    );
  }

  LinearGradient gameSettingsUnselectedButtonGradient() {
    return LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xfff6f7f8), Color(0xfff6f7f8)]
    );
  }

}