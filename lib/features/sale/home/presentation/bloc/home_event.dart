abstract class HomeEvent {}

class LoadHomeData extends HomeEvent {
  final String id;

  LoadHomeData(this.id);
}
