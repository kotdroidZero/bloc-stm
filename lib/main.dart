import 'package:bloc_stm/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: const MaterialApp(
        home: MyCounterPage(),
      ),
    );
  }
}

class MyCounterPage extends StatelessWidget {
  const MyCounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter App"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Press either button on increasae or decrease the value...',
          ),
          const SizedBox(
            height: 45,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<CounterCubit>(context).increment();
                },
                child: const Icon(Icons.add),
              ),
              const SizedBox(
                width: 45,
              ),
              BlocConsumer<CounterCubit, CounterState>(
                builder: (context, state) {
                  return Text(
                    state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                },
                buildWhen: (previous, current) => current != previous,
                listener: (context, state) {
                  var msg = state.wasIncremented == true
                      ? "Incremented"
                      : "Decremented";
                  // if (state.wasIncremented == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(msg),
                      duration: const Duration(milliseconds: 300),
                    ),
                  );
                },
                listenWhen: (previous, current) => previous != current,
              ),
              const SizedBox(
                width: 45,
              ),
              FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<CounterCubit>(context).decrement();
                },
                child: const Icon(Icons.remove),
              ),
            ],
          )
        ],
      )),
    );
  }
}
