class NotificationModel {
  int totalSize = 0;
  int limit = 0;
  int offset = 0;
  List<Notifications>? notifications;

  NotificationModel(
      {this.totalSize = 0,
      this.limit = 0,
      this.offset = 0,
      this.notifications});

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
      data['notifications'] = notifications?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  int id = 0;
  String title = '';
  String description = '';
  String image = '';
  int status = 0;
  String createdAt = '';
  String receiver = '';

  Notifications(
      {this.id = 0,
      this.title = '',
      this.description = '',
      this.image = '',
      this.status = 0,
      this.createdAt = '',
      this.receiver = ''});

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
