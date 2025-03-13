import 'package:eclipseworks_apod/core/vm/base_view_model.dart';
import 'package:eclipseworks_apod/main.dart';
import 'package:eclipseworks_apod/modules/home/data/models/remote/mapper/apod_mapper.dart';
import 'package:rxdart/rxdart.dart';

import '../../home/data/models/local/favorite_service.dart';
import '../../home/data/models/remote/enums/apod_reaction.dart';
import '../../home/presentation/utils/home_chip_model.dart';

class FavoritesViewmodel extends BaseViewModel {
  final FavoriteService favoriteService = inject<FavoriteService>();

  final BehaviorSubject<List<ApodModel>> _apods =
      BehaviorSubject<List<ApodModel>>.seeded([]);
  Stream<List<ApodModel>> get apod => _apods.stream;
  void setFavorites(List<ApodModel> value) => _apods.add(value);

  final BehaviorSubject<ApodReaction> _favoriteFilter =
      BehaviorSubject<ApodReaction>();
  Stream<ApodReaction> get favoriteFilter => _favoriteFilter.stream;
  void setFavoriteFilter(ApodReaction value) => _favoriteFilter.add(value);

  Future<List<ApodModel>> _mapFavorites() async {
    final List<Map<String, dynamic>>? list =
        await favoriteService.getFavorites();

    if (list == null) {
      return [];
    }

    List<ApodModel> favorites = list
        .map((Map<String, dynamic> item) => ApodModel.fromJson(item))
        .toList();

    return favorites;
  }

  Future<void> loadFavorites() async {
    setLoading(true);
    List<ApodModel> favorites = await _mapFavorites();

    setFavorites(favorites);
    setLoading(false);
  }

  Future<bool> removeFavorite({required ApodModel favorite}) async {
    List<ApodModel> favorites = _apods.value;

    favorites.removeWhere((ApodModel item) => item.title == favorite.title);

    setFavorites(favorites);
    return favoriteService.addList(items: favorites);
  }

  Future<void> filter({
    required ApodReaction reactionFilter,
  }) async {
    List<ApodModel> favorites = await _mapFavorites();

    if (reactionFilter != ApodReaction.all) {
      List<ApodModel> filteredFavorites = favorites
          .where((ApodModel item) => item.reaction == reactionFilter)
          .toList();

      setFavorites(filteredFavorites);
    } else {
      setFavorites(favorites);
    }
  }

  Future<void> filterFavoritesChip({
    required HomeChipModel chip,
  }) async {
    await filter(reactionFilter: chip.type);
    setFavoriteFilter(chip.type);
  }
}
