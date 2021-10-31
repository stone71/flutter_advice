import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_advice/domain/advice/entities/advice_entity.dart';
import 'package:flutter_advice/domain/advice/failures/failures.dart';
import 'package:flutter_advice/domain/advice/usecases/advice_usecases.dart';

part 'advice_event.dart';
part 'advice_state.dart';

const generalFailureMessage = "Ups, something gone wrong. Please try again!";
const serverFailureMessage = "Ups, API Error. please try again!";

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
        return serverFailureMessage;
      case GeneralFailure:
        return generalFailureMessage;

      default:
        return generalFailureMessage;
    }
  }
}
