import 'package:eclipseworks_apod/modules/home/data/models/remote/mapper/apod_mapper.dart';

import '../../../main.dart';
import 'models/remote/repository/home_repository.dart';
import 'models/remote/response/app_response.dart';
import 'models/remote/service/home_service_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeService _service = inject<HomeService>();

  @override
  Future<AppResponse<ApodModel?>> getApod() async {
    try {
      return await _service.getApod();
    } catch (e) {
      return AppResponse(
        success: false,
        response: null,
      );
    }
  }
}
