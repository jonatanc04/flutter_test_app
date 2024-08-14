import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/bloc/pizza_bloc.dart';
import 'package:flutter_test_app/models/pizza_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PizzaBloc()..add(LoadPizzaCounter()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'The Pizza Bloc',
        home: const MyHomePage(title: 'The Pizza Bloc'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: BlocBuilder<PizzaBloc, PizzaState>(
          builder: (context, state) {
            if (state is PizzaInitial) {
              return const CircularProgressIndicator(color: Colors.orange);
            }
            if (state is PizzaLoaded) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${state.pizzas.length}',
                      style: const TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          for (int i = 0; i < state.pizzas.length; i++)
                            Positioned(
                              left: random.nextInt(250).toDouble(),
                              top: random.nextInt(400).toDouble(),
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: state.pizzas[i].image,
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Text('Something went wrong!');
            }
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.orange[800],
            onPressed: () {
              context.read<PizzaBloc>().add(AddPizza(Pizza.pizzas[0]));
            },
            child: const Icon(Icons.local_pizza_outlined),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.orange[800],
            onPressed: () {
              context.read<PizzaBloc>().add(RemovePizza(Pizza.pizzas[0]));
            },
            child: const Icon(Icons.remove),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.orange[800],
            onPressed: () {
              context.read<PizzaBloc>().add(AddPizza(Pizza.pizzas[1]));
            },
            child: const Icon(Icons.local_pizza),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.orange[800],
            onPressed: () {
              context.read<PizzaBloc>().add(RemovePizza(Pizza.pizzas[1]));
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
