part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginUserState extends LoginState {
  final bool correct;

  LoginUserState({required this.correct});
}
