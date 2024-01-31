part of 'custom_looks_bloc.dart';

@immutable
abstract class CustomLooksState {}

class CustomLooksInitial extends CustomLooksState {}

class CustomLooksInitState extends CustomLooksState {
  final Map<String, List<Look>> looks;

  CustomLooksInitState({required this.looks});
}

class AddedToFavoriteCustomLookState extends CustomLooksState {}
