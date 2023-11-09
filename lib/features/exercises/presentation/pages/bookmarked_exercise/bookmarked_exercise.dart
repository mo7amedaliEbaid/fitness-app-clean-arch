import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../../../di/injection_container.dart';
import '../../../../../shared/responsive/responsive.dart';
import '../../../domain/entities/exercise.dart';
import 'package:fitness_app/config/configs.dart';
import '../../bloc/exercise/local/local_exercise_bloc.dart';
import '../../widgets/exercise_tile.dart';

class Bookmarks extends HookWidget {
  const Bookmarks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<LocalExerciseBloc>()..add(const GetSavedExercisesEvent()),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Builder(
        builder: (context) => Padding(
          padding: Space.hf(1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _onBackButtonTapped(context),
                  child: const Icon(Icons.arrow_back_ios)),
              const Text('Bookmarks'),
              Space.xf(5),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<LocalExerciseBloc, LocalExerciseState>(
      builder: (context, state) {
        if (state is LocalExerciseLoading) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (state is LocalExerciseLoaded) {
          return _buildArticlesList(state.exercises!);
        }
        return Container();
      },
    );
  }

  Widget _buildArticlesList(List<ExerciseEntity> exercises) {
    if (exercises.isEmpty) {
      return Center(
          child: Text(
        'NO SAVED EXERCISES',
        style: AppText.b1b,
      ));
    }

    return ListView.builder(
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        return ExerciseWidget(
          exercise: exercises[index],
          isRemovable: true,
          onRemove: (article) => _onRemoveArticle(context, article),
          onExercisePressed: (article) => _onArticlePressed(context, article),
        );
      },
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  void _onRemoveArticle(BuildContext context, ExerciseEntity article) {
    BlocProvider.of<LocalExerciseBloc>(context)
        .add(RemoveExerciseEvent(article));
  }

  void _onArticlePressed(BuildContext context, ExerciseEntity article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }
}
