// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

enum AuthenticationState { unknown, authenticated, unauthenticated }

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthUnathenticatedState extends AuthState {}

class AuthErrorState extends AuthState {
  final String message;
  AuthErrorState({
    required this.message,
  });
}

class AuthSignUpState extends AuthState {
  final String message;
  AuthSignUpState({
    required this.message,
  });
}
