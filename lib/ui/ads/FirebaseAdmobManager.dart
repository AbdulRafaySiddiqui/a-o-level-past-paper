import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

// class BannerAd extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }
// }

class FirebaseAdmobManager {
  // bool _isInit = false;
  // BannerAd _bottomBannerAd;
  // InterstitialAd interstitialAd;

  // //Modify the following for the actual Admob advertisement.
  // String appID = FirebaseAdMob.testAppId;
  // String bannerID = BannerAd.testAdUnitId;
  // String interstitialID = InterstitialAd.testAdUnitId;
  // String rewardedVideoAdID = RewardedVideoAd.testAdUnitId;

  // Function(MobileAdEvent) _interstitialAdListener;

  // init({
  //   MobileAdListener interstitialAdListener,
  //   RewardedVideoAdListener rewardedVideoListner,
  // }) async {
  //   _isInit = await FirebaseAdMob.instance.initialize(appId: appID);

  //   _bottomBannerAd = createBannerAd();

  //   _interstitialAdListener = interstitialAdListener;
  //   RewardedVideoAd.instance.listener = rewardedVideoListner;
  // }

  // dispose() {
  //   _bottomBannerAd.dispose();
  //   interstitialAd.dispose();
  //   _isInit = false;
  // }

  // static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  //   //testDevices: testDevice != null ? <String>[testDevice] : null,
  //   keywords: <String>['foo', 'bar'],
  //   contentUrl: 'http://foo.com/bar.html',
  //   childDirected: true,
  //   nonPersonalizedAds: true,
  // );

  // ///Banner AD
  // BannerAd createBannerAd() {
  //   return BannerAd(
  //     adUnitId: BannerAd.testAdUnitId,
  //     size: AdSize.banner,
  //     //targetingInfo: targetingInfo,
  //     listener: (MobileAdEvent event) {
  //       print("BannerAd event $event");
  //     },
  //   );
  // }

  // showBannerAd() {
  //   _bottomBannerAd ??= createBannerAd();
  //   _bottomBannerAd
  //     ..load()
  //     ..show();
  // }

  // removeBannerAd() {
  //   _bottomBannerAd?.dispose();
  //   _bottomBannerAd = null;
  // }

  // /*** Interstitial AD ***/
  // InterstitialAd createInterstitialAd() {
  //   return InterstitialAd(
  //     adUnitId: InterstitialAd.testAdUnitId,
  //     listener: _interstitialAdListener,
  //   );
  // }

  // loadInterstitialAd() async {
  //   interstitialAd?.dispose();
  //   interstitialAd = createInterstitialAd()..load();
  // }

  // // showInterstitialAd() {
  // //   interstitialAd ??= createInterstitialAd()..load();
  // //   interstitialAd.show();
  // // }

  // /*** RewardedVideo AD ***/
  // loadRewardedVideoAd() {
  //   RewardedVideoAd.instance
  //       .load(adUnitId: rewardedVideoAdID, targetingInfo: targetingInfo);
  // }

  // showRewardedVideoAd() {
  //   RewardedVideoAd.instance.show();
  // }

  Widget getBanner() {
    return AdmobBanner(
        key: UniqueKey(),
        adUnitId: _getBannerAdUnitId(),
        adSize: AdmobBannerSize.BANNER,
        listener: (AdmobAdEvent event, Map<String, dynamic> args) {
          switch (event) {
            case AdmobAdEvent.loaded:
              print('Admob banner loaded!');
              break;

            case AdmobAdEvent.opened:
              print('Admob banner opened!');
              break;

            case AdmobAdEvent.closed:
              print('Admob banner closed!');
              break;

            case AdmobAdEvent.failedToLoad:
              print(
                  'Admob banner failed to load. Error code: ${args['errorCode']}');
              break;
            case AdmobAdEvent.clicked:
              // TODO: Handle this case.
              break;
            case AdmobAdEvent.impression:
              // TODO: Handle this case.
              break;
            case AdmobAdEvent.leftApplication:
              // TODO: Handle this case.
              break;
            case AdmobAdEvent.completed:
              // TODO: Handle this case.
              break;
            case AdmobAdEvent.rewarded:
              // TODO: Handle this case.
              break;
            case AdmobAdEvent.started:
              // TODO: Handle this case.
              break;
          }
        });
  }

  AdmobInterstitial interstitialAd = AdmobInterstitial(
    adUnitId: 'ca-app-pub-3940256099942544/1033173712',
  );

  loadInterstitialAd() {
    interstitialAd.load();
  }

  showInterstitialAd() async {
    // Check if the ad is loaded and then show it
    if (await interstitialAd.isLoaded) {
      interstitialAd.show();
    }
  }

  disposeInterstitialAd() {
    // Finally, make sure you dispose the ad if you're done with it
    interstitialAd.dispose();
  }

  String _getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    return null;
  }
}
