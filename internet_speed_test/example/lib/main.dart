import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:internet_speed_test/core/speed_test_handler.dart';
import 'package:internet_speed_test/internet_speed_test.dart';
import 'package:internet_speed_test/internet_speed_test_method_channel.dart';

void main() {
  runApp(const SpeedTestApp());
}

class SpeedTestApp extends StatefulWidget {
  const SpeedTestApp({super.key});

  @override
  State<SpeedTestApp> createState() => _SpeedTestAppState();
}

class _SpeedTestAppState extends State<SpeedTestApp> with SpeedtestHandler {
  late SpeedTest speedTest;
  @override
  void initState() {
    speedTest = SpeedTest(speedtestHandler: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  speedTest.start();
                },
                child: Text("start"))
          ],
        ),
      ),
    );
  }

  @override
  onCriticalFailure(criticalFailure) {
    // TODO: implement onCriticalFailure
    throw UnimplementedError();
  }

  @override
  onDownloadUpdate(downlodData) {
    // TODO: implement onDownloadUpdate
    throw UnimplementedError();
  }

  @override
  onEnd() {
    // TODO: implement onEnd
    throw UnimplementedError();
  }

  @override
  onIPInfoUpdate(ipInfo) {
    // TODO: implement onIPInfoUpdate
    throw UnimplementedError();
  }

  @override
  onPingJitterUpdate(pingJitterUpdate) {
    // TODO: implement onPingJitterUpdate
    throw UnimplementedError();
  }

  @override
  onTestIDReceived(testIdReceived) {
    // TODO: implement onTestIDReceived
    throw UnimplementedError();
  }

  @override
  onUploadUpdate(uploadData) {
    // TODO: implement onUploadUpdate
    throw UnimplementedError();
  }
}
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String _platformVersion = 'Unknown';
//   final _internetSpeedTestPlugin = InternetSpeedTest();

//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initPlatformState() async {
//     String platformVersion;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     // We also handle the message potentially returning null.
//     try {
//       platformVersion =
//           await _internetSpeedTestPlugin.getPlatformVersion() ?? 'Unknown platform version';
//     } on PlatformException {
//       platformVersion = 'Failed to get platform version.';
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;

//     setState(() {
//       _platformVersion = platformVersion;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Center(
//           child: Text('Running on: $_platformVersion\n'),
//         ),
//       ),
//     );
//   }
// }
