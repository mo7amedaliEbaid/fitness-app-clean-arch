
import 'package:floor/floor.dart';
import '../../models/exercise.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

import 'dao/exercise_dao.dart';
part 'app_database.g.dart';

@Database(version: 1, entities: [ExerciseModel])
abstract class AppDatabase extends FloorDatabase {
  ExerciseDao get exerciseDAO;
}