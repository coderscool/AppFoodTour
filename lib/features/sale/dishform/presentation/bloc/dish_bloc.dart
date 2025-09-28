// presentation/bloc/dish_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/add_dish.dart';
import 'dish_event.dart';
import 'dish_state.dart';

class DishBloc extends Bloc<DishEvent, DishState> {
  final AddDish addDish;

  DishBloc(this.addDish) : super(DishInitial()) {
    on<AddDishRequested>((event, emit) async {
      emit(DishLoading());
      try {
        await addDish(event.dish);
        emit(DishSuccess());
      } catch (e) {
        emit(DishFailure(e.toString()));
      }
    });
  }
}
