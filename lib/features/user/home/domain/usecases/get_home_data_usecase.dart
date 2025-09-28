import '../entities/near_store.dart';
import '../entities/trending_dish.dart';
import '../repositories/home_repository.dart';

class GetHomeDataUsecase {
  final HomeRepository repository;

  GetHomeDataUsecase(this.repository);

  Future<(List<TrendingDish>, List<NearStore>)> call(double latitude, double longitude) async {
    final dishes = await repository.getTrendingDishes();
    final stats = await repository.getNearStores(latitude, longitude);
    return (dishes, stats);
  }
}