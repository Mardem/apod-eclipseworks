import 'package:eclipseworks_apod/modules/home/data/models/remote/enums/apod_media_type.dart';
import 'package:eclipseworks_apod/modules/home/data/models/remote/mapper/apod_mapper.dart';

class ApodModelFixture {
  static ApodModel model() => ApodModel(
        date: '2025-03-13',
        explanation: 'explanation...',
        hdUrl: 'https://example.com/image.jpg',
        url: 'https://example.com/hd_image.jpg',
        title: 'Teste de Imagem',
        mediaType: ApodMediaType.image,
        serviceVersion: 'v1',
      );
}
