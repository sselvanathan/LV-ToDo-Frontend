import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

class CurrentUser{
  static final CurrentUser _currentUser = CurrentUser._initialize();
  late String _deviceName;
  late String _token = '';

  factory CurrentUser(){
    return _currentUser;
  }
  CurrentUser._initialize() {
    initializeDeviceName();
  }

  Future<void> initializeDeviceName() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        var deviceInfo = await deviceInfoPlugin.androidInfo;
        _setDeviceName(deviceInfo.model);
      } else if (Platform.isIOS) {
        var deviceInfo = await deviceInfoPlugin.iosInfo;
        _setDeviceName(deviceInfo.model);
      }
    } on PlatformException {
      _setDeviceName('unknown device name');
    }
  }

  void _setDeviceName(String deviceName){
    _deviceName = deviceName;
  }

  String getDeviceName(){
    return _deviceName;
  }

  void setToken(String token){
    _token = token;
  }

  String getToken(){
    return _token;
  }
}