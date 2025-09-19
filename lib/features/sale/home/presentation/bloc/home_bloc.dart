import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_home_data_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeDataUsecase getHomeData;

  HomeBloc(this.getHomeData) : super(HomeInitial()) {
    on<LoadHomeData>((event, emit) async {
      emit(HomeLoading());
      try {
        final (dishes, stats) = await getHomeData(event.id);
        emit(HomeLoaded(dishes: dishes, stats: stats));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });
  }
}
