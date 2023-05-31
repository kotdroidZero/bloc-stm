import 'package:bloc_stm/cubit/counter_cubit.dart';
import 'package:bloc_stm/cubit/internet_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group("CounterCubit", () {
    CounterCubit? counterCubit;
    setUp(() {
      counterCubit = CounterCubit(
          internetCubit: InternetCubit(connectivity: Connectivity()));
    });

    tearDown(() {
      counterCubit?.close();
    });

    test(
        "the initial state for the CounterCubit is CounterState(counterValue:0)",
        () {
      expect(counterCubit?.state,
          CounterState(counterValue: 0, wasIncremented: false));
    });

    // blocTest(
    //   "Increment Function Test",
    //   build: () => counterCubit,
    //   act: (bloc) => bloc?.increment(),
    //   expect: () => [CounterState(counterValue: 1, wasIncremented: true)],
    // );
  });
}
