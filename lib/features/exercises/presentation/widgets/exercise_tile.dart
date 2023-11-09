import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/shared/responsive/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/config/configs.dart';
import '../../domain/entities/exercise.dart';

class ExerciseWidget extends StatelessWidget {
  final ExerciseEntity? exercise;
  final bool? isRemovable;
  final void Function(ExerciseEntity exercise)? onRemove;
  final void Function(ExerciseEntity exercise)? onExercisePressed;

  const ExerciseWidget({
    Key? key,
    this.exercise,
    this.onExercisePressed,
    this.isRemovable = false,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: Card(
        elevation: 5,
        child: Container(
          padding: Space.all(),
          height: AppDimensions.normalize(70),
          child: isRemovable == false
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImage(context),
                    Responsive.isMobile(context)
                        ? Space.x!
                        : Responsive.isTablet(context)
                            ? Space.xf(1.5)
                            : Space.xf(8),
                    _buildNameAndDescription(),
                    _buildRemovableArea(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImage(context),
                    Space.x!,
                    _buildNameAndDescription(),
                    _buildRemovableArea(),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: exercise!.gifUrl!,
        imageBuilder: (context, imageProvider) => Container(
              width: AppDimensions.normalize(55),
              height: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: imageProvider, fit: BoxFit.contain)),
            ),
        progressIndicatorBuilder: (context, url, downloadProgress) => ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.normalize(12)),
              child: Container(
                width: AppDimensions.normalize(55),
                height: double.maxFinite,
                child: CupertinoActivityIndicator(),
                decoration: BoxDecoration(),
              ),
            ),
        errorWidget: (context, url, error) => Padding(
              padding: Space.all(),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(AppDimensions.normalize(12)),
                child: Container(
                  width: AppDimensions.normalize(55),
                  height: double.maxFinite,
                  child: Icon(Icons.error),
                ),
              ),
            ));
  }

  Widget _buildNameAndDescription() {
    return Expanded(
      child: Padding(
        padding: Space.vf(.4),
        child: Column(
          //  mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercise!.name ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.h3b?.copyWith(color: Colors.amber.shade900),
            ),
            Space.y!,
            Padding(
              padding: Space.vf(.3),
              child: FittedBox(
                child: Row(
                  children: [
                    Icon(
                      Icons.sports_gymnastics,
                      color: Colors.blue,
                      size: AppDimensions.normalize(10),
                    ),
                    Space.xf(.5),
                    Text(
                      "Equpment: ",
                      style: AppText.b2b,
                    ),
                    Space.xf(.5),
                    Text(
                      "${exercise!.equipment}" ?? '',
                      style: AppText.b1b?.copyWith(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),

            // Datetime
            Row(
              children: [
                Icon(
                  Icons.personal_injury,
                  color: Colors.blue,
                  size: AppDimensions.normalize(10),
                ),
                Space.xf(.5),
                Text(
                  "Body Part: ",
                  style: AppText.b2b,
                ),
                Space.xf(.5),
                Text(
                  "${exercise!.bodyPart}" ?? '',
                  style: AppText.b1b?.copyWith(color: Colors.blue.shade100),
                ),
              ],
            ),
            Space.yf(.2),
            FittedBox(
              child: Row(
                children: [
                  Icon(
                    Icons.person_search,
                    color: Colors.blue,
                    size: AppDimensions.normalize(10),
                  ),
                  Space.xf(.5),
                  Text(
                    "Secondary muscle: ",
                    style: AppText.b2b,
                  ),
                  Space.xf(.5),
                  Text(
                    "${exercise!.secondaryMuscles}",
                    style: AppText.b1b?.copyWith(color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRemovableArea() {
    if (isRemovable!) {
      return GestureDetector(
        onTap: _onRemove,
        child: Padding(
          padding: Space.v!,
          child: Icon(Icons.remove_circle_outline, color: Colors.red),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  void _onTap() {
    if (onExercisePressed != null) {
      onExercisePressed!(exercise!);
    }
  }

  void _onRemove() {
    if (onRemove != null) {
      onRemove!(exercise!);
    }
  }
}
