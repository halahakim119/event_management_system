import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:overlay_support/overlay_support.dart';

import 'no_internet_screen.dart';

class InternetChecker {
  static final InternetChecker _singleton = InternetChecker._internal();

  factory InternetChecker() {
    return _singleton;
  }

  InternetChecker._internal();
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  OverlaySupportEntry? _overlayControll;

  void run() {
    _connectivitySubscription = _connectivity.onConnectivityChanged
        .listen((result) => _updateConnectionStatus(result));
  }

//check internet if phone
  Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  Future _updateConnectionStatus(ConnectivityResult result) async {
    bool hasInternet = await checkInternet();
    switch (result) {
      case ConnectivityResult.wifi:
        if (hasInternet) {
          _overlayControll?.dismiss();
          _overlayControll = null;
        }

        break;
      case ConnectivityResult.mobile:
        if (hasInternet) {
          _overlayControll?.dismiss();
          _overlayControll = null;
        }
        break;
      default:
        _overlayControll ??= showOverlay((context, progress) {
          return const NoInternetScreen();
        }, duration: const Duration(seconds: 0));
    }
  }

  void dispose() {
    _connectivitySubscription.cancel();
  }
}
