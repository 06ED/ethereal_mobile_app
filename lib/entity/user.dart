import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../entity/entity.dart';

class User extends Entity {
  final int id;
  String username;
  String mail;

  User({required this.id, required this.mail, required this.username});

  static User fromMap(Map mapEntity) {
    return User(
        id: mapEntity["id"],
        mail: mapEntity["mail"],
        username: mapEntity["username"]
    );
  }

  static User getCurrentUser() {
    return User(
      id: 1,
      mail: "hsbest14@yandex.ru",
      username: "Artyom"
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
    });
    await file.writeAsString(stringUser);
  }

  void update() {
    // TODO updating user to server
  }
}
