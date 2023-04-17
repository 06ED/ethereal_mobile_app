part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginButtonTappedEvent extends LoginEvent {
  final String text;

  LoginButtonTappedEvent(this.text);
}
