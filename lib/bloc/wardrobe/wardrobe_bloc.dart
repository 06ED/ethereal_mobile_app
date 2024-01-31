import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ethereal_app/assets/constants.dart';
import 'package:ethereal_app/entity/user.dart';
import 'package:http/http.dart' as http;

import '../../entity/clothes.dart';

part 'wardrobe_event.dart';
part 'wardrobe_state.dart';

class WardrobeBloc extends Bloc<WardrobeEvent, WardrobeState> {
  WardrobeBloc() : super(WardrobeInitial()) {
    on<WardrobeInitEvent>(_onInit);
  }

  Future<void> _onInit(WardrobeInitEvent event, Emitter emit) async {
    final client = http.Client();
    final user = await User.getCurrentUser();
    final clothesList = <Clothes>[];
    try {
      final response = await client.post(
          Uri.parse("$kDefaultServerApiUrl/wardrobe/"),
          headers: {"content-type": "application/json"},
          body: jsonEncode({"user_id": user!.id,})
      );
      final decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as List;

      for (var element in decodedResponse) {
        final clothes = Clothes.getFrom(element);
        clothesList.add(clothes);
      }
    } finally {
      client.close();
    }

    emit(LoadedState(clothesList));
  }
}
