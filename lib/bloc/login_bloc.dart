import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>(_loginEventHandler);
    on<LoginButtonTappedEvent>(_loginButtonEventHandler);
  }

  Future<void> _loginEventHandler(LoginEvent event, Emitter emit) async {
    emit(LoginInitial());
  }

  Future<void> _loginButtonEventHandler(LoginButtonTappedEvent event,
      Emitter emit) async {
    print(event.login);
    print(event.password);
    // TODO server logic
    emit(LoginUserState(true));
  }
}
