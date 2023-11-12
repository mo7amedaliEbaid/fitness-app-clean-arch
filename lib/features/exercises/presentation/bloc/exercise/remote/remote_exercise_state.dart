part of 'remote_exercise_bloc.dart';

@immutable
abstract class RemoteExerciseState extends Equatable {
  final List<ExerciseEntity>? exercises;
  final DioException? error;

  const RemoteExerciseState({this.exercises, this.error});

  @override
  List<Object> get props => [exercises ?? [], error ?? ''];
}

interface class RemoteExerciseLoading extends RemoteExerciseState {
  const RemoteExerciseLoading();
}

interface class RemoteExerciseLoaded extends RemoteExerciseState {
  const RemoteExerciseLoaded(List<ExerciseEntity> exercise)
      : super(exercises: exercise);
}

interface class RemoteExerciseError extends RemoteExerciseState {
  const RemoteExerciseError(DioException error) : super(error: error);
}
