import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ethereal_app/entity/user.dart';
import 'package:meta/meta.dart';

import '../assets/constants.dart';
import '../entity/look.dart';

import 'package:http/http.dart' as http;

part 'wall_event.dart';

part 'wall_state.dart';

class WallBloc extends Bloc<WallEvent, WallState> {
  WallBloc() : super(WallInitial()) {
    on<WallInitEvent>(_onInit);
    on<WallAddLookToFavoriteEvent>(_onAddToFavorite);
  }

  Future<void> _onInit(WallInitEvent event, Emitter emit) async {
    final client = http.Client();
    final user = await User.getCurrentUser();
    final looksList = <Look>[];

    try {
      final response = await client.post(
          Uri.parse("$kDefaultServerApiUrl/getLooks/"),
          headers: {"content-type": "application/json"},
          body: jsonEncode({"user_id": user?.id}));
      final decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as List;

      for (var element in decodedResponse) {
        looksList.add(Look.getFrom(element));
      }
    } finally {
      client.close();
    }

    emit(WallInitState(looks: looksList));
  }

  Future<void> _onAddToFavorite(
      WallAddLookToFavoriteEvent event, Emitter emit) async {

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

    emit(AddedToFavoriteState());
  }
}
