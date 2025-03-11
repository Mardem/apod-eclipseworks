import 'package:eclipseworks_apod/main.dart';

import '../../../../core/services/local/localstorage/data/local_storage.dart';
import '../models/local/favorite_service.dart';
import '../models/remote/mapper/apod_mapper.dart';

class FavoriteServiceImpl implements FavoriteService {
  final LocalStorage localStorage = inject<LocalStorage>();

  @override
  Future<bool> add({
    required ApodModel item,
  }) async {
    final List<Map<String, dynamic>>? data = await localStorage.getJsonList(
      key: 'favorite_banners',
    );

    final List<Map<String, dynamic>> favoriteList = data ?? [];

    final bool exists = favoriteList.any(
      (Map<String, dynamic> banner) => banner['title'] == item.title,
    );

    if (!exists) {
      favoriteList.add(item.toJson());
      await localStorage.setJsonList(
        key: 'favorite_banners',
        content: favoriteList,
      );
    }

    return !exists;
  }

  @override
  Future<List<Map<String, dynamic>>?> getFavorites() async {
    final List<Map<String, dynamic>>? data = await localStorage.getJsonList(
      key: 'favorite_banners',
    );

    return data;
  }

  @override
  Future<bool> clear() async => localStorage.clear();
}
