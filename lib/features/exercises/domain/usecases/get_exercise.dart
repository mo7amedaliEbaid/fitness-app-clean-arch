
import '../../../../shared/resources/data_state.dart';
import '../../../../shared/usecase/usecase.dart';
import '../entities/exercise.dart';
import '../repository/exercise_repository.dart';

interface class GetExerciseUseCase implements UseCase<DataState<List<ExerciseEntity>>,void>{
  
  final ExerciseRepository _exerciseRepository;

  GetExerciseUseCase(this._exerciseRepository);
  
  @override
  Future<DataState<List<ExerciseEntity>>> call({void paramaters}) {
    return _exerciseRepository.getExercises();
  }
  
}