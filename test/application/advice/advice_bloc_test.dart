import 'package:flutter_advice/application/advice/advice_bloc.dart';
import 'package:flutter_advice/domain/advice/entities/advice_entity.dart';
import 'package:flutter_advice/domain/advice/failures/failures.dart';
import 'package:flutter_advice/domain/advice/usecases/advice_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_bloc_test.mocks.dart';

@GenerateMocks([AdviceUsecases])
void main() {
  late AdviceBloc adviceBloc;
  late MockAdviceUsecases mockAdviceUsecases;

  setUp(() {
    mockAdviceUsecases = MockAdviceUsecases();
    adviceBloc = AdviceBloc(mockAdviceUsecases);
  });

  test("init state should be AdviceInitial", () {
    //assert
    expect(adviceBloc.state, equals(AdviceInitial()));
  });

  group("AdviceRequestedEvent", () {
    final tAdvice = AdviceEntity(advice: "Test", id: 1);
    const tAdviceString = "Test";
    test("should call usecase if event is added", () async {
      //arrange
      when(mockAdviceUsecases.getAdviceUsecase())
          .thenAnswer((_) async => Right(tAdvice));

      //act
      adviceBloc.add(AdviceRequestedEvent());
      await untilCalled(mockAdviceUsecases.getAdviceUsecase());

      //assert
      verify(mockAdviceUsecases.getAdviceUsecase());
      verifyNoMoreInteractions(mockAdviceUsecases);
    });

    test("should emmit loading then the loaded state after event is added",
        () async {
      // arrange
      when(mockAdviceUsecases.getAdviceUsecase())
          .thenAnswer((_) async => Right(tAdvice));

      //assert later
      final expected = [
        AdviceStateLoading(),
        AdviceStateLoaded(advice: tAdviceString)
      ];
      expectLater(adviceBloc.stream, emitsInOrder(expected));

      // act
      adviceBloc.add(AdviceRequestedEvent());
    });

    test(
        "should emmit loading then the error state after event is added -> usecase fails -> server failure",
        () async {
      // arrange
      when(mockAdviceUsecases.getAdviceUsecase())
          .thenAnswer((_) async => Left(ServerFailure()));

      //assert later
      final expected = [
        AdviceStateLoading(),
        AdviceStateError(message: serverFailureMessage)
      ];
      expectLater(adviceBloc.stream, emitsInOrder(expected));

      // act
      adviceBloc.add(AdviceRequestedEvent());
    });

    test(
        "should emmit loading then the error state after event is added -> usecase fails -> general failure",
        () async {
      // arrange
      when(mockAdviceUsecases.getAdviceUsecase())
          .thenAnswer((_) async => Left(GeneralFailure()));

      //assert later
      final expected = [
        AdviceStateLoading(),
        AdviceStateError(message: generalFailureMessage)
      ];
      expectLater(adviceBloc.stream, emitsInOrder(expected));

      // act
      adviceBloc.add(AdviceRequestedEvent());
    });
  });
}
