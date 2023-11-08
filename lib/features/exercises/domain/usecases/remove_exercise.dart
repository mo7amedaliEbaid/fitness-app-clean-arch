
import '../../../../shared/usecase/usecase.dart';
import '../entities/exercise.dart';
import '../repository/exercise_repository.dart';

interface class RemoveExerciseUseCase implements UseCase<void,ExerciseEntity>{
  
  final ExerciseRepository _articleRepository;

  RemoveExerciseUseCase(this._articleRepository);
  
  @override
  Future<void> call({ExerciseEntity ? paramaters}) {
    return _articleRepository.removeExercise(paramaters!);
  }
  
}