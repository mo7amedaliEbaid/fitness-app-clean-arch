

import '../../../../core/usecase/usecase.dart';
import '../entities/exercise.dart';
import '../repository/exercise_repository.dart';

interface class SaveExerciseUseCase implements UseCase<void,ExerciseEntity>{
  
  final ExerciseRepository _articleRepository;

  SaveExerciseUseCase(this._articleRepository);
  
  @override
  Future<void> call({ExerciseEntity ? paramaters}) {
    return _articleRepository.saveExercise(paramaters!);
  }
  
}