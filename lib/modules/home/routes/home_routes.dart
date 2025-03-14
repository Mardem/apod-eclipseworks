import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../home.dart';

enum HomeRoutesPath {
  home;

  String get path {
    switch (this) {
      case HomeRoutesPath.home:
        return '/home-screen';
    }
  }
}

class HomeRoutes {
  static Handler homeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return const HomePresentation();
    },
  );
}
