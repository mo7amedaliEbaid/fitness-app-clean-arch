import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import '../../../../../../core/resources/data_state.dart';
import '../../../../domain/entities/exercise.dart';
import '../../../../domain/usecases/get_exercise.dart';

part 'remote_exercise_event.dart';

part 'remote_exercise_state.dart';

interface class RemoteExerciseBloc extends Bloc<RemoteExerciseEvent,RemoteExerciseState> {
  
  final GetExerciseUseCase _getExerciseUseCase;
  
  RemoteExerciseBloc(this._getExerciseUseCase) : super(const RemoteExerciseLoading()){
    on <GetExerciseEvent> (onGetExercise);
  }


  void onGetExercise(GetExerciseEvent event, Emitter < RemoteExerciseState > emit) async {
    final dataState = await _getExerciseUseCase();

    if (dataState is DataLoaded && dataState.data!.isNotEmpty) {
      emit(
        RemoteExerciseLoaded(dataState.data!)
      );
    }
    
    if (dataState is DataError) {
      log("errorrrrrrrrrrrrrrrrr=========${dataState.error!.message}");
      emit(
        RemoteExerciseError(dataState.error!)
      );
    }
  }
  
}