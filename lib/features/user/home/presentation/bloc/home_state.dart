import 'package:appfoodtour/features/user/home/domain/entities/near_store.dart';

import '../../domain/entities/trending_dish.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<TrendingDish> dishes;
  final List<NearStore> stores;

  HomeLoaded({required this.dishes, required this.stores});
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}