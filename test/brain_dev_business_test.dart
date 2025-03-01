import 'package:flutter_test/flutter_test.dart';
import 'package:brain_dev_business/brain_dev_business.dart';
import 'package:brain_dev_business/brain_dev_business_platform_interface.dart';
import 'package:brain_dev_business/brain_dev_business_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBrainDevBusinessPlatform
    with MockPlatformInterfaceMixin
    implements BrainDevBusinessPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final BrainDevBusinessPlatform initialPlatform = BrainDevBusinessPlatform.instance;

  test('$MethodChannelBrainDevBusiness is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBrainDevBusiness>());
  });

  test('getPlatformVersion', () async {
    BrainDevBusiness brainDevBusinessPlugin = BrainDevBusiness();
    MockBrainDevBusinessPlatform fakePlatform = MockBrainDevBusinessPlatform();
    BrainDevBusinessPlatform.instance = fakePlatform;

    expect(await brainDevBusinessPlugin.getPlatformVersion(), '42');
  });
}
