import 'package:eclipseworks_apod/main.dart';

import '../vm/favorites_viewmodel.dart';

void startFavoritesModule() {
  /// Services

  /// Repositories

  /// ViewModels
  inject.registerFactory<FavoritesViewmodel>(() => FavoritesViewmodel());
}
