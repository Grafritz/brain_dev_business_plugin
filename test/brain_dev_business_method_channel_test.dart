import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:brain_dev_business/brain_dev_business_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelBrainDevBusiness platform = MethodChannelBrainDevBusiness();
  const MethodChannel channel = MethodChannel('brain_dev_business');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
