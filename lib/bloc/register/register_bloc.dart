import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import '../../assets/constants.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<CreateUserEvent>((event, emit) async {
      final client = Client();
      try {
        await client.post(
          Uri.parse("$kDefaultServerApiUrl/register/"),
          headers: {"content-type": "application/json"},
          body: json.encode({
            "nickname": event.username,
            "password": event.password,
            "email": event.mail,
          }),
        );
        emit(UserRegisteredState());
      } finally {
        client.close();
      }
    });
  }
}
