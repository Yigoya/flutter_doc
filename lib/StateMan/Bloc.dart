// counter_bloc.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {
  final int ammount;
  IncrementEvent(this.ammount);
}

class DecrementEvent extends CounterEvent {}

// States
abstract class CounterState {}

class CounterInitialState extends CounterState {
  final int count;

  CounterInitialState(this.count);
}

// BLoC
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  int _count = 0;

  CounterBloc() : super(CounterInitialState(0)) {
    on<IncrementEvent>(
      (event, emit) {
        _count++;
        emit(CounterInitialState(event.ammount));
      },
    );
    on<DecrementEvent>(
      (event, emit) {
        _count--;
        emit(CounterInitialState(_count));
      },
    );
  }

  // @override
  // Stream<CounterState> mapEventToState(CounterEvent event) async* {
  //   if (event is IncrementEvent) {
  //     _count++;
  //   } else if (event is DecrementEvent) {
  //     _count--;
  //   }

  //   yield CounterInitialState(_count);
  // }
}

// counter_widget.dart

class CounterWidgetBloc extends StatelessWidget {
  const CounterWidgetBloc({super.key});

  @override
  Widget build(BuildContext context) {
    final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('BLoC State Management'),
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            if (state is CounterInitialState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Count: ${state.count}',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () => counterBloc.add(IncrementEvent(4)),
                        child: const Text('Increment'),
                      ),
                      ElevatedButton(
                        onPressed: () => counterBloc.add(
                            DecrementEvent()), // Make sure you handle this event
                        child: const Text('Decrement'),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return const Text('Error in state management');
            }
          },
        ),
      ),
    );
  }
}
