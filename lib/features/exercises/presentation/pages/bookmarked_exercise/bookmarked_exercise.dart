import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fitness_app/config/app_typography.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/exercise.dart';

import '../../bloc/exercise/local/local_exercise_bloc.dart';
import '../../widgets/exercise_tile.dart';

class Bookmarks extends HookWidget {
  const Bookmarks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalExerciseBloc>()..add(const GetSavedExercisesEvent()),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onBackButtonTapped(context),
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      title:
          const Text('Bookmarks'),
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

  Widget _buildArticlesList(List<ExerciseEntity> articles) {
    if (articles.isEmpty) {
      return  Center(
          child: Text(
        'NO SAVED ARTICLES',style: AppText.b1b,
      ));
    }

    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return ExerciseWidget(
          exercise: articles[index],
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
    BlocProvider.of<LocalExerciseBloc>(context).add(RemoveExerciseEvent(article));
  }

  void _onArticlePressed(BuildContext context, ExerciseEntity article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }
}
