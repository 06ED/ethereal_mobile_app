part of 'wall_bloc.dart';

@immutable
abstract class WallState {}

class WallInitial extends WallState {}

class WallInitState extends WallState {
  final List<Look> looks;

  WallInitState({required this.looks});
}

class AddedToFavoriteState extends WallState {}
