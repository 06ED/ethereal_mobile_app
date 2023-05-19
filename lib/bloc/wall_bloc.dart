import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'wall_event.dart';
part 'wall_state.dart';

class WallBloc extends Bloc<WallEvent, WallState> {
  WallBloc() : super(WallInitial()) {
    on<WallEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
