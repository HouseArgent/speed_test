import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_speed_test/internet_speed_test_method_channel.dart';

void main() {
  MethodChannelInternetSpeedTest platform = MethodChannelInternetSpeedTest();
  const MethodChannel channel = MethodChannel('internet_speed_test');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}