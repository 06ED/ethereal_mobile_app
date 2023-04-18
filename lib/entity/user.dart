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

  void update() {
    // TODO updating user to server
  }
}
