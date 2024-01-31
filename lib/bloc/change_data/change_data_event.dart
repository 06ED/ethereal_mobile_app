part of 'change_data_bloc.dart';

@immutable
abstract class ChangeDataEvent {}

class ChangeDataButtonTappedEvent extends ChangeDataEvent {
  final String nickname;
  final String mail;

  ChangeDataButtonTappedEvent(this.nickname, this.mail);
}
