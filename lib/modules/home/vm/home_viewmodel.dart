import 'package:eclipseworks_apod/modules/home/data/models/remote/response/app_response.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/vm/base_view_model.dart';
import '../../../main.dart';
import '../data/models/remote/mapper/apod_mapper.dart';
import '../data/models/remote/repository/home_repository.dart';

class HomeViewModel extends BaseViewModel {
  final BehaviorSubject<ApodMapper> _apod = BehaviorSubject<ApodMapper>();

  Stream<ApodMapper> get apod => _apod.stream;

  void setApod(ApodMapper value) => _apod.add(value);

  final HomeRepository repository = inject<HomeRepository>();

  Future<void> loadApod() async {
    setLoading(true);
    final AppResponse<ApodMapper?> request = await repository.getApod();

    setApod(request.response!);

    setLoading(false);
  }
}
