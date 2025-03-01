import 'dart:convert';

import 'package:brain_dev_tools/tools/validation/type_safe_conversion.dart';

class DayVersesModel {
  DayVersesModel({
    this.bookOsis = '',
    this.chapter = 0,
    this.verse = 0,
  });

  String bookOsis;
  int chapter;
  int verse;

//region [ JSON ]
  String get jsonEncodeString => json.encode(convertToJson());

  Map<String, dynamic> convertToJson() => {
        'bookOsis': bookOsis,
        'chapter': chapter,
        'verse': verse,
      };

//endregion

  factory DayVersesModel.fromJson(Map<String, dynamic> map) {
    DayVersesModel obj = DayVersesModel();
    obj.bookOsis = TypeSafeConversion.nullSafeString(map['bookOsis']);
    obj.chapter = TypeSafeConversion.nullSafeInt(map['chapter']);
    obj.verse = TypeSafeConversion.nullSafeInt(map['verse']);
    return obj;
  }

  DayVersesModel fromJson(String str) =>
      DayVersesModel.fromJson(json.decode(str));
}
