part of 'advice_bloc.dart';

@immutable
abstract class AdviceState {}

class AdviceInitial extends AdviceState {}

class AdviceStateLoading extends AdviceState {}

class AdviceStateLoaded extends AdviceState {
  final String advice;
  AdviceStateLoaded({required this.advice});
}

class AdviceStateError extends AdviceState {
  final String message;
  AdviceStateError({required this.message});
}
