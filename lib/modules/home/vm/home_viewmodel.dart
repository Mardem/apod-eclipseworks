import 'package:eclipseworks_apod/modules/home/data/models/remote/response/app_response.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/vm/base_view_model.dart';
import '../../../main.dart';
import '../data/models/local/favorite_service.dart';
import '../data/models/remote/mapper/apod_mapper.dart';
import '../data/models/remote/repository/home_repository.dart';

class HomeViewModel extends BaseViewModel {
  final BehaviorSubject<ApodModel> _apod = BehaviorSubject<ApodModel>();
  Stream<ApodModel> get apod => _apod.stream;
  void setApod(ApodModel value) => _apod.add(value);

  final HomeRepository repository = inject<HomeRepository>();
  final FavoriteService favoriteService = inject<FavoriteService>();

  Future<void> loadApod({Map<String, dynamic>? parameters}) async {
    setLoading(true);
    final AppResponse<ApodModel?> request = await repository.getApod(
      queryParameters: parameters,
    );

    setApod(request.response!);

    setLoading(false);
  }

  Future<bool> add({required ApodModel item}) async {
    return await favoriteService.add(
      item: item,
    );
  }
}
