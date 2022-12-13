part of 'remote_exercise_bloc.dart';

@immutable
abstract class RemoteExerciseEvent {
  const RemoteExerciseEvent();
}

interface class GetExerciseEvent extends RemoteExerciseEvent {
  const GetExerciseEvent();
}