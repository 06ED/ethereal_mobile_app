part of 'wardrobe_bloc.dart';

@immutable
abstract class WardrobeState {}

class WardrobeInitial extends WardrobeState {}

class LoadedState extends WardrobeState {
  final List<Clothes> clothes;

  LoadedState(this.clothes);
}
