import 'package:eclipseworks_apod/modules/home/data/models/remote/mapper/apod_mapper.dart';

abstract class FavoriteService {
  Future<bool> add({required ApodModel item});

  Future<List<Map<String, dynamic>>?> getFavorites();

  Future<bool> clear();
}
