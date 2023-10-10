import 'package:flutter/material.dart';
import '../features/articles/domain/entities/exercise.dart';
import '../features/articles/presentation/pages/bookmarked_exercise/bookmarked_exercise.dart';
import '../features/articles/presentation/pages/exercise_details/exercise_details.dart';
import '../features/articles/presentation/pages/home/exercises.dart';


sealed class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const ExercisesPage());

      case '/ExerciseDetails':
        return _materialRoute(ExerciseDetailsPage(exercise: settings.arguments as ExerciseEntity));

      case '/Bookmarks':
        return _materialRoute(const Bookmarks());
        
      default:
        return _materialRoute(const ExercisesPage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
