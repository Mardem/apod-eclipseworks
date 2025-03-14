import 'package:dio/dio.dart';

import '../../../../../core/http/client.dart';
import '../../../../../main.dart';
import '../../models/remote/mapper/apod_mapper.dart';
import '../../models/remote/response/app_response.dart';
import '../../models/remote/service/home_service_model.dart';

class HomeServiceImpl implements HomeService {
  final HttpClient _client = inject<HttpClient>();

  @override
  Future<AppResponse<ApodModel?>> getApod({
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response<Map<String, dynamic>> result = await _client.get(
        '/planetary/apod',
        queryParameters: queryParameters,
      );

      return AppResponse(
        success: true,
        response: ApodModel.fromJson(result.data!),
      );
    } catch (e) {
      throw Exception('Houve um problema ao buscar os dados da imagem!');
    }
  }
}
