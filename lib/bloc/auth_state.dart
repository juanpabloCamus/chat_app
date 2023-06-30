part of 'auth_bloc.dart';

enum AuthenticationState { unknown, authenticated, unauthenticated }

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthUnathenticatedState extends AuthState {}
