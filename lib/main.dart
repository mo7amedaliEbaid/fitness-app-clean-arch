import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/config/app_theme.dart'as theme;

import 'config/routes.dart';
import 'features/exercises/presentation/bloc/exercise/remote/remote_exercise_bloc.dart';
import 'features/exercises/presentation/pages/home/exercises.dart';
import 'di/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider<RemoteExerciseBloc>(
      create: (context) => sl()..add(const GetExerciseEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme.themeDark,
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: const ExercisesPage()
      ),
    );
  }
}

