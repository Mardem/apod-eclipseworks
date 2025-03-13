import 'package:eclipseworks_apod/core/vm/base_view_model.dart';
import 'package:eclipseworks_apod/main.dart';
import 'package:eclipseworks_apod/modules/home/data/models/remote/mapper/apod_mapper.dart';
import 'package:rxdart/rxdart.dart';

import '../../home/data/models/local/favorite_service.dart';

class FavoritesViewmodel extends BaseViewModel {
  final FavoriteService favoriteService = inject<FavoriteService>();

  final BehaviorSubject<List<ApodModel>> _apods =
      BehaviorSubject<List<ApodModel>>.seeded([]);

  Stream<List<ApodModel>> get apod => _apods.stream;

  void setFavorites(List<ApodModel> value) => _apods.add(value);

  Future<void> loadFavorites() async {
    setLoading(true);
    final List<Map<String, dynamic>>? list =
        await favoriteService.getFavorites();

    if (list == null) {
      return;
    }

    List<ApodModel> favorites = list
        .map((Map<String, dynamic> item) => ApodModel.fromJson(item))
        .toList();

    setFavorites(favorites);
    setLoading(false);
  }

  Future<bool> removeFavorite({required ApodModel favorite}) async {
    List<ApodModel> favorites = _apods.value;

    favorites.removeWhere((ApodModel item) => item.title == favorite.title);

    setFavorites(favorites);
    return favoriteService.addList(items: favorites);
  }
}
