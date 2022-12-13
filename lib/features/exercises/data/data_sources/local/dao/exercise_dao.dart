import 'package:floor/floor.dart';

import '../../../models/exercise.dart';

@dao
abstract class ExerciseDao {
  
  @Insert()
  Future<void> insertExercise(ExerciseModel exercise);
  
  @delete
  Future<void> deleteExercise(ExerciseModel exerciseModel);
  
  @Query('SELECT * FROM exercise')
  Future<List<ExerciseModel>> getExercise();
}