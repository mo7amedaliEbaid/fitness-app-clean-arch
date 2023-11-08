
import '../../../../shared/resources/data_state.dart';
import '../entities/exercise.dart';

abstract class ExerciseRepository {
  // API methods
  Future<DataState<List<ExerciseEntity>>> getExercises();

  // Database methods
  Future < List < ExerciseEntity >> getBookmarks();

  Future < void > saveExercise(ExerciseEntity exercise);

  Future < void > removeExercise(ExerciseEntity exercise);
}