part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginInitEvent extends LoginEvent {}

class LoginButtonTappedEvent extends LoginEvent {
  final String login;
  final String password;

  LoginButtonTappedEvent(this.login, this.password);
}
