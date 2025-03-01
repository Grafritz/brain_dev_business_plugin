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
  signOut(){
    setUserConnected(user: UserModel(id:0, connecterYN: false));
  }


  Future tryTokenAutoAuthenticate() async {
    try {
      await apiClient.getApiToken();
      if (apiClient.bearerTokenExpirationDate.isNotEmpty) {
        var dateNow = TypeSafeConversion.nullSafeInt(Constant.format_yyyyMMdd.format(DateTime.now()));
        var dateExpiration = TypeSafeConversion.nullSafeInt(apiClient.bearerTokenExpirationDate);
        if (dateNow >= dateExpiration) {
          await userRepository.tryTokenAutoAuthenticate();
        }
      } else {
        await userRepository.tryTokenAutoAuthenticate();
      }
    } catch (ex, trace) {
      logError(ex, trace: trace, position: 'tryTokenAutoAuthenticate()');
    }
  }

}
