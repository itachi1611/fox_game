import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../main.dart';

class AppConnection {
  AppConnection._();

  static final _instance = AppConnection._();

  static AppConnection get instance => _instance;

  final _networkConnectivity = Connectivity();

  final _controller = StreamController.broadcast();

  Stream get myStream => _controller.stream;

  void initialise() async {
    ConnectivityResult result = await _networkConnectivity.checkConnectivity();
    _checkStatus(result);
    _networkConnectivity.onConnectivityChanged.listen((result) {
      appLogger.i(result);
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();
}