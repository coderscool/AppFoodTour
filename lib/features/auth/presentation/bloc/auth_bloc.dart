import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_seller_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterSellerUseCase registerSellerUseCase;

  AuthBloc(this.loginUseCase, this.registerSellerUseCase) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await loginUseCase(event.username, event.password);
        emit(Authenticated(user));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<RegisterSellerEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await registerSellerUseCase(
          event.username,
          event.password,
          event.name,
          event.address,
          event.phone,
          event.nation,
          event.startTime,
          event.endTime,
          event.imagePath,
        );
        emit(RegisterSuccess());
      } catch(e) {
        emit(RegisterFailure(""));
      }
    });
  }
}
