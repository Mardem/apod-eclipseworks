import 'package:fluro/fluro.dart';

import 'modules/favorites/routes/favorites_routes.dart';

void defineRouter(FluroRouter router) {
  router.define(
    FavoritesRoutesPath.favorites.path,
    handler: FavoritesRoutes.favoritesHandler,
  );
}
