

import '../../../../core/usecase/usecase.dart';
import '../entities/exercise.dart';
import '../repository/exercise_repository.dart';



interface class GetBookmarks implements UseCase<List<ExerciseEntity>,void>{
  
  final ExerciseRepository _exerciseRepository;

  GetBookmarks(this._exerciseRepository);
  
  @override
  Future<List<ExerciseEntity>> call({void paramaters}) {
    return _exerciseRepository.getBookmarks();
  }
  
}