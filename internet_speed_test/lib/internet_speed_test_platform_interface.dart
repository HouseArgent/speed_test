import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'internet_speed_test_method_channel.dart';

abstract class InternetSpeedTestPlatform extends PlatformInterface {
  /// Constructs a InternetSpeedTestPlatform.
  InternetSpeedTestPlatform() : super(token: _token);

  static final Object _token = Object();

  static InternetSpeedTestPlatform _instance = MethodChannelInternetSpeedTest();

  /// The default instance of [InternetSpeedTestPlatform] to use.
  ///
  /// Defaults to [MethodChannelInternetSpeedTest].
  static InternetSpeedTestPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [InternetSpeedTestPlatform] when
  /// they register themselves.
  static set instance(InternetSpeedTestPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
