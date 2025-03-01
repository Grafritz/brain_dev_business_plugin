import 'package:brain_dev_business/models/notification/payload_model.dart';
import 'package:brain_dev_business/models/notification/response/channel_model.dart';
import 'package:brain_dev_business/models/notification/response/message_notification_model.dart';

abstract class SenderNotificationLocalService
{
  Future<void> showNotification( { required /*RemoteMessage*/ message });
  Future<void> showBigTextNotification({ required MessageNotificationModel mNotif });
  Future<void> showBigPictureNotificationHiddenLargeIcon({ required MessageNotificationModel mNotif });
  Future<void> showTextNotification({ required MessageNotificationModel mNotif });
  Future<void> showNotificationDemo();
  //Future<String> downloadAndSaveFile({ required String url, required String fileName});
  Future myBackgroundMessageHandler(/*RemoteMessage*/ message);

  Future<void> cancelNotification({required int id });
  Future<void> cancelAllNotification();
  Future<void> activateNotification({required String time, required PayLoadModel payLoad, ChannelModel? channel });
  Future<void> repeatNotification();
}