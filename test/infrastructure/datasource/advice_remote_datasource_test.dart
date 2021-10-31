import 'package:flutter_advice/infrastructure/advice/datasources/advice_remote_datasource.dart';
import 'package:flutter_advice/infrastructure/advice/exceptions/exceptions.dart';
import 'package:flutter_advice/infrastructure/advice/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';
import 'advice_remote_datasource_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late AdviceRemoteDatasource adviceRemoteDatasource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    adviceRemoteDatasource = AdviceRemoteDatasourceImpl(client: mockClient);
  });

  void setUpMockClientSuccess200() {
    //arrange
    when(mockClient.get(any, headers: anyNamed("headers"))).thenAnswer(
        (_) async => http.Response(fixture("advice_http_respond.json"), 200));
  }

  void setUpMockClientFailure404() {
    //arrange
    when(mockClient.get(any, headers: anyNamed("headers")))
        .thenAnswer((_) async => http.Response("something went wrong", 404));
  }

  group("getRandomAdviceFromApi", () {
    final tAdviceModel = AdviceModel(advice: "Test", id: 1);

    test(
        "should perform a get request on url with advice being the endpoint and header json",
        () {
      //arrange
      setUpMockClientSuccess200();

      //act
      adviceRemoteDatasource.getRandomAdviceFromApi();

      //assert
      verify(mockClient.get(
        Uri.parse("https://api.adviceslip.com/advice"),
        headers: {
          'Content-Type': 'application/json',
        },
      ));
    });

    test("should return a valid advice when the response is successful.",
        () async {
      //arrange
      setUpMockClientSuccess200();

      //act
      final result = await adviceRemoteDatasource.getRandomAdviceFromApi();

      //assert
      expect(result, tAdviceModel);
    });

    test("should throw ServerException if the response code ist not 200.",
        () async {
      //arrange
      setUpMockClientFailure404();

      //act
      final call = adviceRemoteDatasource.getRandomAdviceFromApi;

      //assert
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
