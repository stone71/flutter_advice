import 'package:flutter_advice/domain/entities/advice_entity.dart';
import 'package:flutter_advice/domain/failures/failures.dart';
import 'package:flutter_advice/domain/usecases/advice_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'advice_event.dart';
part 'advice_state.dart';

const GENERAL_FAILURE_MESSAGE = "Ups, something gone wrong. Please try again!";
const SERVER_FAILURE_MESSAGE = "Ups, API Error. please try again!";

class AdviceBloc extends Bloc<AdviceEvent, AdviceState> {
  AdviceBloc() : super(AdviceInitial()) {
    final usecases = AdviceUsecases();

    on<AdviceEvent>((event, emit) async {
      emit(AdviceStateLoading());
      // do something
      Either<Failure, AdviceEntity> adviceOrFailure =
          await usecases.getAdviceUsecase(); // fake network request
      // get advice
      emit(adviceOrFailure.fold(
        (failure) => AdviceStateError(message: _mapFailureToMessage(failure)),
        (advice) => AdviceStateLoaded(advice: advice.advice),
      ));
    });

    on<ExampleEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case GeneralFailure:
        return GENERAL_FAILURE_MESSAGE;

      default:
        return GENERAL_FAILURE_MESSAGE;
    }
  }
}
