// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ExerciseDao? _exerciseDAOInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `exercise` (`id` INTEGER, `equipment` TEXT, `name` TEXT, `instruction1` TEXT, `secondaryMuscles` TEXT, `gifUrl` TEXT, `bodyPart` TEXT, `instruction2` TEXT, `instruction3` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ExerciseDao get exerciseDAO {
    return _exerciseDAOInstance ??= _$ExerciseDao(database, changeListener);
  }
}

class _$ExerciseDao extends ExerciseDao {
  _$ExerciseDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _exerciseModelInsertionAdapter = InsertionAdapter(
            database,
            'exercise',
            (ExerciseModel item) => <String, Object?>{
                  'id': item.id,
                  'equipment': item.equipment,
                  'name': item.name,
                  'instruction1': item.instruction1,
                  'secondaryMuscles': item.secondaryMuscles,
                  'gifUrl': item.gifUrl,
                  'bodyPart': item.bodyPart,
                  'instruction2': item.instruction2,
                  'instruction3': item.instruction3
                }),
        _exerciseModelDeletionAdapter = DeletionAdapter(
            database,
            'exercise',
            ['id'],
            (ExerciseModel item) => <String, Object?>{
                  'id': item.id,
                  'equipment': item.equipment,
                  'name': item.name,
                  'instruction1': item.instruction1,
                  'secondaryMuscles': item.secondaryMuscles,
                  'gifUrl': item.gifUrl,
                  'bodyPart': item.bodyPart,
                  'instruction2': item.instruction2,
                  'instruction3': item.instruction3
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ExerciseModel> _exerciseModelInsertionAdapter;

  final DeletionAdapter<ExerciseModel> _exerciseModelDeletionAdapter;

  @override
  Future<List<ExerciseModel>> getExercise() async {
    return _queryAdapter.queryList('SELECT * FROM exercise',
        mapper: (Map<String, Object?> row) => ExerciseModel(
            id: row['id'] as int?,
            equipment: row['equipment'] as String?,
            name: row['name'] as String?,
            instruction1: row['instruction1'] as String?,
            secondaryMuscles: row['secondaryMuscles'] as String?,
            gifUrl: row['gifUrl'] as String?,
            bodyPart: row['bodyPart'] as String?,
            instruction2: row['instruction2'] as String?,
            instruction3: row['instruction3'] as String?));
  }

  @override
  Future<void> insertExercise(ExerciseModel exercise) async {
    await _exerciseModelInsertionAdapter.insert(
        exercise, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteExercise(ExerciseModel exerciseModel) async {
    await _exerciseModelDeletionAdapter.delete(exerciseModel);
  }
}
