import 'dart:io';

class AdHelper {
  static String get admobBannerAdUnitId {
    if (Platform.isAndroid) {
      //return 'ca-app-pub-4032215289208659/9441703452'; //orijinal
      return 'ca-app-pub-3940256099942544/6300978111'; //test
    } else if (Platform.isIOS) {
      //return ''; //orijinal
      return 'ca-app-pub-3940256099942544/2934735716'; //test
    }
    throw UnsupportedError("Desteklenmeyen Platform");
  }

  static String get admobInterstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4032215289208659/4497085261'; //orijinal
      //return 'ca-app-pub-3940256099942544/1033173712'; //test
    } else if (Platform.isIOS) {
      //return ''; //oriinal
      return 'ca-app-pub-3940256099942544/4411468910'; //test
    }
    throw UnsupportedError("Desteklenmeyen Platform");
  }
}
