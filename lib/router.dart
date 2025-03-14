import 'package:eclipseworks_apod/modules/home/routes/home_routes.dart';
import 'package:fluro/fluro.dart';

import 'modules/favorites/routes/favorites_routes.dart';

void defineRouter(FluroRouter router) {
  router.define(
    FavoritesRoutesPath.favorites.path,
    handler: FavoritesRoutes.favoritesHandler,
  );

  router.define(HomeRoutesPath.home.path, handler: HomeRoutes.homeHandler);
}
