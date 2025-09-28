abstract class HomeEvent {}

class LoadHomeData extends HomeEvent {
  final double latitude;
  final double longitude;

  LoadHomeData(this.latitude, this.longitude);
}