import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:sw_camera/sw_camera_model.dart';

class SwCamera {
  static const MethodChannel _channel = MethodChannel('sw_camera');

  // static const EventChannel _eventChannel = EventChannel('sw_camera_event');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<Uint8List> get takePicture async {
    return await _channel.invokeMethod('sw_takepicture');
  }

  static Future<void> get closeCamera async {
    await _channel.invokeMethod('closeCamera');
  }

  static Future<void> get activeCamera async {
    await _channel.invokeMethod('activeCamera');
  }

  static Future<void> get changeCameraFace async {
    await _channel.invokeMethod('changeFace');
  }

  static Future<void> get turnOnLight async {
    await _channel.invokeMethod('turnOnLight');
  }

  static Future<void> get turnOffLight async {
    await _channel.invokeMethod('turnOffLight');
  }

  static Future<void> setQuality({required SWCameraQuality qulity}) async {
    int arg = 0;
    if (qulity == SWCameraQuality.low) {
      arg = 1;
    } else if (qulity == SWCameraQuality.frame960x540) {
      arg = 2;
    } else if (qulity == SWCameraQuality.high) {
      arg = 3;
    } else if (qulity == SWCameraQuality.frame1280x720) {
      arg = 4;
    } else {
      arg = 5;
    }
    await _channel.invokeMethod('setQuality', arg);
  }
}
