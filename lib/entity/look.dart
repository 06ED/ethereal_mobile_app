import 'dart:developer';

import '/entity/clothes.dart';
import '/entity/entity.dart';

class Look extends Entity {
  final int id;
  final ClothesStyle style;
  final ClothesSeason season;
  final int sex;
  final String description;
  final List<Clothes> clothes;

  Look({required this.id,
    required this.style,
    required this.season,
    required this.sex,
    required this.description,
    required this.clothes});

  static Look getFrom(Map mapEntity) {
    var all = <Clothes>[];

    for (var element in mapEntity["clothes"]) {
      all.add(Clothes.getFrom(element));
    }

    return Look(
        id: mapEntity["id"],
        style: ClothesStyle.getFrom(mapEntity["style"]),
        season: ClothesSeason.getForm(mapEntity["season"]),
        sex: mapEntity["sex"],
        description: mapEntity["description"],
        clothes: all);
  }
}
