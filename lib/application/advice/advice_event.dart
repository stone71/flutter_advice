part of 'advice_bloc.dart';

@immutable
abstract class AdviceEvent {}

/// event when button is pressed
class AdviceRequestedEvent extends AdviceEvent {}

class ExampleEvent extends AdviceEvent {}
