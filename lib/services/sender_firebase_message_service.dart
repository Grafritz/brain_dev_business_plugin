import 'package:brain_dev_business/models/notification/response/message_notification_model.dart';

abstract class SenderFirebaseMessageService
{
  void iOSPermission();

  Future<String> getFcmToken();
  setFcmToken(String fcmToken);

  Future<String?> addDevice({required String fcmNewToken});
  Future updateToken();
  Future<String> getDeviceToken();
  Future<String?> refreshDeviceToken({required String fcmNewToken});

}