import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T ? data;
  final DioError ? error;

  const DataState({this.data, this.error});
}

interface class DataLoaded<T> extends DataState<T> {
  const DataLoaded(T data) : super(data: data);
}

interface class DataError<T> extends DataState<T> {
  const DataError(DioError error) : super(error: error);
}
