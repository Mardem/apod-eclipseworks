import 'package:eclipseworks_apod/core/services/local/localstorage/local_storage.dart';

import '../../main.dart';
import '../../modules/favorites/di/favorites_di.dart';
import '../../modules/home/home.dart';
import '../http/client.dart';
import '../services/local/localstorage/data/local_storage.dart';

Future<void> startModules() async {
  inject.registerSingleton<HttpClient>(HttpClientImpl());

  final localStorage = LocalStorageImpl();
  await localStorage.init();
  inject.registerSingleton<LocalStorage>(localStorage);

  startFavoritesModule();
  startHomeModule();
}
