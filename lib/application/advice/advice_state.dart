part of 'advice_bloc.dart';

@immutable
abstract class AdviceState {}

class AdviceInitial extends AdviceState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class AdviceStateLoading extends AdviceState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class AdviceStateLoaded extends AdviceState with EquatableMixin {
  @override
  List<Object?> get props => [advice];

  final String advice;
  AdviceStateLoaded({required this.advice});
}

class AdviceStateError extends AdviceState with EquatableMixin {
  @override
  List<Object?> get props => [message];

  final String message;
  AdviceStateError({required this.message});
}
