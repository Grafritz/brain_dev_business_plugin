import 'dart:convert';
import 'package:brain_dev_tools/tools/validation/type_safe_conversion.dart';

import 'day_verses_model.dart';

class PayLoadModel {
  PayLoadModel({
    this.notificationId = 0,
    this.codePage = '',
    this.pageUrl = '',
    this.titre = '',
    this.description = '',
    this.imageBg = '',
  });

  int notificationId;
  String codePage;
  String pageUrl;
  String titre;
  String description;
  String imageBg;
  DayVersesModel? dayVerses;

//region [ JSON ]
  String get jsonEncodeString => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'codePage': codePage,
        'notificationId': notificationId,
        'pageUrl': pageUrl,
        'titre': titre,
        'description': description,
        'imageBg': imageBg,
        'dayVerses': (dayVerses == null) ? null : dayVerses?.convertToJson()
      };

//endregion

  factory PayLoadModel.fromJson(Map<String, dynamic> map) {
    PayLoadModel obj = PayLoadModel();
    obj.codePage = TypeSafeConversion.nullSafeString(map['codePage']);
    obj.notificationId = TypeSafeConversion.nullSafeInt(map['notificationId']);
    obj.pageUrl = TypeSafeConversion.nullSafeString(map['pageUrl']);
    obj.titre = TypeSafeConversion.nullSafeString(map['titre']);
    obj.description = TypeSafeConversion.nullSafeString(map['description']);
    obj.imageBg = TypeSafeConversion.nullSafeString(map['imageBg']);
    return obj;
  }

  PayLoadModel fromJson(String str) => PayLoadModel.fromJson(json.decode(str));
}
