import 'package:floor/floor.dart';
import '../../../../core/consts/consts.dart';
import '../../domain/entities/exercise.dart';

@Entity(tableName: 'exercise', primaryKeys: ['id'])
interface class ExerciseModel extends ExerciseEntity {
  const ExerciseModel({
    int? id,
    String? equipment,
    String? name,
    String? instruction1,
    String? secondaryMuscles,
    String? gifUrl,
    String? bodyPart,
    String? instruction2,
    String? instruction3,
  }) : super(
          id: id,
    equipment: equipment,
          name: name,
    instruction1: instruction1,
    secondaryMuscles: secondaryMuscles,
    gifUrl: gifUrl,
    bodyPart: bodyPart,
    instruction2: instruction2,
    instruction3: instruction3,
        );

  factory ExerciseModel.fromJson(Map<String, dynamic> map) {
    return ExerciseModel(
      equipment: map['equipment'] ?? "",
      name: map['name'] ?? "",
      instruction1: map['instructions'][0] ?? "",
      secondaryMuscles: map['secondaryMuscles'][0] ?? "",
      gifUrl: map['gifUrl'] != null && map['gifUrl'] != ""
          ? map['gifUrl']
          : APPCONSTS.kDefaultImage,
      bodyPart: map['bodyPart'] ?? "",
      instruction2: map['instructions'][1] ?? "",
      instruction3: map['instructions'][2] ?? "",
    );
  }

  factory ExerciseModel.fromEntity(ExerciseEntity entity) {
    return ExerciseModel(
        id: entity.id,
        equipment: entity.equipment,
        name: entity.name,
        instruction1: entity.instruction1,
        secondaryMuscles: entity.secondaryMuscles,
        gifUrl: entity.gifUrl,
        bodyPart: entity.bodyPart,
        instruction2: entity.instruction2,
        instruction3: entity.instruction3,
    );
  }
}
