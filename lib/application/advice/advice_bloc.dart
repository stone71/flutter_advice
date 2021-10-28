import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'advice_event.dart';
part 'advice_state.dart';

class AdviceBloc extends Bloc<AdviceEvent, AdviceState> {
  AdviceBloc() : super(AdviceInitial()) {
    Future sleep1() {
      return Future.delayed(const Duration(seconds: 2), () => "2");
    }

    on<AdviceEvent>((event, emit) async {
      emit(AdviceStateLoading());
      // do something
      await sleep1(); // fake network request
      // get advice
      emit(AdviceStateLoaded(advice: "our example advice"));
    });
  }
}
