// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:chat_app/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthSignInEvent>(
      (event, emit) async {
        final userCredentials =
            await authRepository.registerUser(event.email, event.password);

        if (userCredentials.toString().contains('ERROR')) {
          return emit(
            AuthErrorState(
              message: userCredentials.toString().split(': ')[1],
            ),
          );
        }

        return emit(
          AuthSignUpState(
            message: 'User created succesfully',
          ),
        );
      },
    );
    on<AuthSignUpEvent>((event, emit) async {
      try {
        final User? user =
            await authRepository.logInUser(event.email, event.password);

        if (user != null) {
          emit(AuthenticatedState(user: user));
        }
      } on FirebaseAuthException catch (error) {
        emit(
          AuthErrorState(
            message: error.message!,
          ),
        );
      }
    });
  }
}
