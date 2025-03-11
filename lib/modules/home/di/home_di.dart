import 'package:eclipseworks_apod/modules/home/data/local/favorite_service.dart';
import 'package:eclipseworks_apod/modules/home/data/models/local/favorite_service.dart';

import '../../../main.dart';
import '../data/home_repository.dart';
import '../data/models/remote/repository/home_repository.dart';
import '../data/models/remote/service/home_service_model.dart';
import '../data/remote/service/home_service.dart';
import '../vm/home_viewmodel.dart';

void startHomeModule() {
  /// Services
  inject.registerFactory<HomeService>(() => HomeServiceImpl());
  inject.registerFactory<FavoriteService>(() => FavoriteServiceImpl());

  /// Repositories
  inject.registerFactory<HomeRepository>(() => HomeRepositoryImpl());

  /// ViewModels
  inject.registerSingleton<HomeViewModel>(HomeViewModel());
}
