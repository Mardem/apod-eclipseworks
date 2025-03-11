import 'package:eclipseworks_apod/modules/home/data/models/remote/mapper/apod_mapper.dart';

import '../response/app_response.dart';

abstract interface class HomeRepository {
  Future<AppResponse<ApodModel?>> getApod();
}
