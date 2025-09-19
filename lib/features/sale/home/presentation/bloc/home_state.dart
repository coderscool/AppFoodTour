import '../../domain/entities/dish.dart';
import '../../domain/entities/stat.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Dish> dishes;
  final List<Stat> stats;

  HomeLoaded({required this.dishes, required this.stats});
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
