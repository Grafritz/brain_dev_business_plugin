import 'dart:convert';
import 'package:brain_dev_business/models/notification/response/channel_model.dart';
import 'package:brain_dev_tools/config/api/api_constant.dart';
import 'package:brain_dev_tools/tools/validation/type_safe_conversion.dart';
import 'package:get/get.dart';

class NotificationModel {
  int totalSize=0;
  int limit=0;
  int offset=0;
  List<Notifications>? notifications;

  NotificationModel(
      {this.totalSize=0, this.limit=0, this.offset=0, this.notifications});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications?.add(Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (notifications != null) {
      data['notifications'] =
          notifications?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  int id=0;
  String title='';
  String description='';
  String image='';
  int status=0;
  String createdAt='';
  String receiver='';

  Notifications(
      {this.id=0,
        this.title='',
        this.description='',
        this.image='',
        this.status=0,
        this.createdAt='',
        this.receiver=''});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    receiver = json['receiver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['receiver'] = receiver;
    return data;
  }
}

class MessageNotification {
  int id=0;
  String title='';
  String body='';
  String image='';
  String? payload;
  ChannelModel channel = ChannelModel();

  int status=0;
  String createdAt='';
  String receiver='';

  MessageNotification(
      {this.id=0,
        this.title='',
        this.body='',
        this.image='',
        this.status=0,
        this.createdAt='',
        this.receiver=''});

  MessageNotification.fromJson(Map<String, dynamic> jsonData) {
    id = TypeSafeConversion.nullSafeInt(jsonData['id']);
    title = TypeSafeConversion.nullSafeString(jsonData['title']);
    body = TypeSafeConversion.nullSafeString(jsonData['body']);
    payload = TypeSafeConversion.nullSafeString(jsonData['payload']);

    status = TypeSafeConversion.nullSafeInt(jsonData['status']);
    createdAt = TypeSafeConversion.nullSafeString(jsonData['created_at']);
    receiver = TypeSafeConversion.nullSafeString(jsonData['receiver']);
    String img = TypeSafeConversion.nullSafeString(jsonData['image']);
    image = (img.isNotEmpty)
        ? img.startsWith('http')
            ? jsonData['image']
            : '${ApiConstantDev.urlWebServer}/storage/app/public/notification/${jsonData['image']}'
        : '';
    channel = ( (jsonData['channel']) == null )? ChannelModel(): ChannelModel.fromJson(  json.decode(jsonData['channel']) );
  }
  MessageNotification.parseNotification(/*RemoteNotification?*/ notification) {
    title = TypeSafeConversion.nullSafeString(notification?.title);
    body = TypeSafeConversion.nullSafeString(notification?.body);
    payload = TypeSafeConversion.nullSafeString(notification?.titleLocKey);
    String img='';
    if(GetPlatform.isAndroid) {
      img = TypeSafeConversion.nullSafeString( notification?.android?.imageUrl );
    }
    if(GetPlatform.isIOS) {
      img = TypeSafeConversion.nullSafeString( notification?.apple?.imageUrl );
    }
    if( img.isNotEmpty ){
      image = img.startsWith('http')
          ? img
          : '${ApiConstantDev.urlWebServer}/storage/app/public/notification/$img';
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['receiver'] = receiver;
    return data;
  }

}
