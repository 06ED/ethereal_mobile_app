import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonTappedEvent>(_loginButtonEventHandler);
  }

  Future<void> _loginButtonEventHandler(LoginButtonTappedEvent event,
      Emitter emit) async {
    print(event.login);
    print(event.password);
    // TODO server logic
    emit(LoginUserState(true));
  }
}
