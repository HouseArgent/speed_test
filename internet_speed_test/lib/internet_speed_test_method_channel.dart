import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'core/speed_test_handler.dart';
import 'internet_speed_test_platform_interface.dart';

/// An implementation of [InternetSpeedTestPlatform] that uses method channels.
class MethodChannelInternetSpeedTest extends InternetSpeedTestPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('internet_speed_test');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}

class SpeedTest {
  late SpeedtestHandler speedtestHandler;
  var methodChannel = const MethodChannel("internet_speed_test");

  SpeedTest({required this.speedtestHandler}) {
    methodChannel.setMethodCallHandler((call) {
      var data = jsonDecode(call.arguments);
      print(data);
      switch (call.method) {
        case 'onDownloadUpdate':
          {
            speedtestHandler.onDownloadUpdate(data);
            break;
          }
        case 'onUploadUpdate':
          {
            speedtestHandler.onUploadUpdate(data);
            break;
          }
        case 'onPingJitterUpdate':
          {
            speedtestHandler.onUploadUpdate(data);
            break;
          }
        case 'onIPInfoUpdate':
          {
            speedtestHandler.onIPInfoUpdate(data);
            break;
          }
        case 'onTestIDReceived':
          {
            speedtestHandler.onTestIDReceived(data);
            break;
          }
        case 'onEnd':
          {
            speedtestHandler.onEnd();
            break;
          }
        case 'onCriticalFailure':
          {
            speedtestHandler.onCriticalFailure(data);
            break;
          }
      }
      return Future.value();
    });
  }

  start() async {
    try {
      var data = await methodChannel.invokeMethod('startSpeedTest');
      return data;
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }

  stop() async {
    try {
      var data = await methodChannel.invokeMethod('stopSpeedTest');
      return data;
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }
}