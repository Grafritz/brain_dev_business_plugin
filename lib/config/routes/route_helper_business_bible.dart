import 'package:brain_dev_business/config/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteHelperBusinessBible
{
  //region [ URL COMPLET ]
  //static getSplashRoute() => splashPage;
  static String getHomeRoute({ String? liv, String? chap='1', String? ver='1' }) => '${RouteNameBusiness.routeBooks}?${RouteNameBusiness.livVar}=$liv&${RouteNameBusiness.chapVar}=$chap&${RouteNameBusiness.verVar}=$ver';
  static getReadBibleView({ String? liv, String? chap='1', String? ver='1' }) => '${RouteNameBusiness.routeReadBibleView}?${RouteNameBusiness.livVar}=$liv&${RouteNameBusiness.chapVar}=$chap&${RouteNameBusiness.verVar}=$ver';
  static getRouteVersionBible({ String? versionBible }) => '${RouteNameBusiness.routeVersionBible}${(versionBible==null) ?'':'?${RouteNameBusiness.versionBibleVar}=$versionBible'}';
  static getInformationScreen({ required String page }) => '${RouteNameBusiness.informationScreen}?${RouteNameBusiness.pageVar}=$page';
  static getTabLivreEtChapitreScreen({ int? indexTab }) => '${RouteNameBusiness.routeTabLivreEtChapitre}${(indexTab==null) ?'':'?${RouteNameBusiness.indexTabVar}=$indexTab'}';
  // static getRouteLoginPage({ String? redirect }) => '${RouteNameBusiness.routeLoginPage}${(redirect==null) ?'':'?${RouteNameBusiness.redirectVar}=$redirect'}';
  static getRouteRegisterPage({ String? redirect }) => '${RouteNameBusiness.registerPage}${(redirect==null) ?'':'?${RouteNameBusiness.redirectVar}=$redirect'}';
  static getRecoveryPasswordPage({ String? redirect }) => '${RouteNameBusiness.recoveryPasswordPage}${(redirect==null) ?'':'?${RouteNameBusiness.redirectVar}=$redirect'}';
  static getVerifyEmailPage({ String? redirect }) => '${RouteNameBusiness.verifyEmailPage}${(redirect==null) ?'':'?${RouteNameBusiness.redirectVar}=$redirect'}';
  static getRouteFormPlanDeLectureAddEdit({ String? codeLecture }) => '${(codeLecture==null) ?RouteNameBusiness.routeFormPlanDeLectureAdd:RouteNameBusiness.routeFormPlanDeLectureEdit}${(codeLecture==null) ?'':'?${RouteNameBusiness.codeLectureVar}=$codeLecture'}';
  static getRoutePlanDeLectureTabs({ int? tab }) => '${RouteNameBusiness.routePlanDeLectureTabs}${(tab==null) ?'':'?${RouteNameBusiness.indexTabVar}=$tab'}';
  static getRoutePdlProgressionFriends({ String? codeLecture }) => '${RouteNameBusiness.routePdlProgressionFriends}${(codeLecture==null) ?'':'?${RouteNameBusiness.codeLectureVar}=$codeLecture'}';
  static getPdlListByCategoryPage({ required String codeCategory, String? idUser }) => '${RouteNameBusiness.routePdlListByCategoryPage}?${RouteNameBusiness.codeCategoryVar}=$codeCategory&${RouteNameBusiness.userVar}=${(idUser==null) ?'SYS':idUser}';
  static getPlanDeLectureDetails({ required String codeLecture, required String codeSubscription, bool view=false }) =>
      '${RouteNameBusiness.routePlanDeLectureDetails}?1=1${(codeSubscription.isEmpty) ?'':'&${RouteNameBusiness.idVar}=$codeSubscription'}${(codeLecture.isEmpty) ?'':'&${RouteNameBusiness.codeLectureVar}=$codeLecture'}&${RouteNameBusiness.viewVar}=$view';
  static getRouteOpenPageCCG() => RouteNameBusiness.routeCCG;
  //endregion

  //region [ NAVIGATOR PAGES ]
  static navToPage(String? redirect) {
    if( redirect!=null && redirect.isNotEmpty){
      Get.toNamed(redirect);
    }else {
      Get.back();
    }
  }
  static navHome() => Get.toNamed(RouteNameBusiness.homeDefault);
  static navHome2() => Navigator.pushNamed(Get.context!, RouteNameBusiness.homeDefault);
  static navReadBibleView({ String? liv, String? chap='1', String? ver='1' } ) => Navigator.pushNamed(Get.context!, getReadBibleView(liv: liv, chap: chap, ver: ver));
  static navHomeReplacedRoute({ String? liv, String? chap='1', String? ver='1' } ) => Navigator.pushReplacementNamed(Get.context!, getHomeRoute(liv: liv, chap: chap, ver: ver));
  static navVersionBible({ String? versionBible } ) => Navigator.pushNamed(Get.context!, getRouteVersionBible(versionBible: versionBible));
  static navProfileScreen() => Navigator.pushNamed(Get.context!, RouteNameBusiness.profilePage);

  // static navLoginPage({ String? redirect }) => Get.toNamed(getRouteLoginPage(redirect: redirect));
  //static navLoginPageReplacement({ String? redirect }) => Navigator.pushReplacementNamed(Get.context!, getRouteLoginPage(redirect: redirect));
  // static navLoginPageReplacement({ String? redirect }) => Get.toNamed( getRouteLoginPage(redirect: redirect));

  // static navRegisterPage({ String? redirect }) => Get.toNamed(getRouteRegisterPage(redirect: redirect));
  // static navRecoveryPasswordPage({ String? redirect }) => Get.toNamed(getRecoveryPasswordPage(redirect: redirect));
  // static navVerifyEmailPage({ String? redirect }) => Get.toNamed(getVerifyEmailPage(redirect: redirect));
  // static navEditProfileScreen() => Navigator.pushNamed(Get.context!, RouteNameBusiness.editProfileScreen);
  // static navInformationScreen({ required String page }) => Navigator.pushNamed(Get.context!, getInformationScreen(page: page));
  static navTabLivreEtChapitre({ int? indexTab }) => Navigator.pushNamed(Get.context!, getTabLivreEtChapitreScreen( indexTab: indexTab ));
  static navRecherche() => Navigator.pushNamed(Get.context!, RouteNameBusiness.routeRecherche);
  static navSplitHomePage() => Navigator.pushNamed(Get.context!, RouteNameBusiness.routeSplitHomePage);
  static navFormPlanDeLectureAddEdit({ String? codeLecture }) => Get.toNamed(getRouteFormPlanDeLectureAddEdit(codeLecture: codeLecture));
  static navPlanDeLectureTabs({ int? tab }) => Navigator.pushNamed(Get.context!, getRoutePlanDeLectureTabs(tab: tab));
  static navPdlProgressionFriends({ String? codeLecture }) => Get.toNamed(getRoutePdlProgressionFriends(codeLecture: codeLecture));
  static navPdlListByCategoryPage({ required String codeCategory, String? idUser }) => Get.toNamed( getPdlListByCategoryPage(codeCategory: codeCategory, idUser: idUser));
  static navPlanDeLectureDetails({ required String codeLecture, required String codeSubscription, bool view=false }) => Get.toNamed( getPlanDeLectureDetails(codeSubscription: codeSubscription, codeLecture: codeLecture, view: view) );
  static navNotes() => Get.toNamed( RouteNameBusiness.routeNotes );
  static navBookmark() => Get.toNamed( RouteNameBusiness.routeBookmark );
  static navDashBoardQuizTabs() => Get.toNamed( RouteNameBusiness.routeDashBoardQuizTabs );
  static navMainAdmin() => Get.toNamed( RouteNameBusiness.routeMainAdmin );
  static navProgressionDeLectureTabs() => Get.toNamed( RouteNameBusiness.routeProgressionDeLectureTabs );
  static navParametresSystems() => Get.toNamed( RouteNameBusiness.routeParametresSystems );
  static navQuizDashBoard() => Get.toNamed( RouteNameBusiness.routeQuizDashBoard );
  static navQuizByBooks() => Get.toNamed( RouteNameBusiness.routeQuizByBooks );
  static navDashBordForms() => Get.toNamed( RouteNameBusiness.routeDashBordForms );
  static navQuizFormShared() => Get.toNamed( RouteNameBusiness.routeQuizFormShared );

  static navOpenPageCCG() => Navigator.pushNamed(Get.context!, getRouteOpenPageCCG());
  //endregion

}