import 'package:bloc_estudos/home.dart';
import 'package:bloc_estudos/todo_bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized ();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          background: Colors.white,
          onBackground: Colors.black,
          primary: Color(0xFFE28DA9),
          onPrimary: Colors.black,
          secondary: Color(0xFFE1A2EC),
          onSecondary: Colors.white
        )
      ),
      home: BlocProvider<TodoBloc>(
        create: (context) => TodoBloc()..add(
          TodoStarted()
        ),
        child: const HomeScreen(),
      ),
   );
  }
}
