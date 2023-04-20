part of 'get_clothes_bloc.dart';

@immutable
abstract class GetClothesState {}

class GetClothesInitial extends GetClothesState {}

class GetClothesInitState extends GetClothesState {
  final List<ClothesType> types;
  final List<ClothesSeason> seasons;

  GetClothesInitState({required this.types, required this.seasons});
}

class GetClothesListState extends GetClothesState {
  final List<Clothes> clothes;

  GetClothesListState({required this.clothes});
}

class SetClothesState extends GetClothesState {}
