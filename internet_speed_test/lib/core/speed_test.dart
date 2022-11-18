
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'speed_test_handler.dart';


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