part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class CreateUserEvent extends RegisterEvent {
  final String username;
  final String mail;
  final String password;

  CreateUserEvent({
    required this.username,
    required this.mail,
    required this.password,
  });
}
