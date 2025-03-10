import '../mapper/apod_mapper.dart';
import '../response/app_response.dart';

abstract interface class HomeService {
  Future<AppResponse<ApodMapper?>> getApod();
}
