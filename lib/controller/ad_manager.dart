import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';

class AdManager {

  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-4146266121553594~3724286737";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_ADMOB_APP_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-4146266121553594/2683184723";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_INTERSTITIAL_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static InterstitialAd get getNewInterstitialAd {
    return InterstitialAd(
      adUnitId: AdManager.interstitialAdUnitId,
      listener: (MobileAdEvent event) {
        print(event);
      }
    );
  }

}