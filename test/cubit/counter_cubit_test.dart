import 'package:bloc_learn/view_states/counter_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Counter cubit", () {
    CounterCubit counterCubit;
    counterCubit = CounterCubit();

    tearDown(() {
      counterCubit.close();
    });

    test("The initial state for counter cubit is COunterState(counterValue: 0)",
        () {
      expect(counterCubit.state, CounterState(counterValue: 0));
    });

    blocTest(
      'The cubit should emit a CounterState(counterValue:1) when increment function is called',
      build: () => counterCubit,
      act: (cubit) => (cubit as CounterCubit).increment(),
      expect: () => [CounterState(counterValue: 1)],
    );
  });
}
