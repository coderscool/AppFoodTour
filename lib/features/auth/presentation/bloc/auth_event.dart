abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  LoginEvent(this.username, this.password);
}

class RegisterSellerEvent extends AuthEvent {
  final String username;
  final String password;
  final String name;
  final String address;
  final String phone;
  final String nation;
  final int startTime;
  final int endTime;
  final String imagePath;

  RegisterSellerEvent({
    required this.username,
    required this.password,
    required this.name,
    required this.address,
    required this.phone,
    required this.nation,
    required this.startTime,
    required this.endTime,
    required this.imagePath,
  });
}
