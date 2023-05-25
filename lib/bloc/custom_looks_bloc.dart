import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ethereal_app/entity/look.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

import '../assets/constants.dart';
import '../entity/user.dart';

part 'custom_looks_event.dart';

part 'custom_looks_state.dart';

class CustomLooksBloc extends Bloc<CustomLooksEvent, CustomLooksState> {
  static const _translations = {
    "casual": "Казуальный",
    "business": "Бизнесс",
    "sportswear": "Спортивный"
  };

  CustomLooksBloc() : super(CustomLooksInitial()) {
    on<CustomLooksInitEvent>(_onInit);
    on<CustomLooksAddToFavoriteEvent>(_addCustomLookToFavorite);
  }

  Future<void> _onInit(CustomLooksInitEvent event, Emitter emit) async {
    final client = http.Client();
    final user = await User.getCurrentUser();
    final looksList = <String, List<Look>>{};

    try {
      final response = await client.post(
          Uri.parse("$kDefaultServerApiUrl/getCustomLooks/"),
          headers: {"content-type": "application/json"},
          body: jsonEncode({"user_id": user?.id}));
      final decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map;

      for (var entry in decodedResponse.entries) {
        final looks = <Look>[];
        for (var look in entry.value) {
          looks.add(Look.getFrom(look));
        }
        looksList.addEntries([MapEntry(_translations[entry.key]!, looks)]);
      }
    } finally {
      client.close();
    }

    emit(CustomLooksInitState(looks: looksList));
  }

  Future<void> _addCustomLookToFavorite(
      CustomLooksAddToFavoriteEvent event, Emitter emit) async {
    final client = http.Client();
    final user = await User.getCurrentUser();

    try {
      await client.post(
          Uri.parse("$kDefaultServerApiUrl/addToFavorite/"),
          headers: {"content-type": "application/json"},
          body: jsonEncode({"user_id": user?.id, "look_id": event.look.id}));
    } finally {
      client.close();
    }

    emit(AddedToFavoriteCustomLookState());
  }
}
