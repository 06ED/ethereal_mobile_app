import 'package:flutter/material.dart';
import '../../entity/user.dart';
import '../widgets/form.dart';
import '../widgets/navigation_bar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<User?> _user;

  @override
  void initState() {
    _user = User.getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<User?>(
          future: _user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Wrap(
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.memory(
                      snapshot.data!.img,
                      width: 200,
                      height: 200,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 85, vertical: 10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: const BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: [
                        _buildParam("Логин", snapshot.data!.username),
                        const SizedBox(height: 30),
                        _buildParam("Почта", snapshot.data!.mail),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                  BaseFormButton(
                    "Изменить пароль",
                    color: Colors.white,
                    onPressed: () => Navigator.pushNamed(context, "/change_password"),
                  ),
                  BaseFormButton(
                    "Изменить данные",
                    color: Colors.white,
                    onPressed: () => Navigator.pushNamed(context, "/change_data"),
                  ),
                  BaseFormButton(
                    "Выйти",
                    color: Colors.redAccent,
                    onPressed: () => Navigator.pushNamed(context, "/login"),
                  ),
                ],
              );
            } else {
              return const Text("1");
            }
          }
        ),
      ),
      bottomNavigationBar: const DefaultNavigationBar(),
    );
  }

  Widget _buildParam(String keyText, String valueText) {
    return Column(
      children: [
        Text(
          keyText,
          style: const TextStyle(fontSize: 28),
        ),
        Text(
          valueText,
          style: const TextStyle(fontSize: 24),
        )
      ],
    );
  }
}
