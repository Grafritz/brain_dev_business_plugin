// ignore_for_file: constant_identifier_names
import 'package:brain_dev_business/config/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteHelperBusinessAuth
{
  static getRouteLoginPage({String? redirect}) => '${RouteNameBusiness.routeLogin}${(redirect == null) ? '' : '?${RouteNameBusiness.redirectVar}=$redirect'}';
  static getRouteLoginPageWeb({String? redirect}) => '${RouteNameBusiness.routeLoginWeb}${(redirect == null) ? '' : '?${RouteNameBusiness.redirectVar}=$redirect'}';

  static getProfileScreen({ required String userId }) => '${RouteNameBusiness.profilePage}?${RouteNameBusiness.userVar}=$userId';
  static getInformationScreen({ required String page }) => '${RouteNameBusiness.informationScreen}?${RouteNameBusiness.pageVar}=$page';

  static navLoginPageReplacement({String? redirect}) =>
      Navigator.pushReplacementNamed(
          Get.context!, getRouteLoginPage(redirect: redirect));

  //region [ NAVIGATOR PAGES ]
  static navToPage(String? redirect) {
    if (redirect != null && redirect.isNotEmpty) {
      Get.toNamed(redirect);
    } else {
      Get.back();
    }
  }

  static navToReplacementPage(String redirect) {
    if (redirect.isNotEmpty) {
      Navigator.pushReplacementNamed(
          Get.context!, redirect);
    }
  }
  //endregion


  // static navigateToInformationScreen(String title, {widgetBannerBottomNavigation}) {
  //   Navigator.push(
  //     Get.context!,
  //     MaterialPageRoute(
  //         builder: (context) => InformationScreen(information: title, widgetBannerBottomNavigation: widgetBannerBottomNavigation)),
  //   );
  // }
  // static navigateLoginPage({ String? redirect }) {
  //   Navigator.push(
  //     Get.context!,
  //     MaterialPageRoute(
  //         builder: (context) => LoginPage(redirect: redirect,)),
  //   );
  // }
  // static navigateLoginPageWeb({ String? redirect }) {
  //   Navigator.push(
  //     Get.context!,
  //     MaterialPageRoute(
  //         builder: (context) => LoginPageWeb(redirect: redirect,)),
  //   );
  // }

  static navProfileScreen({ required String userId }) => Navigator.pushNamed(Get.context!, getProfileScreen(userId: userId));
  static navLoginPage2({ String? redirect }) => Get.toNamed(getRouteLoginPage(redirect: redirect));
  static navLoginPage({ String? redirect }) => Navigator.pushNamed(Get.context!, getRouteLoginPage());
  static navLoginPageWeb({ String? redirect }) => Navigator.pushNamed(Get.context!, getRouteLoginPageWeb());
  static navLoginPageReplace() => Navigator.pushReplacementNamed(Get.context!, getRouteLoginPage());
  static navEditProfileScreen() => Navigator.pushNamed(Get.context!, RouteNameBusiness.editProfileScreen);
  static navInformationScreen({ required String page }) => Navigator.pushNamed(Get.context!, getInformationScreen(page: page));

}