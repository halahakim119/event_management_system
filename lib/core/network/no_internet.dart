import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../main.dart';
import '../../translations/codegen_loader.g.dart';
import '../injection/injection_container.dart';
import 'internet_checker.dart';
import 'no_internet_screen.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  StreamSubscription<ConnectivityResult>? _subscription;

  @override
  void initState() {
    super.initState();
    sl<InternetChecker>().run();

    _subscription = Connectivity().onConnectivityChanged.listen((result) async {
      bool isConnected = await sl<InternetChecker>().checkInternet();
      if (result != ConnectivityResult.none && isConnected) {
        _subscription?.cancel();

        runApp(OverlaySupport.global(
          child: EasyLocalization(
            path: 'assets/translations',
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            fallbackLocale: const Locale('ar'),
            assetLoader: const CodegenLoader(),
            child: MyApp(),
          ),
        ));
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NoInternetScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
