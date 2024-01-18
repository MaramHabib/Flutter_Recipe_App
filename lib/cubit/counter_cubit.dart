import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(0));

  void increment() => CounterState(state.counterValue + 1);
  void decrement() => CounterState(state.counterValue - 1);
}
