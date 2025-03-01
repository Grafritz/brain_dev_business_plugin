import 'dart:convert';
import 'package:brain_dev_business/models/notification/payload_model.dart';
import 'package:brain_dev_business/models/notification/response/channel_model.dart';
import 'package:brain_dev_tools/config/api/api_constant.dart';
import 'package:brain_dev_tools/tools/check_platform.dart';
import 'package:brain_dev_tools/tools/validation/type_safe_conversion.dart';

class MessageNotificationModel {
  int id = 0;
  String title = '';
  String body = '';
  String userId = '';
  String imagePath = '';
  PayLoadModel payload = PayLoadModel();
  ChannelModel channel = ChannelModel();

/*
{
  "title": "TEST 1-title",
  "body": "TEST 1-Body",
  "userId": "lasaintebible509@gmail.com",
  "imagePath": "",
  "payload": {
    "notificationId": 0,
    "codePage": "",
    "pageUrl": "/books",
    "titre": "TEST 1-titre",
    "description": "TEST 1-Description",
    "imageBg": "",
    "dayVerses": {
      "bookOsis": "Gen",
      "chapter": 13,
      "verse": 8
    }
  },
  "channelNotification": {
    "channelId": "test1",
    "channelName": "test1",
    "channelDescription": "test1"
  }
}
*/
  MessageNotificationModel({
    this.id = 0,
    this.title = '',
    this.body = '',
    this.userId = '',
    this.imagePath = '',
  });

  MessageNotificationModel.fromJsonData(Map<String, dynamic> jsonData) {
    id = TypeSafeConversion.nullSafeInt(jsonData['id']);
    title = TypeSafeConversion.nullSafeString(jsonData['title']);
    body = TypeSafeConversion.nullSafeString(jsonData['body']);
    userId = TypeSafeConversion.nullSafeString(jsonData['userId']);
    String img = TypeSafeConversion.nullSafeString(jsonData['imagePath']);
    imagePath = (img.isNotEmpty)
        ? img.startsWith('http')
            ? jsonData['imagePath']
            : '${ApiConstantDev.urlServerImageNotification}/$img'
        : '';
    payload = ((jsonData['payload']) == null)
        ? PayLoadModel()
        : PayLoadModel.fromJson(json.decode(jsonData['payload']));
    channel = ((jsonData['channel']) == null)
        ? ChannelModel()
        : ChannelModel.fromJson(json.decode(jsonData['channel']));
  }

//region [ JSON ]
  MessageNotificationModel.parseNotification(dynamic notification) {
    title = TypeSafeConversion.nullSafeString(notification?.title);
    body = TypeSafeConversion.nullSafeString(notification?.body);
    String img = '';
    if (checkPlatform.isAndroid) {
      img = TypeSafeConversion.nullSafeString(notification?.android?.imageUrl);
    }
    if (checkPlatform.isIOS) {
      img = TypeSafeConversion.nullSafeString(notification?.apple?.imageUrl);
    }
    if (img.isNotEmpty) {
      imagePath = img.startsWith('http')
          ? img
          : '${ApiConstantDev.urlServerImageNotification}/$img';
    }
  }

//endregion

//region [ JSON ]
  String get jsonEncodeString => json.encode(convertToJson());

  Map<String, dynamic> convertToJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['userId'] = userId;
    data['imagePath'] = imagePath;
    //data['payload'] = (payload==null)?null:payload.toJson();
    data['payload'] = payload.toJson();
    data['channel'] = channel.toJson();
    return data;
  }
//endregion
}
