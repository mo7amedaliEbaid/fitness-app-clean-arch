import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/routes.dart';
import '../di/injection_container.dart';
import '../features/exercises/presentation/bloc/exercise/remote/remote_exercise_bloc.dart';
import '../features/exercises/presentation/pages/home/exercises.dart';
import '../shared/theme_bloc/theme_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RemoteExerciseBloc>(
            create: (context) => sl()..add(const GetExerciseEvent())),

        BlocProvider<ThemeBloc>(
          create: (context) => sl()..add(InitialThemeSetEvent()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: state,
              onGenerateRoute: AppRoutes.onGenerateRoutes,
              home: const ExercisesPage());
        },
      ),
    );
  }
}