part of 'local_exercise_bloc.dart';

@immutable
abstract class LocalExerciseState extends Equatable {
  final List<ExerciseEntity>? exercises;

  const LocalExerciseState({this.exercises});

  @override
  List<Object> get props => [exercises ?? []];
}

interface class LocalExerciseLoading extends LocalExerciseState {
  const LocalExerciseLoading();
}

interface class LocalExerciseLoaded extends LocalExerciseState {
  const LocalExerciseLoaded(List<ExerciseEntity> exercise)
      : super(exercises: exercise);
}
