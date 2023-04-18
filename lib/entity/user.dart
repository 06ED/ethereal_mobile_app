import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import '../entity/entity.dart';

class User extends Entity {
  final int id;
  String username;
  String mail;
  Uint8List img;

  User(
      {required this.id,
      required this.mail,
      required this.username,
      required this.img});

  static User fromMap(Map mapEntity) {
    var bytes = base64Decode(mapEntity["image"]);

    return User(
        id: mapEntity["id"],
        mail: mapEntity["mail"],
        username: mapEntity["username"],
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
      username: mapUser["username"],
      img: base64Decode(mapUser["image"])
    );
  }

  static Future<void> setCurrentUser(User user) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/user.json");
    if (!await file.exists()) await file.create();

    final stringUser = jsonEncode({
      "id": user.id,
      "mail": user.mail,
      "username": user.username,
      "image": base64Encode(user.img)
    });
    await file.writeAsString(stringUser);
  }

  void update() {
    // TODO updating user to server
  }
}
