import 'package:brain_dev_business/controllers/business_controller.dart';
import 'package:brain_dev_business/repository/user_repository.dart';
import 'package:brain_dev_tools/config/api/api_client.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeDeviceInfo extends BaseDeviceInfo {
  _FakeDeviceInfo() : super(const <String, dynamic>{});
}

void main() {
  late BusinessController controller;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final api = ApiClient(appBaseUrl: 'http://localhost', sharedPreferences: prefs, deiceInfo: _FakeDeviceInfo(), uniqueId: 'test');
    controller = BusinessController(sharedPreferences: prefs, apiClient: api, userRepository: UserRepository(apiClient: api, sharedPreferences: prefs));
  });

  test('signOut déconnecte localement ET appelle le crochet une fois', () async {
    var calls = 0;
    controller.onSignedOut = () async => calls++;

    controller.signOut();
    await Future<void>.delayed(Duration.zero);

    expect(calls, 1);
    expect((await controller.getUserConnectedPref()).connecterYN, isFalse);
  });

  test('un crochet qui échoue n\'empêche jamais la déconnexion', () async {
    controller.onSignedOut = () async => throw Exception('Keycloak injoignable');

    expect(() => controller.signOut(), returnsNormally);
    await Future<void>.delayed(Duration.zero);

    expect((await controller.getUserConnectedPref()).connecterYN, isFalse);
  });

  test('sans crochet : comportement d\'origine', () {
    expect(() => controller.signOut(), returnsNormally);
  });
}
