import 'package:dio/dio.dart';
import 'package:eclipseworks_apod/core/http/client.dart';
import 'package:eclipseworks_apod/core/test/mocks/http_client_mock.dart';
import 'package:eclipseworks_apod/main.dart';
import 'package:eclipseworks_apod/modules/home/data/models/remote/mapper/apod_mapper.dart';
import 'package:eclipseworks_apod/modules/home/data/models/remote/service/home_service_model.dart';
import 'package:eclipseworks_apod/modules/home/data/remote/service/home_service.dart';
import 'package:eclipseworks_apod/modules/home/test/fixtures/home_service_fixture.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group(
    'Testing Home Request With Success',
    () {
      late HomeService service;
      late HttpClient mockClient;

      setUpAll(
        () {
          registerFallbackValue(MockRequestOptions());

          inject.registerFactory<HttpClient>(() => mockClient);
          mockClient = HttpClientMock();
          service = HomeServiceImpl();
        },
      );

      tearDownAll(
        () {
          inject.unregister<HttpClient>();
        },
      );

      test(
        'Given get home APOD, When call get apod, Then return home apod',
        () async {
          // Arrange
          when(
            () => mockClient.get<Map<String, dynamic>>(any(),
                baseUrl: any(named: 'baseUrl'),
                queryParameters: any(named: 'queryParameters'),
                options: any(named: 'options')),
          ).thenAnswer(
            (_) async {
              return Response<Map<String, dynamic>>(
                requestOptions: RequestOptions(path: '/places'),
                data: HomeServiceFixture.validResponse,
                statusCode: 200,
              );
            },
          );

          // Act
          final response = await service.getApod();

          // // Assert
          expect(response.success, true);
          expect(response.response, isA<ApodModel>());

          verify(() => mockClient.get<Map<String, dynamic>>(
                any(),
                baseUrl: any(named: 'baseUrl'),
                queryParameters: any(named: 'queryParameters'),
                options: any(named: 'options'),
              )).called(1);
        },
      );
    },
  );

  group(
    'Testing Home Service Request With Error',
    () {
      late HomeService service;
      final HttpClient mockClient = HttpClientMock();

      setUpAll(
        () {
          inject.registerFactory<HttpClient>(() => mockClient);
          service = HomeServiceImpl();
        },
      );

      tearDownAll(
        () {
          inject.unregister<HttpClient>();
        },
      );

      test(
        'Given empty response, When getApod is called, Then throw Exception',
        () async {
          // Arrange
          when(() => mockClient.get(any())).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(path: ''),
              data: {},
            ),
          );

          // Act & Assert
          expect(
            () async => await service.getApod(),
            throwsA(isA<Exception>()),
          );

          verify(() => mockClient.get<Map<String, dynamic>>(
                any(),
                baseUrl: any(named: 'baseUrl'),
                queryParameters: any(named: 'queryParameters'),
                options: any(named: 'options'),
              )).called(1);
        },
      );
    },
  );
}
