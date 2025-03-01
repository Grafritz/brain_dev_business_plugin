import 'dart:convert';

import 'package:brain_dev_tools/tools/constant.dart';
import 'package:brain_dev_tools/tools/validation/type_safe_conversion.dart';

class ChannelModel2 {
  String id = Constant.channel_notification_song_share;
  String name = Constant.channel_notification_song_share;
  String description = Constant.channel_notification_song_share;

  ChannelModel2(
      {this.id = Constant.channel_notification_song_share,
      this.name = Constant.channel_notification_song_share,
      this.description = Constant.channel_notification_song_share});

  ChannelModel2.fromJson(Map<String, dynamic> json) {
    id = TypeSafeConversion.nullSafeString(json['id']);
    name = TypeSafeConversion.nullSafeString(json['name']);
    description = TypeSafeConversion.nullSafeString(json['description']);
  }

//region [ JSON ]
  String get jsonEncodeString => json.encode(toJson());

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
//endregion
}

class ChannelModel {
  String id = Constant.channel_notification_song_share;
  String name = Constant.channel_notification_song_share;
  String description = Constant.channel_notification_song_share;

  ChannelModel({
        this.id = Constant.channel_notification_song_share,
        this.name = Constant.channel_notification_song_share,
        this.description = Constant.channel_notification_song_share});

  ChannelModel.fromJson(Map<String, dynamic> json) {
    id = TypeSafeConversion.nullSafeString(json['channelId']);
    name = TypeSafeConversion.nullSafeString(json['channelName']);
    description = TypeSafeConversion.nullSafeString(json['channelDescription']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['channelId'] = id;
    data['channelName'] = name;
    data['channelDescription'] = description;
    return data;
  }

}
