
import 'internet_speed_test_platform_interface.dart';

class InternetSpeedTest {
  Future<String?> getPlatformVersion() {
    return InternetSpeedTestPlatform.instance.getPlatformVersion();
  }
}
