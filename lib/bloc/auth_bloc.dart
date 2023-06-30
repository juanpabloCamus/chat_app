// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:chat_app/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthSignInEvent>((event, emit) async {
      final user =
          await authRepository.registerUser(event.email, event.password);
    });
  }
}
