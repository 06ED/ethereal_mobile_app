part of 'custom_looks_bloc.dart';

@immutable
abstract class CustomLooksEvent {}

class CustomLooksInitEvent extends CustomLooksEvent {}

class CustomLooksAddToFavoriteEvent extends CustomLooksEvent {
  final Look look;

  CustomLooksAddToFavoriteEvent({required this.look});
}
