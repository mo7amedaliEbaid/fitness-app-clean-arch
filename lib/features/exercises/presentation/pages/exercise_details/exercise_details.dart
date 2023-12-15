import 'package:fitness_app/shared/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fitness_app/config/configs.dart';
import '../../../../../di/injection_container.dart';
import '../../../domain/entities/exercise.dart';
import '../../bloc/exercise/local/local_exercise_bloc.dart';

class ExerciseDetailsPage extends HookWidget {
  final ExerciseEntity? exercise;

  const ExerciseDetailsPage({Key? key, this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalExerciseBloc>(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text("Exercise Details"),
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onBackButtonTapped(context),
          child: Padding(
            padding: Space.h1!,
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Builder(builder: (context) {
        return Container(
          margin: EdgeInsets.symmetric(
              horizontal: AppDimensions.normalize(10),
              vertical: AppDimensions.normalize(15)),
          child: Column(
            children: [
              Space.top!,
              _buildExcerciseTitleandEquip(),
              Space.y!,
              _buildExerciseGif(),
              _buildExerciseInstructions(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildExcerciseTitleandEquip() {
    return Padding(
      padding: Space.h1!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(exercise!.name!, style: AppText.h3b),
              Space.y!,
              Row(
                children: [
                  Icon(Icons.sports_gymnastics,
                      color: Colors.blue, size: AppDimensions.normalize(7)),
                  Space.x!,
                  Text(
                    exercise!.equipment!,
                    style: AppText.l1b,
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.personal_injury,
                      color: Colors.blue, size: AppDimensions.normalize(7)),
                  Space.x!,
                  Text(
                    exercise!.bodyPart!,
                    style: AppText.l1b,
                  ),
                ],
              ),
              Space.y!,
              Row(
                children: [
                  Icon(Icons.person_search,
                      color: Colors.blue, size: AppDimensions.normalize(7)),
                  Space.x!,
                  Text(
                    exercise!.secondaryMuscles!,
                    style: AppText.l1b,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseGif() {
    return Container(
      width: double.maxFinite,
      height: AppDimensions.normalize(90),
      margin: Space.v,
      child: Image.network(
        exercise!.gifUrl!,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildExerciseInstructions() {
    return Padding(
      padding: Space.all(.8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Instructions",
            style: AppText.h3b?.copyWith(color: Colors.red),
          ),
          Space.y1!,
          Text(
            '1- ${exercise!.instruction1 ?? ''}\n\n2- ${exercise!.instruction2 ?? ''}\n\n3- ${exercise!.instruction3 ?? ''}',
            style: AppText.b1b,
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Builder(
      builder: (context) => FloatingActionButton(
        onPressed: () => _onFloatingActionButtonPressed(context),
        child: const Icon(Icons.bookmark),
      ),
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  void _onFloatingActionButtonPressed(BuildContext context) {
    BlocProvider.of<LocalExerciseBloc>(context)
        .add(SaveExerciseEvent(exercise!));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Exercise saved successfully.'),
      ),
    );
  }
}
