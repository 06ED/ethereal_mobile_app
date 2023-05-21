part of 'wall_bloc.dart';

@immutable
abstract class WallEvent {}

class WallInitEvent extends WallEvent {}

class WallAddLookToFavoriteEvent extends WallEvent {
  final Look look;

  WallAddLookToFavoriteEvent({required this.look});
}
