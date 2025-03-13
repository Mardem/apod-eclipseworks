import '../../../main.dart';
import '../data/home_repository.dart';
import '../data/models/remote/repository/home_repository.dart';
import '../data/models/remote/service/home_service_model.dart';
import '../data/remote/service/home_service.dart';
import '../vm/home_viewmodel.dart';

void startHomeModule() {
  /// Services
  inject.registerFactory<HomeService>(() => HomeServiceImpl());

  /// Repositories
  inject.registerFactory<HomeRepository>(() => HomeRepositoryImpl());

  /// ViewModels
  inject.registerSingleton<HomeViewModel>(HomeViewModel());
}
