// ignore_for_file: constant_identifier_names
import 'dart:convert';

import 'package:brain_dev_business/config/routes/route_helper_business_auth.dart';
import 'package:brain_dev_business/models/users_model.dart';
import 'package:brain_dev_business/repository/user_repository.dart';
import 'package:brain_dev_tools/config/api/api_client.dart';
// import 'package:brain_dev_business/user_management/interfaces/user_service.dart';
import 'package:brain_dev_tools/tools/constant.dart';
import 'package:brain_dev_tools/tools/tools_log.dart';
import 'package:brain_dev_tools/tools/validation/type_safe_conversion.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class BusinessController extends GetxController implements GetxService//, UserService
{
  //UserService userService;
  ApiClient apiClient;
  SharedPreferences sharedPreferences;
  UserRepository userRepository;

  BusinessController({required this.sharedPreferences, required this.apiClient, required this.userRepository }) {
    getUserConnected();
  }


  //region userConnected
  UserModel _userConnected = UserModel(connecterYN: false);
  //UserModel get userConnected => _userConnected;
  //endregion

  //region [ UserConnect ]

  UserModel get userConnected {
    getUserConnected();
    return _userConnected;
  }

  set userConnected(UserModel user) {
    setUserConnected(user: user);
  }
  getUserConnectedPref() {
    String value = sharedPreferences.getString(Constant.USER_CONNECTED) ?? "";
    if (value != '') {
      return UserModel.fromJson(json.decode(value));
    }
    return UserModel(id: 0, connecterYN: false);
  }

  setUserConnectedPref({required UserModel user}) {
    _userConnected = user;
    var jsonVal = json.encode(user.toJson());
    // logCat('setUserConnected:$jsonVal');
    sharedPreferences.setString(Constant.USER_CONNECTED, jsonVal);
  }
  //endregion

  //region user Chef Profil
  UserModel userProfilPrivate = UserModel( connecterYN: false);
  UserModel userProfilPublic = UserModel( connecterYN: false);
  UserModel userEditProfil = UserModel( connecterYN: false);
  //endregion

  //region [ showCircularProgressIndicator ]
  bool _showCircularProgress = false;
  bool get showCircularProgress => _showCircularProgress;
  set showCircularProgress(bool show) {
    _showCircularProgress = show;
    update();
  }
  showCircularProgressIndicator({bool show = true}) {
    _showCircularProgress = show;
    update();
  }

  showDialogProgress({bool show = true}) =>
      showCircularProgressIndicator(show: show);
  //endregion

  checkIsConnecterYNOrOpenLoginPage({String? redirect}) async {
    await getUserConnected();
    if (!_userConnected.connecterYN) {
      RouteHelperBusinessAuth.navLoginPageReplacement(redirect: redirect);
    }
  }

  loginOrOpenPage(navRouteFormPlanDeLectureAddEdit, {String? redirect}) async {
    await getUserConnected();
    if (_userConnected.connecterYN) {
      navRouteFormPlanDeLectureAddEdit;
    }
    checkIsConnecterYNOrOpenLoginPage(redirect: redirect);
  }

  getUserConnected() async {
    try {
      _userConnected = await getUserConnectedPref();
      update();
    } catch (ex, trace) {
      logError(ex, trace: trace, position: 'UserBloc::getUserConnected()');
    }
  }

  setUserConnected({required UserModel user}) async {
    try {
      _userConnected = user;
      await setUserConnectedPref(user: user);
      update();
    } catch (ex, trace) {
      logError(ex, trace: trace, position: 'UserBloc::setUserConnected()');
    }
  }
  /// Appelé APRÈS la déconnexion locale (ex. fin de la session Keycloak, voir `brain_dev_keycloak_login`). Une erreur
  /// n'empêche jamais la déconnexion : l'utilisateur est déjà déconnecté de l'application.
  Future<void> Function()? onSignedOut;

  signOut(){
    setUserConnected(user: UserModel(id:0, connecterYN: false));
    final hook = onSignedOut;
    if (hook != null) {
      hook().catchError((Object ex, StackTrace trace) {
        logError(ex, trace: trace, position: 'BusinessController::signOut::onSignedOut');
      });
    }
  }


  /// Renouvelle le jeton d'accès avant de parler au Middleware : `ApiClient.getApiToken()` renouvelle le jeton Keycloak
  /// (ou obtient l'attestation de l'application pour l'usage sans compte, comme Mélodie). Plus aucun appel à
  /// l'ancienne API (`auto-authenticate`).
  Future refreshAccessToken() async {
    try {
      await apiClient.getApiToken();
    } catch (ex, trace) {
      logError(ex, trace: trace, position: 'refreshAccessToken()');
    }
  }

}
