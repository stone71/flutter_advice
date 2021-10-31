import 'package:flutter_advice/infrastructure/datasources/advice_remote_datasource.dart';
import 'package:flutter_advice/infrastructure/exceptions/exceptions.dart';
import 'package:flutter_advice/infrastructure/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';
import 'advice_remote_datasource_test.mocks.dart';

@GenerateMocks([Dio])
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
    final t_Advice_Model = AdviceModel(advice: "Test", id: 1);

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
          "Access-Control-Allow-Origin": "*",
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
      expect(result, t_Advice_Model);
    });

    test("should throw ServerException if the response code ist not 200.",
        () async {
      //arrange
      setUpMockClientFailure404();

      //act
      final call = await adviceRemoteDatasource.getRandomAdviceFromApi;

      //assert
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
