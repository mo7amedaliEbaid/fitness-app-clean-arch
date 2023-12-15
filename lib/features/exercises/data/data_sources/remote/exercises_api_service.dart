import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../../shared/consts/consts.dart';
import '../../models/exercise.dart';
part 'exercises_api_service.g.dart';

@RestApi(baseUrl:APPCONSTS.BASEURL)
abstract class ExerciseApiService {
 factory ExerciseApiService(Dio dio) = _ExerciseApiService;
  
  @GET('/exercises')
  Future<HttpResponse<List<ExerciseModel>>> getExercises({
    @Header("X-RapidAPI-Key") String ? apiKey,
    @Query("limit") String? limit,
  });
}