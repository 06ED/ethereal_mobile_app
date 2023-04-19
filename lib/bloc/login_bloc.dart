import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

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
    var client = Client();
    log(Uri.parse(kDefaultServerApiUrl).toString());
    try {
      var response = await client.post(
        Uri.parse(kDefaultServerApiUrl),
        body: {
          "username": event.login,
          "password": event.password
        }
      );
      log(utf8.decode(response.bodyBytes));
      log(response.body);
      log(response.isRedirect.toString());
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

      if (decodedResponse.containsKey("err")) {
        emit(LoginUserState(false));
        return;
      }
      var user = User.fromMap(decodedResponse);
      User.setCurrentUser(user);
    } finally {
      client.close();
    }
    emit(LoginUserState(true));
  }
}
