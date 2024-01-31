part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent {}

class FavoriteInitEvent extends FavoriteEvent {}

class FavoriteRemoveEvent extends FavoriteEvent {
  final Look look;

  FavoriteRemoveEvent({required this.look});
}
