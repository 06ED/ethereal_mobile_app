part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteInitState extends FavoriteState {
  final List<Look> looks;

  FavoriteInitState({required this.looks});
}
