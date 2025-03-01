import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'brain_dev_business_method_channel.dart';

abstract class BrainDevBusinessPlatform extends PlatformInterface {
  /// Constructs a BrainDevBusinessPlatform.
  BrainDevBusinessPlatform() : super(token: _token);

  static final Object _token = Object();

  static BrainDevBusinessPlatform _instance = MethodChannelBrainDevBusiness();

  /// The default instance of [BrainDevBusinessPlatform] to use.
  ///
  /// Defaults to [MethodChannelBrainDevBusiness].
  static BrainDevBusinessPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BrainDevBusinessPlatform] when
  /// they register themselves.
  static set instance(BrainDevBusinessPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
