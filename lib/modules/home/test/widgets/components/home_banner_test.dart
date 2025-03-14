import 'package:cached_network_image/cached_network_image.dart';
import 'package:eclipseworks_apod/modules/home/data/models/remote/mapper/apod_mapper.dart';
import 'package:eclipseworks_apod/modules/home/presentation/components/home_banner.dart';
import 'package:eclipseworks_apod/modules/home/test/fixtures/models/apod_model_fixture.dart';
import 'package:eclipseworks_apod/modules/home/vm/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mocktail/mocktail.dart';

class MockApodModel extends Mock implements ApodModel {}

class MockHomeViewModel extends Mock implements HomeViewModel {}

void main() {
  group('HomeBanner render', () {
    late ApodModel mockApodModel;
    late MockHomeViewModel mockViewModel;

    setUpAll(() {
      mockViewModel = MockHomeViewModel();
      mockApodModel = ApodModelFixture.model();
    });

    testWidgets('Should render banner with icons', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HomeBanner(
              details: mockApodModel,
              viewModel: mockViewModel,
            ),
          ),
        ),
      );

      // Act & Assert
      expect(find.byType(CachedNetworkImage), findsOneWidget);
      expect(find.byIcon(LucideIcons.heart), findsOneWidget);
      expect(find.byIcon(LucideIcons.heartCrack), findsOneWidget);
      expect(find.byIcon(LucideIcons.info), findsOneWidget);
    });
  });
}
