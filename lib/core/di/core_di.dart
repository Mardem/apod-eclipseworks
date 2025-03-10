import '../../main.dart';
import '../../modules/home/home.dart';
import '../http/client.dart';

void startModules() {
  inject.registerSingleton<HttpClient>(HttpClientImpl());

  startHomeModule();
}
