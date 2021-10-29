import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_advice/domain/entities/advice_entity.dart';
import 'package:flutter_advice/domain/failures/failures.dart';
import 'package:flutter_advice/domain/usecases/advice_usecases.dart';

part 'advice_event.dart';
part 'advice_state.dart';

const GENERAL_FAILURE_MESSAGE = "Ups, something gone wrong. Please try again!";
const SERVER_FAILURE_MESSAGE = "Ups, API Error. please try again!";

class AdviceBloc extends Bloc<AdviceEvent, AdviceState> {
  AdviceBloc(AdviceUsecases usecases) : super(AdviceInitial()) {
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
