part of 'get_clothes_bloc.dart';

@immutable
abstract class GetClothesEvent {}

class GetClothesInitEvent extends GetClothesEvent {}

class GetClothesParamsEvent extends GetClothesEvent {
  final ClothesSeason season;
  final ClothesType type;

  GetClothesParamsEvent({required this.season, required this.type});
}

class SetClothesParamsEvent extends GetClothesEvent {
  final Clothes clothes;

  SetClothesParamsEvent({required this.clothes});
}
