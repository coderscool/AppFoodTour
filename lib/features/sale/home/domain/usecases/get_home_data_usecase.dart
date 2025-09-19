import '../entities/dish.dart';
import '../entities/stat.dart';
import '../repositories/home_repository.dart';

class GetHomeDataUsecase {
  final HomeRepository repository;

  GetHomeDataUsecase(this.repository);

  Future<(List<Dish>, List<Stat>)> call(String id) async {
    final dishes = await repository.getDishes(id);
    final stats = await repository.getStats();
    return (dishes, stats);
  }
}