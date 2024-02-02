import 'dart:convert';
import 'dart:typed_data';

import '/entity/entity.dart';

class ClothesType extends Entity {
  final int id;
  final String name;

  ClothesType({required this.id, required this.name});

  static ClothesType getFrom(Map mapEntity) {
    return ClothesType(id: mapEntity["id"], name: mapEntity["name"]);
  }
}

class ClothesStyle extends Entity {
  final int id;
  final String name;

  ClothesStyle({required this.id, required this.name});

  static ClothesStyle getFrom(Map mapEntity) {
    return ClothesStyle(id: mapEntity["id"], name: mapEntity["name"]);
  }
}

class ClothesSeason extends Entity {
  final int id;
  final String name;
  final String lookSeason;

  ClothesSeason(
      {required this.id, required this.name, required this.lookSeason});
  
  static ClothesSeason getForm(Map mapEntity) {
    return ClothesSeason(
        id: mapEntity["id"],
        name: mapEntity["name"],
        lookSeason: mapEntity["look_season"]);
  }
}

class Clothes extends Entity {
  final int id;
  final String name;
  final ClothesType type;
  final ClothesSeason season;
  final Uint8List img;

  Clothes(
      {required this.id,
      required this.name,
      required this.type,
      required this.season,
      required this.img});

  static Clothes getFrom(Map mapEntity) {
    return Clothes(
        id: mapEntity["id"],
        name: mapEntity["name"],
        type: ClothesType.getFrom(mapEntity["type"]),
        season: ClothesSeason.getForm(mapEntity["season"]),
        img: base64Decode(mapEntity["image"]));
  }
}
