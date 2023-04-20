part of 'change_data_bloc.dart';

@immutable
abstract class ChangeDataState {}

class ChangeDataInitial extends ChangeDataState {}

class UserChangedDataState extends ChangeDataState {}
