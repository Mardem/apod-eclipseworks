import 'package:eclipseworks_apod/main.dart';

import '../../../../core/services/local/localstorage/data/local_storage.dart';
import '../../../home/data/models/remote/mapper/apod_mapper.dart';
import '../models/local/favorite_service.dart';

class FavoriteServiceImpl implements FavoriteService {
  final LocalStorage localStorage = inject<LocalStorage>();

  String localStorageKey = 'favorite_banners';

  @override
  Future<bool> add({
    required ApodModel item,
  }) async {
    final List<Map<String, dynamic>>? data = await localStorage.getJsonList(
      key: localStorageKey,
    );

    final List<Map<String, dynamic>> favoriteList = data ?? [];

    final bool exists = favoriteList.any(
      (Map<String, dynamic> banner) => banner['title'] == item.title,
    );

    if (!exists) {
      favoriteList.add(item.toJson());
      await localStorage.setJsonList(
        key: localStorageKey,
        content: favoriteList,
      );
    }

    return !exists;
  }

  @override
  Future<List<Map<String, dynamic>>?> getFavorites() async {
    final List<Map<String, dynamic>>? data = await localStorage.getJsonList(
      key: localStorageKey,
    );

    return data;
  }

  @override
  Future<bool> clear() async => localStorage.clear();

  @override
  Future<bool> addList({required List<ApodModel> items}) async {
    final List<Map<String, dynamic>> formatted = items.map(
      (ApodModel item) {
        return item.toJson();
      },
    ).toList();

    await localStorage.setJsonList(
      key: localStorageKey,
      content: formatted,
    );

    return true;
  }
}
