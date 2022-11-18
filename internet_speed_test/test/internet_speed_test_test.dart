import 'package:flutter_test/flutter_test.dart';
import 'package:internet_speed_test/internet_speed_test.dart';
import 'package:internet_speed_test/internet_speed_test_platform_interface.dart';
import 'package:internet_speed_test/internet_speed_test_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockInternetSpeedTestPlatform
    with MockPlatformInterfaceMixin
    implements InternetSpeedTestPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final InternetSpeedTestPlatform initialPlatform = InternetSpeedTestPlatform.instance;

  test('$MethodChannelInternetSpeedTest is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelInternetSpeedTest>());
  });

  test('getPlatformVersion', () async {
    InternetSpeedTest internetSpeedTestPlugin = InternetSpeedTest();
    MockInternetSpeedTestPlatform fakePlatform = MockInternetSpeedTestPlatform();
    InternetSpeedTestPlatform.instance = fakePlatform;

    expect(await internetSpeedTestPlugin.getPlatformVersion(), '42');
  });
}
