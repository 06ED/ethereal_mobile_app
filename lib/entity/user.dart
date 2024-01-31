import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import '../entity/entity.dart';

class User extends Entity {
  final int id;
  String username;
  String mail;
  Uint8List? img;

  User(
      {required this.id,
      required this.mail,
      required this.username,
      required this.img});

  static User fromMap(Map mapEntity) {
    Uint8List? bytes;
    if (mapEntity.containsKey("image")) {
      bytes = base64Decode(mapEntity["image"]);
    }

    return User(
        id: mapEntity["id"],
        mail: mapEntity["mail"],
        username: mapEntity["nickname"],
        img: bytes
    );
  }

  static Future<User?> getCurrentUser() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/user.json");
    if (!await file.exists()) return null;

    var mapUser = jsonDecode(await file.readAsString());

    return User(
      id: mapUser["id"],
      mail: mapUser["mail"],
      username: mapUser["nickname"],
      img: base64Decode(mapUser["image"])
    );
  }

  static Future<void> deleteCurrentUser() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/user.json");
    if (await file.exists()) await file.delete();
  }

  static Future<void> setCurrentUser(User user) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/user.json");
    if (!await file.exists()) await file.create();

    final stringUser = jsonEncode({
      "id": user.id,
      "mail": user.mail,
      "nickname": user.username,
      "image": user.img != null ? base64Encode(user.img!) : null,
    });
    await file.writeAsString(stringUser);
  }
}
