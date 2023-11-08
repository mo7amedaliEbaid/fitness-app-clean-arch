import 'package:fitness_app/theme_bloc/theme_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../features/exercises/data/data_sources/local/app_database.dart';
import '../features/exercises/data/data_sources/remote/exercises_api_service.dart';
import '../features/exercises/data/repository/exercise_repo_impl.dart';
import '../features/exercises/domain/repository/exercise_repository.dart';
import '../features/exercises/domain/usecases/get_exercise.dart';
import '../features/exercises/domain/usecases/get_bookmarks.dart';
import '../features/exercises/domain/usecases/remove_exercise.dart';
import '../features/exercises/domain/usecases/save_exercise.dart';
import '../features/exercises/presentation/bloc/exercise/local/local_exercise_bloc.dart';
import '../features/exercises/presentation/bloc/exercise/remote/remote_exercise_bloc.dart';


final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);
  
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<ExerciseApiService>(ExerciseApiService(sl()));

  sl.registerSingleton<ExerciseRepository>(
    ExerciseRepoImpl(sl(),sl())
  );
  
  //UseCases
  sl.registerSingleton<GetExerciseUseCase>(
    GetExerciseUseCase(sl())
  );

  sl.registerSingleton<GetBookmarks>(
    GetBookmarks(sl())
  );

  sl.registerSingleton<SaveExerciseUseCase>(
    SaveExerciseUseCase(sl())
  );
  
  sl.registerSingleton<RemoveExerciseUseCase>(
    RemoveExerciseUseCase(sl())
  );


  //Blocs
  sl.registerFactory<RemoteExerciseBloc>(
    ()=> RemoteExerciseBloc(sl())
  );

  sl.registerFactory<LocalExerciseBloc>(
    ()=> LocalExerciseBloc(sl(),sl(),sl())
  );

  sl.registerFactory<ThemeBloc>(
          ()=> ThemeBloc()
  );


}