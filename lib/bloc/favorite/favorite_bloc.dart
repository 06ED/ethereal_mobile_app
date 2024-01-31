import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../assets/constants.dart';
import '../../entity/look.dart';
import 'package:http/http.dart' as http;

import '../../entity/user.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<FavoriteInitEvent>(_onInit);
    on<FavoriteRemoveEvent>(_onRemoveFromFavorite);
  }

  Future<void> _onInit(FavoriteEvent event, Emitter emit) async {
    final client = http.Client();
    final user = await User.getCurrentUser();
    final looksList = <Look>[];

    try {
      final response = await client.post(
          Uri.parse("$kDefaultServerApiUrl/getFavoriteLooks/"),
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

    emit(FavoriteInitState(looks: looksList));
  }

  Future<void> _onRemoveFromFavorite(
      FavoriteRemoveEvent event, Emitter emit) async {
    final client = http.Client();
    final user = await User.getCurrentUser();

    try {
      await client.post(
          Uri.parse("$kDefaultServerApiUrl/removeFavoriteLook/"),
          headers: {"content-type": "application/json"},
          body: jsonEncode({"user_id": user?.id, "look_id": event.look.id}));
    } finally {
      client.close();
    }

    await _onInit(event, emit);
  }
}
