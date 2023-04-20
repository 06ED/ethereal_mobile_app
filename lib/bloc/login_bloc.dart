import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart';

import '../assets/constants.dart';
import '../entity/user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonTappedEvent>(_loginButtonEventHandler);
  }

  Future<void> _loginButtonEventHandler(LoginButtonTappedEvent event,
      Emitter emit) async {
    final client = Client();
    try {
      final response = await client.post(
          Uri.parse("$kDefaultServerApiUrl/login/"),
          headers: {"content-type": "application/json"},
          body: json.encode({"nickname": event.login, "password": event.password})
      );

      final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

      if (decodedResponse.containsKey("err")) {
        emit(LoginUserState(false));
        return;
      }

      final user = User.fromMap(decodedResponse);
      User.setCurrentUser(user);
    } finally {
      client.close();
    }
    emit(LoginUserState(true));
  }
}
