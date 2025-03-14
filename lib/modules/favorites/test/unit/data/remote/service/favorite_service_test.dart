import 'package:eclipseworks_apod/core/services/local/localstorage/data/local_storage.dart';
import 'package:eclipseworks_apod/core/test/mocks/local_storage_mock.dart';
import 'package:eclipseworks_apod/main.dart';
import 'package:eclipseworks_apod/modules/favorites/data/local/favorite_service.dart';
import 'package:eclipseworks_apod/modules/favorites/data/models/local/favorite_service.dart';
import 'package:eclipseworks_apod/modules/home/data/models/remote/mapper/apod_mapper.dart';
import 'package:eclipseworks_apod/modules/home/test/fixtures/models/apod_model_fixture.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group(
    'Testing Favorite Local Service  With Success',
    () {
      late FavoriteService service;
      late LocalStorage mockLocalStorage;
      const String localStorageKey = 'favorite_banners';
      final ApodModel apodMock = ApodModelFixture.model();

      setUpAll(
        () {
          mockLocalStorage = LocalStorageMock();
          inject.registerFactory<LocalStorage>(() => mockLocalStorage);

          service = FavoriteServiceImpl();
        },
      );

      tearDownAll(() {
        inject.unregister<LocalStorage>();
      });

      test('should add a favorite item if it does not exist', () async {
        /// Arrange
        when(
          () => mockLocalStorage.getJsonList(key: localStorageKey),
        ).thenAnswer((_) async => []);
        when(
          () => mockLocalStorage.setJsonList(
              key: any(named: 'key'), content: any(named: 'content')),
        ).thenAnswer((_) async => true);

        /// Act
        final result = await service.add(item: apodMock);

        /// Assert
        expect(result, true);
        verify(
          () => mockLocalStorage.setJsonList(
            key: localStorageKey,
            content: [apodMock.toJson()],
          ),
        ).called(1);
      });

      test('should not add a duplicate favorite item', () async {
        /// Arrange
        when(() => mockLocalStorage.getJsonList(key: localStorageKey))
            .thenAnswer(
          (_) async => [apodMock.toJson()],
        );

        /// Act
        final result = await service.add(item: apodMock);

        /// Assert
        expect(result, false);
        verifyNever(
          () => mockLocalStorage.setJsonList(
            key: any(named: 'key'),
            content: any(named: 'content'),
          ),
        );
      });

      test('should return all favorite items', () async {
        /// Arrange
        final List<Map<String, dynamic>> storedData = [apodMock.toJson()];
        when(
          () => mockLocalStorage.getJsonList(key: localStorageKey),
        ).thenAnswer((_) async => storedData);

        /// Act
        final result = await service.getFavorites();

        /// Assert
        expect(result, storedData);
        verify(
          () => mockLocalStorage.getJsonList(key: localStorageKey),
        ).called(3);
      });

      test('should clear all favorite items', () async {
        /// Arrange
        when(() => mockLocalStorage.clear()).thenAnswer((_) async => true);

        /// Act
        final result = await service.clear();

        /// Assert
        expect(result, true);
        verify(() => mockLocalStorage.clear()).called(1);
      });

      test('should add a list of favorite items', () async {
        /// Arrange
        final List<ApodModel> items = [
          apodMock,
          apodMock.copyWith(title: 'Other title'),
        ];

        final List<Map<String, dynamic>> formattedItems =
            items.map((e) => e.toJson()).toList();

        when(
          () => mockLocalStorage.setJsonList(
            key: localStorageKey,
            content: formattedItems,
          ),
        ).thenAnswer((_) async => true);

        /// Act
        final result = await service.addList(items: items);

        /// Assert
        expect(result, true);
        verify(
          () => mockLocalStorage.setJsonList(
            key: localStorageKey,
            content: formattedItems,
          ),
        ).called(1);
      });
    },
  );
}
