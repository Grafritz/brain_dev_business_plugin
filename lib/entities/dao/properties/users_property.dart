
import 'package:brain_dev_tools/dao/entities/properties/property.dart';

class UsersProperty {
  static final Property id = Property( columnName: "id");
  static final Property goutDuChefId = Property( columnName: "goutDuChefId");
  static final Property projectId = Property( columnName: "projectId");
  static final Property authKey = Property( columnName: "authKey");
  static final Property groupeRole = Property(columnName: "groupeRole");
  static final Property photoPath =Property( columnName: "photoPath");
  static final Property isPhotoPathLocalDelete =Property( columnName: "isPhotoPathLocalDelete");
  static final Property photoPathLocal =Property( columnName: "photoPathLocal");
  static final Property photoPathUrl =Property( columnName: "photoPathUrl");
  static final Property photoBase64 =Property( columnName: "photoBase64");
  static final Property userName =Property( columnName: "userName");
  static final Property motDePasse =Property( columnName: "password");
  static final Property nomComplet =Property( columnName: "nomComplet");
  static final Property groupeUserId =Property(columnName: "groupeUserId");
  static final Property activeYN =Property(columnName: "activeYN");
  static final Property idAppFireBase =Property( columnName: "idAppFireBase");
  static final Property idFirebaseToken =Property(columnName: "idFirebaseToken");
  static final Property jWTToken =Property( columnName: "JWTToken");
  static final Property lastLogin =Property( columnName: "lastLogin");
  static final Property connecterYN =Property(columnName: "connecterYN");
  static final Property dateCreated =Property(columnName: "dateCreated");
  static final Property idUserAPI =Property( columnName: "idUser");
  static final Property isAdminPrivilege =Property(columnName: "isAdminPrivilege");

  static final Property userCreated = Property( columnName: "userCreated");

  static final Property isEmailVerified =Property( columnName: "isEmailVerified");

  static final Property askPassword = Property( columnName: "askPassword");

  static final Property lastLoginDisplay = Property( columnName: "lastLoginDisplay");
  static final Property dateCreatedDisplay = Property( columnName: "dateCreatedDisplay");



  static final Property dateModifDisplay = Property( columnName: "dateModifDisplay");
  static final Property isForcedOut = Property( columnName: "isForcedOut");
  static final Property isDelete = Property( columnName: "isDelete");
  static final Property isValidateAccount = Property( columnName: "isValidateAccount");
  static final Property email = Property( columnName: "email");
  static final Property localisation = Property( columnName: "localisation");
  static final Property biographie = Property( columnName: "biographie");
  static final Property isAppProvider = Property( columnName: "isAppProvider");
  static final Property instragramUrl = Property( columnName: "instragramUrl");
  static final Property facebookUrl = Property( columnName: "facebookUrl");
  static final Property pinterestUrl = Property( columnName: "pinterestUrl");
  static final Property youtubeUrl = Property( columnName: "youtubeUrl");
  static final Property dateModif = Property( columnName: "dateModif");
  static final Property role = Property( columnName: "role");
  static final Property roleStr = Property( columnName: "roleStr");


  static final Property raison = Property(columnName: "raison");
  static final Property recipeCount = Property(columnName: "recipeCount");
  static final Property followingCount = Property(columnName: "followingCount");
  static final Property followerCount = Property(columnName: "followerCount");

  static final Property followerId = Property(columnName: "followerId");
  static final Property fcmOldToken = Property(columnName: "fcmOldToken");
  static final Property fcmNewToken = Property(columnName: "fcmNewToken");
  static final Property packageName = Property(columnName: "packageName");
  static final Property baseDeviceInfo = Property(columnName: "baseDeviceInfo");
  static final Property connectFrom = Property(columnName: "connectFrom");
  static final Property isFollowing = Property(columnName: "isFollowing");

  static final Property permissions = Property(columnName: "permissions");

}