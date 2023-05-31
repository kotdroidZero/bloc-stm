import 'package:bloc_stm/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/counter_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              Expanded(
                child: BlocBuilder<InternetCubit, InternetState>(
                    builder: (context, state) {
                  var msg = "";
                  if (state is InternetConnected) {
                    msg =
                        "Internet is connected with : ${state.connectionType.name}";
                  }
                  if (state is InternetDisconnected) {
                    msg = "Internet is not connected . ";
                  }
                  return msg.isEmpty
                      ? const CircularProgressIndicator()
                      : Text(
                          msg,
                          style: Theme.of(context).textTheme.bodyMedium,
                        );
                }),
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
