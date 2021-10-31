import 'package:flutter_advice/domain/advice/entities/advice_entity.dart';
import 'package:flutter_advice/domain/advice/failures/failures.dart';
import 'package:flutter_advice/domain/advice/repositories/advice_repository.dart';
import 'package:flutter_advice/domain/advice/usecases/advice_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_usecases_test.mocks.dart';

@GenerateMocks([AdviceRepository])
void main() {
  late AdviceUsecases adviceUsecases;
  late MockAdviceRepository mockAdviceRepository;

  setUp(() {
    mockAdviceRepository = MockAdviceRepository();
    adviceUsecases = AdviceUsecases(adviceRepository: mockAdviceRepository);
  });

  group("getAdviceUsecase", () {
    final tAdvice = AdviceEntity(advice: "test", id: 1);

    test("should return the same advice as repo", () async {
      // arrange

      when(mockAdviceRepository.getAdviceFromApi())
          .thenAnswer((_) async => Right(tAdvice));

      // act

      final result = await adviceUsecases.getAdviceUsecase();

      // assert
      expect(result, Right(tAdvice));
      verify(mockAdviceRepository.getAdviceFromApi());
      verifyNoMoreInteractions(mockAdviceRepository);
    });

    test("should return the same failure as repo", () async {
      // arrange

      when(mockAdviceRepository.getAdviceFromApi())
          .thenAnswer((_) async => Left(ServerFailure()));

      // act

      final result = await adviceUsecases.getAdviceUsecase();

      // assert
      expect(result, Left(ServerFailure()));
      verify(mockAdviceRepository.getAdviceFromApi());
      verifyNoMoreInteractions(mockAdviceRepository);
    });
  });
}
