import 'dart:convert';
import 'dart:io';

import 'package:brain_dev_business/models/users_model.dart';
import 'package:brain_dev_business/entities/dao/properties/users_property.dart';
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
import 'package:get/get_connect/http/src/status/http_status.dart';
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

  Future tryTokenAutoAuthenticate() async {
    try {
      String apiUrl = ApiConstantDev.urlApiAutoAuthenticate;
      String packageName = TypeSafeConversion.nullSafeString( apiClient.packageInfo?.packageName);
      logCat('tryTokenAutoAuthenticate() | packageName:$packageName ');
      //region attributs
      Map<String, String> param = <String, String>{};
      param[UsersProperty.packageName.columnName] = packageName;//Constant.packageChantChoraleEtGroupe;
      //endregion
      var response = await apiClient.postData(apiUrl: apiUrl, data: param, fName: 'tryTokenAutoAuthenticate');
      if (response.statusCode == HttpStatus.ok) {
        var data = jsonDecode(response.body);
        var bearerToken = data['jwtToken'];
        apiClient.bearerToken = bearerToken;
        apiClient.setApiToken(bearerToken);
        logCat('tryTokenAutoAuthenticate() | packageName:$packageName | response.body: $data');
        return data['jwtToken'];
      } else {
        tentative++;
        if (tentative <= 3) {
          await tryTokenAutoAuthenticate();
        }
      }
    } catch (ex, trace) {
      logError(ex, trace: trace, position: 'refreshDeviceToken');
    }
    return null;
  }
  //endregion

//region [ UPDATE ]
  Future updateProfile({ required UserModel user }) async {
    try {
      String apiUrl = ApiConstantDev.urlApiUpdateProfile;
      var data = user.toJson();
      var jsonData =  jsonEncode(data);
      logCat(jsonData);
      var response = await apiClient.putData(apiUrl: apiUrl, data: data, fName: 'updateProfile');
      if (response.statusCode==HttpStatus.badRequest) {
        final data = jsonDecode(response.body);
        ErrorResponseModel errorResponse = ErrorResponseModel.fromJson(data);
        String msg = ErrorResponseModel.messages(errorResponse: errorResponse);
        DialogView.showAlertDialog( msg: msg);
      }
      if (response.statusCode==HttpStatus.ok) {
        final parsed = jsonDecode(response.body);
        UserModel r = UserModel.fromJson(parsed);
        return r;
      }
    } on SocketException {
      setConnectivity();
    } catch (ex, trace) {
      logError(ex, trace:trace,position: 'updateProfile');
    }
    return null;
  }
  Future updatePhotoProfile({ required UserModel user }) async {
    try {
      String apiUrl = ApiConstantDev.urlApiUpdateProfile;
      var data = user.toJson();
      var jsonData =  jsonEncode(data);
      logCat(jsonData);
      var response = await apiClient.putData(apiUrl: apiUrl, data: data, fName: 'updateProfile');
      if (response.statusCode==HttpStatus.badRequest) {
        final data = jsonDecode(response.body);
        ErrorResponseModel errorResponse = ErrorResponseModel.fromJson(data);
        String msg = ErrorResponseModel.messages(errorResponse: errorResponse);
        DialogView.showAlertDialog( msg: msg);
      }
      if (response.statusCode==HttpStatus.ok) {
        final parsed = jsonDecode(response.body);
        UserModel r = UserModel.fromJson(parsed);
        return r;
      }
    } on SocketException {
      setConnectivity();
    } catch (ex, trace) {
      logError(ex, trace:trace, position: 'updatePhotoProfile');
    }
    return null;
  }
  //endregion

  //region AUTHENTICATION / Login /  Register
  Future loginRegisterProvider({required UserModel user}) async {
    return await loginProviderModel(user: user, urlApi: ApiConstantDev.urlApiLoginRegisterProvider);
  }

  Future<UserModel?> loginProviderModel({required UserModel user, required String urlApi}) async {
    try {
      //region attributs
      Map<String, String> param = <String, String>{};
      param[UsersProperty.photoPath.columnName] = user.photoPath;
      param[UsersProperty.userName.columnName] = user.userName;
      param[UsersProperty.motDePasse.columnName] = user.motDePasse;
      param[UsersProperty.nomComplet.columnName] = user.nomComplet;
      param[UsersProperty.groupeUserId.columnName] = user.groupeUserId.toString();
      param[UsersProperty.idAppFireBase.columnName] =  user.idAppFireBase.toString();
      param[UsersProperty.idFirebaseToken.columnName] = user.idFirebaseToken.toString();
      param[UsersProperty.userCreated.columnName] = user.userCreated;
      param[UsersProperty.isEmailVerified.columnName] = user.isEmailVerified.toString();
      param[UsersProperty.connectFrom.columnName] = dataFrom;
      //endregion

      var response = await apiClient.postData(apiUrl: urlApi, data: param, fName: 'loginProviderModel');
      if (response.statusCode == HttpStatus.ok) {
        var data = json.decode(response.body);
        UserModel user = UserModel.fromJson(data);
        user.connecterYN = true;
        return user;
      } else if (response.statusCode == HttpStatus.badRequest) {
        logCat('msg_TraitementImpossible');
      } else if (response.statusCode == HttpStatus.notFound) {
        logCat('msg_no_record');
      } else {
        logCat('msg_TraitementImpossible');
      }
    } on SocketException catch (ex, trace) {
      setConnectivity();
      logError(ex, trace: trace, position: 'login');
    } on Exception catch (ex, trace) {
      logError(ex, trace: trace, position: 'login');
    } catch (ex, trace) {
      logError(ex, trace: trace, position: 'login');
    }
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

  Future<MessageModel> deleteAccountOnTheCloud({required String raison}) async {
    MessageModel message = MessageModel();
    try {
      var user = userConnected;
      String apiUrl = ApiConstantDev.urlApiUserByUserName(userName: user.userName);
      //region [ Attributs ]
      Map<String, String> param = <String, String>{};
      param[UsersProperty.raison.columnName] = raison;
      param[UsersProperty.userName.columnName] = user.userName;
      //var jsonEncodeStr = jsonEncode(param);
      //endregion

      var response = await apiClient.deleteData(
          apiUrl: apiUrl, data: param, fName: 'deleteAccountOnTheCloud');

      message.statusCode = response.statusCode;
      if (response.statusCode == HttpStatus.ok) {
        try {
          message.message = 'msg_operation_succes'.tr;
          message.isSuccess = true;
          return message;
        } catch (ex, trace) {
          logError(ex, trace: trace);
          message.message = '${tr('msg_TraitementImpossible')}';
          message.isSuccess = false;
          return message;
        }
      } else if (response.statusCode == HttpStatus.unauthorized) {
        message.message = '${gtr('msg_access_key_has_expired')}';
        //UserDaoPref().logOut();
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
    } on Exception catch (ex, trace) {
      logError(ex, trace: trace);
      message.message = '${gtr('msg_TraitementImpossible')}';
      message.isSuccess = false;
    } catch (ex, trace) {
      logError(ex, trace: trace);
      message.message = '${gtr('msg_TraitementImpossible')}';
      message.isSuccess = false;
    }
    return message;
  }

  Future<MessageModel> deleteAllDataOnTheCloud({required String raison}) async {
    MessageModel message = MessageModel();
    try {
      var user = await getUserConnected();
      String apiUrl = ApiConstantDev.urlApiDeleteAllDataUser;
      //region [ Attributs ]
      Map<String, String> param = <String, String>{};
      param[UsersProperty.raison.columnName] = raison;
      param[UsersProperty.userName.columnName] = user.userName;
      //var jsonEncodeStr = jsonEncode(param);
      //endregion
      var response = await apiClient.postData(
          apiUrl: apiUrl, data: param, fName: 'deleteAllDataOnTheCloud');

      message.statusCode = response.statusCode;
      if (response.statusCode == HttpStatus.ok) {
        try {
          message.message = 'msg_operation_succes'.tr;
          message.isSuccess = true;
          return message;
        } catch (ex, trace) {
          logError(ex, trace: trace);
          message.message = '${tr('msg_TraitementImpossible')}';
          message.isSuccess = false;
          return message;
        }
      } else if (response.statusCode == HttpStatus.unauthorized) {
        message.message = '${gtr('msg_access_key_has_expired')}';
        //UserDaoPref().logOut();
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
    } on Exception catch (ex, trace) {
      logError(ex, trace: trace);
      message.message = '${gtr('msg_TraitementImpossible')}';
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

  Future getProfileInfo({required String userId, required bool isPublic }) async {
    try {
      String apiUrl = ApiConstantDev.urlApiGetProfilUserData(userName: userId);
      if( isPublic ){
        apiUrl = ApiConstantDev.urlApiGetProfilPublicUserData(userName: userId);
      }
      var response = await apiClient.getData( apiUrl, fName: (isPublic)?'GetProfilPublicInfo':'getUserConnectedProfileInfo');
      if (response.statusCode==HttpStatus.ok) {
        var data = json.decode(response.body);
        return UserModel.fromJson(data);
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