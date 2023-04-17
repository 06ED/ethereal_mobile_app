part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginButtonTappedEvent extends LoginEvent {
  final String login;
  final String password;

  LoginButtonTappedEvent(this.login, this.password);
}
