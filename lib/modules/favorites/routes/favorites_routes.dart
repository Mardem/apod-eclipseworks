import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../presentation/favorites_presentation.dart';

enum FavoritesRoutesPath {
  favorites;

  String get path {
    switch (this) {
      case FavoritesRoutesPath.favorites:
        return '/favorites-screen';
    }
  }
}

class FavoritesRoutes {
  static Handler favoritesHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return const FavoritesPresentation();
    },
  );
}
