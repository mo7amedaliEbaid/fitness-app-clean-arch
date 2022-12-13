
part of 'local_exercise_bloc.dart';

@immutable
abstract class LocalExerciseEvent extends Equatable {
  final ExerciseEntity ? exercise;

  const LocalExerciseEvent({this.exercise});

  @override
  List<Object> get props => [exercise!];
}

interface class GetSavedExercisesEvent extends LocalExerciseEvent {
  const GetSavedExercisesEvent();
}

interface class RemoveExerciseEvent extends LocalExerciseEvent {
  const RemoveExerciseEvent(ExerciseEntity exercise) : super(exercise: exercise);
}

interface class SaveExerciseEvent extends LocalExerciseEvent {
  const SaveExerciseEvent(ExerciseEntity exercise) : super(exercise: exercise);
}
