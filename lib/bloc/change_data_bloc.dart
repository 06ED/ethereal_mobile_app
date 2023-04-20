import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../entity/user.dart';

part 'change_data_event.dart';
part 'change_data_state.dart';

class ChangeDataBloc extends Bloc<ChangeDataEvent, ChangeDataState> {
  ChangeDataBloc() : super(ChangeDataInitial()) {
    on<ChangeDataButtonTappedEvent>(_changeDataButtonEventHandler);
  }

  Future<void> _changeDataButtonEventHandler(ChangeDataButtonTappedEvent event,
      Emitter emit) async {
    var user = await User.getCurrentUser();

    final client = http.Client();
    try {
      // TODO server logic
    } finally {
      client.close();
    }
    emit(UserChangedDataState());
  }
}
