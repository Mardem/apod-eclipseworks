import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

import '../../http/client.dart';

class HttpClientMock extends Mock implements HttpClient {}

class MockRequestOptions extends Mock implements RequestOptions {}
