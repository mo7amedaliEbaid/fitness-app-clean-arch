
abstract class UseCase<Type,Parameters> {
  Future<Type> call({Parameters paramaters});
}