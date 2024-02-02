import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import '/assets/constants.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../entity/clothes.dart';
import '../../entity/user.dart';

part 'get_clothes_event.dart';
part 'get_clothes_state.dart';

class GetClothesBloc extends Bloc<GetClothesEvent, GetClothesState> {
  GetClothesBloc() : super(GetClothesInitial()) {
    on<GetClothesInitEvent>(_onInit);
    on<GetClothesParamsEvent>(_getClothes);
    on<SetClothesParamsEvent>(_setClothes);
  }

  Future<void> _onInit(GetClothesInitEvent event, Emitter emit) async {
    final client = http.Client();
    final clothesTypesList = <ClothesType>[];
    final clothesSeasonsList = <ClothesSeason>[];

    try {
      final response = await client.get(Uri.parse("$kDefaultServerApiUrl/ci/"));
      final decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      log(decodedResponse.toString());

      for (var type in decodedResponse["types"]) {
        clothesTypesList.add(ClothesType.getFrom(type));
      }
      for (var season in decodedResponse["seasons"]) {
        clothesSeasonsList.add(ClothesSeason.getForm(season));
      }
    } finally {
      client.close();
    }

    emit(GetClothesInitState(
        types: clothesTypesList, seasons: clothesSeasonsList));
  }

  Future<void> _setClothes(SetClothesParamsEvent event, Emitter emit) async {
    final client = http.Client();
    final user = await User.getCurrentUser();

    try {
      await client.post(
        Uri.parse("$kDefaultServerApiUrl/addInWardrobeResource/"),
        headers: {"content-type": "application/json"},
        body: jsonEncode({
          "user_id": user!.id,
          "clothes_id": event.clothes.id
        }));
    } finally {
      client.close();
    }
    emit(SetClothesState());
  }

  Future<void> _getClothes(GetClothesParamsEvent event, Emitter emit) async {
    final client = http.Client();
    final clothesList = <Clothes>[];

    try {
      final response = await client.post(
          Uri.parse("$kDefaultServerApiUrl/clothesByParams/"),
          headers: {"content-type": "application/json"},
          body: jsonEncode(
              {"type_id": event.type.id, "season_id": event.season.id}));
      final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));

      for (var element in decodedResponse) {
        final clothes = Clothes.getFrom(element);
        clothesList.add(clothes);
      }
    } finally {
      client.close();
    }
    emit(GetClothesListState(clothes: clothesList));
  }
}
