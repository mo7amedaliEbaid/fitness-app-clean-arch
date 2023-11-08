import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../shared/consts/consts.dart';
import '../../../../shared/resources/data_state.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/repository/exercise_repository.dart';
import '../data_sources/local/app_database.dart';
import '../data_sources/remote/exercises_api_service.dart';
import '../models/exercise.dart';

interface class ExerciseRepoImpl implements ExerciseRepository {
  final ExerciseApiService _exerciseApiService;
  final AppDatabase _appDatabase;
  ExerciseRepoImpl(this._exerciseApiService,this._appDatabase);
  
  @override
  Future<DataState<List<ExerciseModel>>> getExercises() async {
   try {
    final httpResponse = await _exerciseApiService.getExercises(
      apiKey:APPCONSTS.APIKEY,
    );

    if (httpResponse.response.statusCode == HttpStatus.ok) {
      return DataLoaded(httpResponse.data);
    } else {
      return DataError(
        DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioErrorType.badResponse,
          requestOptions: httpResponse.response.requestOptions
        )
      );
    }
   } on DioError catch(e){
    return DataError(e);
   }
  }

  @override
  Future<List<ExerciseModel>> getBookmarks() async {
    return _appDatabase.exerciseDAO.getExercise();
  }

  @override
  Future<void> removeExercise(ExerciseEntity article) {
    return _appDatabase.exerciseDAO.deleteExercise(ExerciseModel.fromEntity(article));
  }

  @override
  Future<void> saveExercise(ExerciseEntity article) {
    return _appDatabase.exerciseDAO.insertExercise(ExerciseModel.fromEntity(article));
  }
  
}