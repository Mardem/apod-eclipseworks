import 'package:cached_network_image/cached_network_image.dart';
import 'package:eclipseworks_apod/modules/home/data/models/remote/mapper/apod_mapper.dart';
import 'package:eclipseworks_apod/modules/home/presentation/components/home_card.dart';
import 'package:eclipseworks_apod/modules/home/test/fixtures/models/apod_model_fixture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ApodModel mockApodModel;

  setUp(() {
    mockApodModel = ApodModelFixture.model();
  });

  testWidgets('Should render the texts with image',
      (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HomeImageCard(details: mockApodModel),
        ),
      ),
    );

    // Act & Assert
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.text('Teste de Imagem'), findsOneWidget);
    expect(find.textContaining('2025'), findsOneWidget);
  });
}
