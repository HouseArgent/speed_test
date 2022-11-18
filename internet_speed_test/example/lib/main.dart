import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:internet_speed_test/speed_test_lib.dart';
void main() {
  runApp(const SpeedTestApp());
}

class SpeedTestApp extends StatefulWidget {
  const SpeedTestApp({super.key});

  @override
  State<SpeedTestApp> createState() => _SpeedTestAppState();
}

class _SpeedTestAppState extends State<SpeedTestApp> with SpeedtestHandler {
  num upload = 0;
  num download = 0;
  num jitter = 0;
  num ping = 0;

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
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Jitter ${jitter}"),
              Text("download ${download}"),
              Text("upload ${upload}"),
              Text("ping ${ping}"),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    speedTest.start();
                  },
                  child: Text("start"))
            ],
          ),
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
    if(downlodData is Map){
      download= downlodData["download"];
      //{download: 3.4561273631840796, progress: 0.014066666666666667}
    }
    setState(() {
      
    });
    print(downlodData.runtimeType);
    // TODO: implement onDownloadUpdate
    //throw UnimplementedError();
  }

  @override
  onEnd() {
    // TODO: implement onEnd
    //throw UnimplementedError();
  }

  @override
  onIPInfoUpdate(ipInfo) {
    // TODO: implement onIPInfoUpdate
    //throw UnimplementedError();
  }

  @override
  onPingJitterUpdate(pingJitterUpdate) {
    // TODO: implement onPingJitterUpdate
    //throw UnimplementedError();
  }

  @override
  onTestIDReceived(testIdReceived) {
     if(testIdReceived is Map){
      download= testIdReceived["upload"];
      //{download: 3.4561273631840796, progress: 0.014066666666666667}
    }
  }

  @override
  onUploadUpdate(uploadData) {
    if(uploadData is Map){
      upload= uploadData["upload"];
      //{download: 3.4561273631840796, progress: 0.014066666666666667}
    }
    setState(() {
      
    });
    // TODO: implement onUploadUpdate
    //throw UnimplementedError();
  }
}
