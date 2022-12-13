import 'package:equatable/equatable.dart';

 class ExerciseEntity extends Equatable{
  final int? id;
  final String? equipment;
  final String? name;
  final String? instruction1;
  final String? secondaryMuscles;
  final String? gifUrl;
  final String? bodyPart;
  final String? instruction2;
  final String? instruction3;

  const ExerciseEntity({
    this.id,
    this.equipment,
    this.name,
    this.instruction1,
    this.secondaryMuscles,
    this.gifUrl,
    this.bodyPart,
    this.instruction2,
    this.instruction3,
  });

  @override
  List < Object ? > get props {
    return [
      id,
      equipment,
      name,
      instruction1,
      secondaryMuscles,
      gifUrl,
      bodyPart,
      instruction2,
      instruction3,
    ];
  }
}