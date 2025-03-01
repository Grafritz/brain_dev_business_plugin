import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'brain_dev_business_platform_interface.dart';

/// An implementation of [BrainDevBusinessPlatform] that uses method channels.
class MethodChannelBrainDevBusiness extends BrainDevBusinessPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('brain_dev_business');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
