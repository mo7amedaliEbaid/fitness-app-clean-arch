import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../../domain/entities/exercise.dart';
import '../../../../domain/usecases/get_bookmarks.dart';
import '../../../../domain/usecases/remove_exercise.dart';
import '../../../../domain/usecases/save_exercise.dart';

part 'local_exercise_event.dart';

part 'local_exercise_state.dart';

interface class LocalExerciseBloc extends Bloc<LocalExerciseEvent,LocalExerciseState> {
  final GetBookmarks _getSavedExerciseUseCase;
  final SaveExerciseUseCase _saveExerciseUseCase;
  final RemoveExerciseUseCase _removeExerciseUseCase;

  LocalExerciseBloc(
    this._getSavedExerciseUseCase,
    this._saveExerciseUseCase,
    this._removeExerciseUseCase
  ) : super(const LocalExerciseLoading()){
    on <GetSavedExercisesEvent> (onGetSavedExercises);
    on <RemoveExerciseEvent> (onRemoveExercise);
    on <SaveExerciseEvent> (onSaveExercise);
  }


  void onGetSavedExercises(GetSavedExercisesEvent event,Emitter<LocalExerciseState> emit) async {
    final articles = await _getSavedExerciseUseCase();
    emit(LocalExerciseLoaded(articles));
  }
  
  void onRemoveExercise(RemoveExerciseEvent removeArticle,Emitter<LocalExerciseState> emit) async {
    await _removeExerciseUseCase(paramaters: removeArticle.exercise);
    final articles = await _getSavedExerciseUseCase();
    emit(LocalExerciseLoaded(articles));
  }

  void onSaveExercise(SaveExerciseEvent saveArticle,Emitter<LocalExerciseState> emit) async {
    await _saveExerciseUseCase(paramaters: saveArticle.exercise);
    final articles = await _getSavedExerciseUseCase();
    emit(LocalExerciseLoaded(articles));
  }
}