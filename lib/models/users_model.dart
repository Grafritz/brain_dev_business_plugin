import 'dart:convert';
import 'dart:io';
import 'package:brain_dev_business/entities/dao/properties/users_property.dart';
import 'package:brain_dev_tools/tools/constant.dart';
import 'package:brain_dev_tools/tools/validation/type_safe_conversion.dart';

class UserModel {
  int? id; // PK
  String projectId = '';
  String authKey = '';
  String token = '';
  String dateModifDisplay = '';
  String userName = '';
  String goutDuChefId = '';
  String photoPath = '';
  String photoPathUrl = '';
  bool isPhotoPathLocalDelete = false;
  String photoPathLocal = '';
  String password = '';
  String nomComplet = '';
  String groupeRole = '';
  bool activeYN = false;
  bool isValidateAccount = false;
  String email='';
  String localisation='';
  String biographie='';
  String? lastLogin ;
  bool connecterYN = false;
  String? lastIp = '';
  String? idAppFireBase = '';
  String? idFirebaseToken = '';
  String? askPassword = '';
  String role='';
  String roleStr='';

  bool isEmailVerified=false;
  bool isForcedOut = false;
  bool isDelete = false;
  bool isAppProvider = false;
  String? instragramUrl = '';
  String? facebookUrl = '';
  String? pinterestUrl = '';
  String? youtubeUrl = '';
  String? dateCreated = '';
  String? dateModif = '';
  List<String> permissions =[];

  //int? id; // PK
  String motDePasse = '';
  int groupeUserId = Constant.chant_Chorale_et_Groupe_APP_Abonne_05;
  String jWTToken = '';
  //bool isAdminPrivilege = false;

  String lastLoginDisplay = '';
  String dateCreatedDisplay = '';

  String userCreated = '';
  int recipeCount = 0;
  int followingCount = 0;
  int followerCount =0;
  bool isFollowing =false;

  bool get isAdminPrivilege => checkIsAdminPrivilege();

  bool get haveAdminPrivilege => isAdminPrivilege;

  bool get havePrivilege => checkIsHasPrivilege();

  String get sigleName => getSigleName();

  //region NOT MAPPED
  File? photoFile;
  String get photoBase64 {
    if( photoFile!=null){
      return base64Encode(photoFile!.readAsBytesSync());
    }
    return '';
  }
  //endregion

  UserModel({
    this.id,
    this.goutDuChefId = '',
    this.photoPath = '',
    this.userName = '',
    this.authKey = '',
    this.groupeUserId = Constant.chant_Chorale_et_Groupe_APP_Abonne_05,
    this.motDePasse = '',
    this.nomComplet = '',
    this.activeYN = false,
    this.idAppFireBase,
    this.idFirebaseToken,
    this.jWTToken = '',
    this.lastLogin = '',
    this.connecterYN = false,
    //this.isAdminPrivilege = false,
    this.dateCreated = '',
  });

  //region [ ConvertToJson]
  static toJsonList(List<UserModel> data) =>
      data.map((e) => e.toJson()).toList();

  Map<String, dynamic> toJson() => {
        UsersProperty.projectId.columnName: projectId,
        UsersProperty.goutDuChefId.columnName: goutDuChefId,
        UsersProperty.authKey.columnName: authKey,
        UsersProperty.photoPath.columnName: photoPath,
    UsersProperty.photoPathUrl.columnName: photoPathUrl,
    UsersProperty.isPhotoPathLocalDelete.columnName: isPhotoPathLocalDelete,
    UsersProperty.photoPathLocal.columnName: photoPathLocal,
    UsersProperty.photoBase64.columnName : photoBase64,
    UsersProperty.isValidateAccount.columnName: isValidateAccount,
    UsersProperty.email.columnName: email,
    UsersProperty.localisation.columnName: localisation,
    UsersProperty.biographie.columnName: biographie,
        UsersProperty.userName.columnName: userName,
        UsersProperty.motDePasse.columnName: motDePasse,
        UsersProperty.nomComplet.columnName: nomComplet,
    UsersProperty.groupeUserId.columnName: groupeUserId,
    UsersProperty.role.columnName: role,
    UsersProperty.roleStr.columnName: roleStr,
        UsersProperty.groupeRole.columnName: groupeRole,
        UsersProperty.activeYN.columnName: activeYN,
        UsersProperty.idAppFireBase.columnName: idAppFireBase,
        UsersProperty.idFirebaseToken.columnName: idFirebaseToken,
        UsersProperty.jWTToken.columnName: jWTToken,
        UsersProperty.lastLogin.columnName: lastLogin,
        UsersProperty.connecterYN.columnName: connecterYN,
        UsersProperty.isAdminPrivilege.columnName: getAdminPrivilege(userName: userName),
        UsersProperty.dateCreated.columnName: dateCreated,
        UsersProperty.userCreated.columnName: userCreated,
        UsersProperty.dateCreatedDisplay.columnName: dateCreatedDisplay,
        UsersProperty.lastLoginDisplay.columnName: lastLoginDisplay,
        UsersProperty.askPassword.columnName: askPassword,
        UsersProperty.isEmailVerified.columnName: isEmailVerified,
        UsersProperty.recipeCount.columnName:  recipeCount,
        UsersProperty.followingCount.columnName:  followingCount,
        UsersProperty.followerCount.columnName:  followerCount,
    UsersProperty.isFollowing.columnName:  isFollowing,
    UsersProperty.instragramUrl.columnName:  instragramUrl,
    UsersProperty.facebookUrl.columnName:  facebookUrl,
    UsersProperty.pinterestUrl.columnName:  pinterestUrl,
    UsersProperty.youtubeUrl.columnName:  youtubeUrl,
    UsersProperty.permissions.columnName: permissions.map((e) => e).toList(),
      };
  //endregion

  //region [ ConvertFromJson ]
  static List<UserModel> fromJsonList(var data) {
    return data
        .map<UserModel>((json) => UserModel.fromJson(json))
        .toList();
  }
  factory UserModel.fromJson(Map<String, dynamic> map) {
    var user = UserModel(
      //projectId: TypeSafeConversion.nullSafeInt(map[UsersProperty.id.columnName]),
      goutDuChefId: TypeSafeConversion.nullSafeString( map[UsersProperty.goutDuChefId.columnName]),
      photoPath: TypeSafeConversion.nullSafeString( map[UsersProperty.photoPath.columnName]),
      userName: TypeSafeConversion.nullSafeString( map[UsersProperty.userName.columnName]),
      motDePasse: TypeSafeConversion.nullSafeString( map[UsersProperty.motDePasse.columnName]),
      nomComplet: TypeSafeConversion.nullSafeString( map[UsersProperty.nomComplet.columnName]),
      activeYN: TypeSafeConversion.nullSafeBool( map[UsersProperty.activeYN.columnName]),
      idAppFireBase: TypeSafeConversion.nullSafeString( map[UsersProperty.idAppFireBase.columnName]),
      idFirebaseToken: TypeSafeConversion.nullSafeString( map[UsersProperty.idFirebaseToken.columnName]),
      jWTToken: TypeSafeConversion.nullSafeString(map[UsersProperty.jWTToken.name]),
      lastLogin: TypeSafeConversion.nullSafeString( map[UsersProperty.lastLogin.columnName]),
      connecterYN: TypeSafeConversion.nullSafeBool( map[UsersProperty.connecterYN.columnName]),
      dateCreated: TypeSafeConversion.nullSafeString( map[UsersProperty.dateCreated.columnName]),
      //isAdminPrivilege: UserModel().getAdminPrivilege( userName: TypeSafeConversion.nullSafeString( map[UsersProperty.userName.columnName])),
    );
    user.isPhotoPathLocalDelete = TypeSafeConversion.nullSafeBool( map[UsersProperty.isPhotoPathLocalDelete.columnName]);
    user.photoPathLocal = TypeSafeConversion.nullSafeString( map[UsersProperty.photoPathLocal.columnName]);
    user.photoPathUrl = TypeSafeConversion.nullSafeString( map[UsersProperty.photoPathUrl.columnName]);
    user.isValidateAccount = TypeSafeConversion.nullSafeBool( map[UsersProperty.isValidateAccount.columnName]);
    user.email = TypeSafeConversion.nullSafeString( map[UsersProperty.email.columnName]);
    user.localisation = TypeSafeConversion.nullSafeString( map[UsersProperty.localisation.columnName]);
    user.biographie = TypeSafeConversion.nullSafeString( map[UsersProperty.biographie.columnName]);
    user.role = TypeSafeConversion.nullSafeString(map[UsersProperty.role.columnName]);
    user.roleStr = TypeSafeConversion.nullSafeString(map[UsersProperty.roleStr.columnName]);
    user.groupeRole = TypeSafeConversion.nullSafeString( map[UsersProperty.groupeRole.columnName]);
    user.dateCreatedDisplay = TypeSafeConversion.nullSafeString(map[UsersProperty.dateCreatedDisplay.columnName]);
    user.dateModifDisplay = TypeSafeConversion.nullSafeString(map[UsersProperty.dateModifDisplay.columnName]);
    user.lastLoginDisplay = TypeSafeConversion.nullSafeString(map[UsersProperty.lastLoginDisplay.columnName]);
    user.askPassword = TypeSafeConversion.nullSafeString( map[UsersProperty.askPassword.columnName]);
    user.isEmailVerified = TypeSafeConversion.nullSafeBool( map[UsersProperty.isEmailVerified.columnName]);

    user.isForcedOut = TypeSafeConversion.nullSafeBool( map[UsersProperty.isForcedOut.columnName]);
    user.isDelete = TypeSafeConversion.nullSafeBool( map[UsersProperty.isDelete.columnName]);
    user.isAppProvider = TypeSafeConversion.nullSafeBool( map[UsersProperty.isAppProvider.columnName]);

    user.instragramUrl = TypeSafeConversion.nullSafeString( map[UsersProperty.instragramUrl.columnName]);
    user.facebookUrl = TypeSafeConversion.nullSafeString( map[UsersProperty.facebookUrl.columnName]);
    user.pinterestUrl = TypeSafeConversion.nullSafeString( map[UsersProperty.pinterestUrl.columnName]);
    user.youtubeUrl = TypeSafeConversion.nullSafeString( map[UsersProperty.youtubeUrl.columnName]);
    user.dateCreated = TypeSafeConversion.nullSafeString( map[UsersProperty.dateCreated.columnName]);
    user.dateModif = TypeSafeConversion.nullSafeString( map[UsersProperty.dateModif.columnName]);

    user.recipeCount = TypeSafeConversion.nullSafeInt( map[UsersProperty.recipeCount.columnName]);
    user.followingCount = TypeSafeConversion.nullSafeInt( map[UsersProperty.followingCount.columnName]);
    user.followerCount = TypeSafeConversion.nullSafeInt( map[UsersProperty.followerCount.columnName]);
    user.isFollowing = TypeSafeConversion.nullSafeBool( map[UsersProperty.isFollowing.columnName]);

    user.permissions = (map[UsersProperty.permissions.columnName] as List<dynamic>?)?.map(( e ) => e as String).toList() ?? [];
    return user;
  }
  //endregion

  List<String> userPrivilegeList = [
    duverseau_jeanfritz_gmail_com,
    peterfritz2007_gmail_com,
    chantchoraleetgroupe_gmail_com,
    jeudyfred_saskia_gmail_com,
    info_rezo509_com,
    emmanuelduvers_gmail_com,
    duverseaujeandavid1_gmail_com
  ];
  List<String> userAdminPrivilegeList = [
    duverseau_jeanfritz_gmail_com,
    chantchoraleetgroupe_gmail_com,
    info_rezo509_com,
  ];

  bool getAdminPrivilege({ String? userName }) {
    bool result=false;
    if(userName==null) {
      return false;
    }

    for (var obj in userAdminPrivilegeList) {
      if (userName == obj) {
        result = true;
      }
    }
    return result;
  }

  bool checkIsHasPrivilege() {
    if (userName.isEmpty) {
      return false;
    }
    for (var obj in userPrivilegeList) {
      if (userName == obj) {
        return true;
      }
    }
    return false;
  }

  bool checkIsAdminPrivilege() {
    if (userName.isEmpty) {
      return false;
    }
    for (var user in userAdminPrivilegeList) {
      if (userName == user) {
        return true;
      }
    }
    return false;
  }

  String getSigleName() {
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
      result = 'Guest';
    }
    return result.toUpperCase();
  }

}