import 'dart:convert';
import 'dart:io';

import 'package:brain_dev_business/models/users_model.dart';
import 'package:brain_dev_tools/config/api/api_client.dart';
import 'package:brain_dev_tools/I10n/localization_constants.dart';
import 'package:brain_dev_tools/config/api/api_constant.dart';
import 'package:brain_dev_tools/models/message_model.dart';
import 'package:brain_dev_tools/models/security/device_info_model.dart';
import 'package:brain_dev_tools/tools/constant.dart';
import 'package:brain_dev_tools/tools/dialog_view.dart';
import 'package:brain_dev_tools/tools/tools_log.dart';
import 'package:brain_dev_tools/tools/validation/type_safe_conversion.dart';
import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:brain_dev_tools/tools/utils/utils.dart';
import 'package:brain_dev_tools/models/error/error_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  //UserDaoPref userDaoPref = UserDaoPref();
  ApiClient apiClient;
  SharedPreferences sharedPreferences;
  String tableName = Constant.USER_CONNECTED;

  UserRepository({required this.apiClient, required this.sharedPreferences});

  UserModel get userConnected {
    String value = sharedPreferences.getString(tableName) ?? "";
    if (value != '') {
      return UserModel.fromJson(json.decode(value));
    }
    return UserModel(id: 0, connecterYN: false);
  }

  set userConnected(UserModel user) {
    var jsonVal = json.encode(user.toJson());
    // logCat('setUserConnected:$jsonVal');
    sharedPreferences.setString(tableName, jsonVal);
  }
  getUserConnected() {
    String value = sharedPreferences.getString(tableName) ?? "";
    if (value != '') {
      return UserModel.fromJson(json.decode(value));
    }
    return UserModel(id: 0, connecterYN: false);
  }

  setUserConnected({required UserModel user}) {
    var jsonVal = json.encode(user.toJson());
    // logCat('setUserConnected:$jsonVal');
    sharedPreferences.setString(tableName, jsonVal);
  }
  String get dataFrom{
    DeviceInfoModel deviceInfo = DeviceInfoModel.fromJson(apiClient.deiceInfo.data);
    String data='';
    data += '${deviceInfo.name}, ${deviceInfo.model} ';
    data += ' / ${apiClient.packageInfo?.appName} ';
    data += '[ ${apiClient.packageInfo?.version}';
    data += '+${apiClient.packageInfo?.buildNumber} ]';
    return data;
  }
  bool checkPermission({List<String>? permissions, String? permission, String logicalOp = 'AND'})
  {
    UserModel user = userConnected;
    List<String> currentPermissions = user.permissions;
    if (user.role == Constant.GS_DEV) {
      return true;
    }
    if (currentPermissions.isEmpty) {
      return false;
    }
    if (permissions==null && permission==null) {
      return false;
    }
    bool hasPermission = false;
    if (permissions!=null && permissions.isNotEmpty) {
      for (final permission in permissions) {
        bool permissionFound = currentPermissions.contains(permission);

        if (permissionFound) {
          hasPermission = true;
          if (logicalOp == 'OR') {
            break;
          }
        } else {
          hasPermission = false;
          if (logicalOp == 'AND') {
            break;
          }
        }
      }
      return hasPermission;
    }
    if (permission!=null && permission.isNotEmpty) {
      return currentPermissions.contains(permission);
    }
    return hasPermission;
  }
  //region [  ]
  // Add device token to the database
  /*Future<String?> addDevice({required String fcmNewToken}) async {
    try {
      String fcmOldToken = await getFcmToken();
      String identifierForVendor = apiClient.getDeviceId();
      UserModel user = userConnected;

      String userId = user.userName;
      String apiUrl = ApiConstantDev.apiUrlSetDeviceToken;
      //region attributs
      DeviceInfoModel deviceInfo =
      DeviceInfoModel.fromJson(apiClient.deiceInfo.data);
      deviceInfo.userName = userId;
      deviceInfo.fcmOldToken = fcmOldToken;
      deviceInfo.fcmNewToken = fcmNewToken;
      deviceInfo.identifierForVendor = identifierForVendor;
      deviceInfo.buildName = apiClient.packageInfo?.version ?? '';
      deviceInfo.buildNumber = apiClient.packageInfo?.buildNumber ?? '';
      var param = deviceInfo.toJson();
      //endregion
      var response = await apiClient.postData(
          apiUrl: apiUrl, data: param, fName: 'addDevice');
      if (response.statusCode == HttpStatus.ok) {
        setFcmToken(fcmNewToken);
        return response.body;
      }
    } catch (ex, trace) {
      logError(ex, trace: trace, position: 'addDevice');
    }
    return null;
  }*/

  /*
  Future<String?> refreshDeviceToken({required String fcmNewToken}) async {
    try {
      String fcmOldToken = await getFcmToken();
      UserModel user = userConnected;
      String userId = user.userName;
      logCat(
          'addDevice:: userId: $userId \n| FCM OLD Token: $fcmNewToken \n| FCM NEW Token: $fcmNewToken');
      String apiUrl = ApiConstantDev.apiUrlRefreshDeviceToken;
      //region attributs
      Map<String, String> param = <String, String>{};
      param[UsersProperty.userName.columnName] = userId;
      param[UsersProperty.fcmOldToken.columnName] = fcmOldToken;
      param[UsersProperty.fcmNewToken.columnName] = fcmNewToken;
      //endregion
      var response = await apiClient.postData(
          apiUrl: apiUrl, data: param, fName: 'refreshDeviceToken');
      if (response.statusCode == HttpStatus.ok) {
        setFcmToken(fcmNewToken);
        return response.body;
      }
    } catch (ex, trace) {
      logError(ex, trace: trace, position: 'refreshDeviceToken');
    }
    return null;
  }
*/
  int tentative = 0;

//region [ UPDATE : Middleware (PUT api/users/me/profile) ]
  /// Met à jour mon profil. L'utilisateur est celui du jeton Keycloak : `userName` n'est jamais envoyé.
  /// Correspondance (le modèle de l'application s'adapte à celui de LyricStream) : `nomComplet` = `displayName`,
  /// `biographie` = `bio`, `photoPathUrl` = `avatarUrl`.
  Future updateProfile({ required UserModel user }) async {
    try {
      var response = await apiClient.putData(apiUrl: ApiConstantDev.urlMiddlewareMyProfile, data: profileBody(user), fName: 'updateProfile');
      if (response.statusCode==HttpStatus.badRequest) {
        final data = jsonDecode(response.body);
        ErrorResponseModel errorResponse = ErrorResponseModel.fromJson(data);
        String msg = ErrorResponseModel.messages(errorResponse: errorResponse);
        DialogView.showAlertDialog( msg: msg);
      }
      if (response.statusCode==HttpStatus.ok) {
        return userFromProfile(jsonDecode(response.body), base: user);
      }
    } on SocketException {
      setConnectivity();
    } catch (ex, trace) {
      logError(ex, trace:trace,position: 'updateProfile');
    }
    return null;
  }

  /// Même route : l'image est une adresse (`avatarUrl`) dans le profil de LyricStream.
  Future updatePhotoProfile({ required UserModel user }) => updateProfile(user: user);

  /// Corps de `PUT api/users/me/profile`.
  static Map<String, dynamic> profileBody(UserModel user) => {
        if (user.nomComplet.trim().isNotEmpty) 'displayName': user.nomComplet.trim(),
        'bio': user.biographie,
        if (user.photoPathUrl.startsWith('http')) 'avatarUrl': user.photoPathUrl,
      };

  /// Profil de LyricStream (`UserProfileDto`) → modèle de l'application. [base] garde ce que le serveur ne connaît pas.
  static UserModel userFromProfile(dynamic profile, {UserModel? base}) {
    final user = base ?? UserModel();
    if (profile is! Map) return user;
    user.userName = TypeSafeConversion.nullSafeString(profile['userName']).isEmpty ? user.userName : TypeSafeConversion.nullSafeString(profile['userName']);
    user.nomComplet = TypeSafeConversion.nullSafeString(profile['displayName']);
    user.biographie = TypeSafeConversion.nullSafeString(profile['bio']);
    final avatar = TypeSafeConversion.nullSafeString(profile['avatarUrl']);
    user.photoPath = avatar;
    user.photoPathUrl = avatar;
    user.connecterYN = true;
    return user;
  }
  //endregion

  //region AUTHENTICATION : remplacée par Keycloak
  // La connexion, l'inscription et la connexion par fournisseur passent par Keycloak (`brain_dev_keycloak_login`) : plus
  // aucun appel de connexion n'est fait par ce dépôt. Ces méthodes restent pour les écrans de l'ancien plugin de
  // connexion, qui ne les atteignent plus ; elles ne font aucun appel réseau.
  Future loginRegisterProvider({required UserModel user}) async {
    logCat('loginRegisterProvider : remplacé par Keycloak, aucun appel');
    return null;
  }
  //endregion

  String getSigleName({required String nomComplet}) {
    String result = '';
    var nomCom = nomComplet.trim().split(' ');
    if (nomCom.isNotEmpty) {
      for (int i = 0; i < nomCom.length; i++) {
        if (nomCom[i].length >= 3) {
          result += nomCom[i].substring(0, 1).toUpperCase();
        }
      }
    } else if (nomComplet.length == 1) {
      result = nomComplet.substring(0, 2).toUpperCase();
    } else {
      result = 'CCG';
    }
    return result.toUpperCase();
  }

  Future getUserUI({ currentUser}) async {
    UserModel user = UserModel();
    if (currentUser != null) {
      if (currentUser.displayName != null && currentUser.displayName != '') {
        user.nomComplet = currentUser.displayName!;
      } else {
        user.nomComplet = currentUser.email!.split('@').first;
      }
      if (currentUser.photoURL != null) {
        user.photoPath = currentUser.photoURL!;
      }
      user.idAppFireBase = currentUser.uid;
      user.isEmailVerified = currentUser.emailVerified;
      //user.userCreated = currentUser.providerData.first.displayName!;
      user.idFirebaseToken = await currentUser.getIdToken();
      //await currentUser.getIdToken().then((value){ user.idFirebaseToken = value; });
    }
    return user;
  }

  /// Supprime mon compte LyricStream et mes données privées (`DELETE api/users/me`) ; le contenu publié reste au
  /// catalogue. [raison] n'est pas envoyée (le Middleware n'en garde pas).
  Future<MessageModel> deleteAccountOnTheCloud({required String raison}) => _deleteMyAccount('deleteAccountOnTheCloud');

  /// Même route : LyricStream n'a plus de distinction entre « supprimer le compte » et « supprimer toutes les données ».
  Future<MessageModel> deleteAllDataOnTheCloud({required String raison}) => _deleteMyAccount('deleteAllDataOnTheCloud');

  Future<MessageModel> _deleteMyAccount(String fName) async {
    MessageModel message = MessageModel();
    try {
      var response = await apiClient.deleteData(apiUrl: ApiConstantDev.urlMiddlewareMe, fName: fName);
      message.statusCode = response.statusCode;
      if (response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.noContent) {
        message.message = 'msg_operation_succes'.tr;
        message.isSuccess = true;
      } else if (response.statusCode == HttpStatus.unauthorized) {
        message.message = '${gtr('msg_access_key_has_expired')}';
        message.isRequiredToReLogin = true;
        message.isSuccess = false;
      } else {
        message.message = '${gtr('msg_TraitementImpossible')}';
        message.isSuccess = false;
      }
    } on SocketException catch (ex, trace) {
      setConnectivity();
      logError(ex, trace: trace);
      message.message = '${gtr('msg_No_Internet_connection')}';
      message.isSuccess = false;
    } catch (ex, trace) {
      logError(ex, trace: trace);
      message.message = '${gtr('msg_TraitementImpossible')}';
      message.isSuccess = false;
    }
    return message;
  }

//region [ checkIfUserIsFollowing ]
  Future checkIfUserIsFollowing({required String userId, required String followerId}) async {
    // try {
    //   String apiUrl = ApiConstant.urlApiCheckIfUserIsFollowing;
    //   var data = FollowerViewModel(userName: userId, followerId: followerId).toJson();
    //   var response = await apiClient.postData( apiUrl: apiUrl, data: data, fName: 'checkIfUserIsFollowing');
    //   if (response.statusCode==HttpStatus.ok) {
    //     var data = json.decode(response.body);
    //     return TypeSafeConversion.nullSafeBool( data['isFollowing'] );
    //   }
    // } on SocketException {
    //   setConnectivity();
    // } catch (ex, trace) {
    //   logError(ex, trace: trace, position: 'checkIfUserIsFollowing');
    // }
    return false;
  }

  /// Mon profil (`GET api/users/me`) ou celui d'un membre par son pseudo (`GET api/users/@pseudo`) si [isPublic].
  Future getProfileInfo({required String userId, required bool isPublic }) async {
    try {
      String apiUrl = isPublic
          ? '${ApiConstantDev.urlMiddleware}api/users/@${Uri.encodeComponent(userId)}'
          : '${ApiConstantDev.urlMiddleware}api/users/me';
      var response = await apiClient.getData( apiUrl, fName: (isPublic)?'GetProfilPublicInfo':'getUserConnectedProfileInfo');
      if (response.statusCode==HttpStatus.ok) {
        return userFromProfile(json.decode(response.body));
      }
    } on SocketException {
      setConnectivity();
    } catch (ex, trace) {
      logError(ex, trace: trace, position: (isPublic)?'GetProfilPublicInfo':'getUserConnectedProfileInfo');
    }
    return UserModel();
  }
//endregion
}
