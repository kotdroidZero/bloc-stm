// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_stm/cubit/counter_cubit.dart';
import 'package:bloc_stm/cubit/internet_cubit.dart';
import 'package:bloc_stm/presentation/screns/home_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) {
  // var cs1 = CounterState(counterValue: 1, wasIncremented: false);
  // var cs2 = CounterState(counterValue: 1, wasIncremented: false);

  runApp(MyApp(
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  final Connectivity connectivity;

  const MyApp({required this.connectivity, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<CounterCubit>(
          create: (BuildContext context) => CounterCubit(
            internetCubit: BlocProvider.of<InternetCubit>(context),
          ),
        )
      ],
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}

// class ShirtWidget extends LeafRenderObjectWidget {
//   final Color color;
//   const ShirtWidget({
//     required this.color,
//   });

//   @override
//   RenderObject createRenderObject(BuildContext context) {
//     return _ShirtRenderBox(color: color);
//   }

//   @override
//   void updateRenderObject(
//       BuildContext context, covariant _ShirtRenderBox renderObject) {
//     renderObject.color = color;
//   }
// }

// class _ShirtRenderBox extends RenderBox {
//   Color _color;

//   Color get color => _color;

//   set color(Color value) {
//     if (value == _color) return;

//     _color = value;
//     markNeedsPaint();
//   }

//   _ShirtRenderBox({
//     required Color color,
//   }) : _color = color;
// }
