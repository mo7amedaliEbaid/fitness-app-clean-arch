import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/config/configs.dart';
import 'package:fitness_app/config/app_theme.dart' as theme;
import '../../../../../config/app.dart';
import '../../../../../shared/responsive/responsive.dart';
import '../../../../../shared/theme_bloc/theme_bloc.dart';
import '../../../domain/entities/exercise.dart';
import '../../bloc/exercise/remote/remote_exercise_bloc.dart';
import '../../widgets/exercise_tile.dart';

class ExercisesPage extends StatelessWidget {
  const ExercisesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(context),
    );
  }

  _buildAppbar(BuildContext context) {
    return AppBar(
      actions: [
        BlocBuilder<ThemeBloc, ThemeData>(
          builder: (context, themeData) {
            return CupertinoSwitch(
                value: themeData == theme.themeLight,
                onChanged: (bool val) {
                  BlocProvider.of<ThemeBloc>(context).add(ThemeSwitchEvent());
                });
          },
        ),
      ],
      title: Padding(
        padding: Space.hf(1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Exercises',
            ),
            GestureDetector(
              onTap: () => _onShowBookmarksViewTapped(context),
              child: Padding(
                padding: Space.h1!,
                child: Icon(
                  Icons.bookmark,
                  size: AppDimensions.normalize(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return BlocBuilder<RemoteExerciseBloc, RemoteExerciseState>(
      builder: (_, state) {
        if (state is RemoteExerciseLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is RemoteExerciseError) {
          return const Center(
              child: Icon(
            Icons.refresh,
            color: Colors.blue,
          ));
        }
        if (state is RemoteExerciseLoaded) {
          return !Responsive.isMobile(context)
              ? ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    scrollbars: false,
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,

                    },
                  ),
                  child: SingleChildScrollView(


                    child: Wrap(
                      spacing: AppDimensions.normalize(1),
                      // Horizontal spacing between items
                      runSpacing: AppDimensions.normalize(1),
                      // Vertical spacing between lines of items
                      children: state.exercises!.map((exercise) {
                        return Padding(
                          padding: Space.all(.5, .2),
                          child: ExerciseWidget(
                            exercise: exercise,
                            onExercisePressed: (article) =>
                                _onArticlePressed(context, article),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )
              : ListView.builder(
                  padding: Space.vf(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: Space.all(.5, .2),
                      child: ExerciseWidget(
                        exercise: state.exercises![index],
                        onExercisePressed: (article) =>
                            _onArticlePressed(context, article),
                      ),
                    );
                  },
                  itemCount: state.exercises!.length,
                );
        }
        return const SizedBox.shrink();
      },
    );
  }

  void _onArticlePressed(BuildContext context, ExerciseEntity article) {
    Navigator.pushNamed(context, '/ExerciseDetails', arguments: article);
  }

  void _onShowBookmarksViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/Bookmarks');
  }
}
