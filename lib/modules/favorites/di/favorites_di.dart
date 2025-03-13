import 'package:eclipseworks_apod/main.dart';

import '../data/local/favorite_service.dart';
import '../data/models/local/favorite_service.dart';
import '../vm/favorites_viewmodel.dart';

void startFavoritesModule() {
  /// Services
  inject.registerFactory<FavoriteService>(() => FavoriteServiceImpl());

  /// Repositories

  /// ViewModels
  inject.registerFactory<FavoritesViewmodel>(() => FavoritesViewmodel());
}
