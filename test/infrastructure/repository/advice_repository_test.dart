import 'package:dartz/dartz.dart';
import 'package:flutter_advice/domain/entities/advice_entity.dart';
import 'package:flutter_advice/domain/failures/failures.dart';
import 'package:flutter_advice/domain/repositories/advice_repository.dart';
import 'package:flutter_advice/infrastructure/datasources/advice_remote_datasource.dart';
import 'package:flutter_advice/infrastructure/models/advice_model.dart';
import 'package:flutter_advice/infrastructure/repositories/advice_repository_impl.dart';
import 'package:flutter_advice/infrastructure/exceptions/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_repository_test.mocks.dart';

@GenerateMocks([AdviceRemoteDatasource])
void main() {
  late AdviceRepository adviceRepository;
  late MockAdviceRemoteDatasource mockAdviceRemoteDatasource;

  setUp(() {
    mockAdviceRemoteDatasource = MockAdviceRemoteDatasource();
    adviceRepository = AdviceRepositoryImpl(
        adviceRemoteDatasource: mockAdviceRemoteDatasource);
  });

  group("getAdviceFromAPI", () {
    final t_AdviceModel = AdviceModel(advice: "test", id: 1);
    final AdviceEntity t_advice = t_AdviceModel;

    test(
        "should return remote data if the call to remote datasource is successfull",
        () async {
      // arrange

      when(mockAdviceRemoteDatasource.getRandomAdviceFromApi())
          .thenAnswer((_) async => t_AdviceModel);

      // act
      final result = await adviceRepository.getAdviceFromApi();

      // assert
      verify(mockAdviceRemoteDatasource.getRandomAdviceFromApi());
      expect(result, Right(t_advice));
      verifyNoMoreInteractions(mockAdviceRemoteDatasource);
    });

    test("should return server failure if datasource throws server-exception",
        () async {
      //arrange
      when(mockAdviceRemoteDatasource.getRandomAdviceFromApi())
          .thenThrow(ServerException());

      //act
      final result = await adviceRepository.getAdviceFromApi();

      //assert
      verify(mockAdviceRemoteDatasource.getRandomAdviceFromApi());
      expect(result, Left(ServerFailure()));
      verifyNoMoreInteractions(mockAdviceRemoteDatasource);
    });
  });
}
