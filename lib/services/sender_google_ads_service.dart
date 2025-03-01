import 'package:flutter/material.dart';

abstract class SenderGoogleAdsService
{
  int get recompenseAds;
  bool get isHaveRecompenseAds;

  bool isShowAds({required int index, int afterEveryItem=9, bool showAtZero=true});
  Widget getWidgetBanner();
  Widget getWidgetBannerFluid();
  Widget getWidgetBannerLargeBanner();
  Widget getWidgetBannerMediumRectangle();
  Widget getWidgetAdsMediumRectangle();
  
  Widget widgetRewardTextView();
  Widget widgetRewardView({ bool isSaveAfter = false, required setActionFunction});

  loadOnlyInterstitialAd();
  loadAndShowInterstitialAd();
  loadAndShowInterstitialAdQuickly();
  showDialogRecompense();
  showActionsDialogAds({required String title, bool isSaveAfter = false, Function? setActionFunction});

  void setRewardAmount({required int action});
  void setRewardAmountPlus({required int action, int amount = 0});

}