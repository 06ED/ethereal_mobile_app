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
                      child: snapshot.data!.img != null
                          ? Image.memory(
                              snapshot.data!.img!,
                              width: 200,
                              height: 200,
                            )
                          : Image.network(
                              "https://static.thenounproject.com/png/4404607-200.png",
                              width: 200,
                              height: 200,
                            ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 85, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
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
                      "Выйти",
                      color: Colors.redAccent,
                      onPressed: () {
                        User.deleteCurrentUser().then(
                            (value) => Navigator.pushNamed(context, "/login"));
                      },
                    ),
                  ],
                );
              } else {
                return const Scaffold(
                  backgroundColor: Colors.black,
                  body: Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white)),
                  ),
                  bottomNavigationBar: DefaultNavigationBar(2),
                );
              }
            }),
      ),
      bottomNavigationBar: const DefaultNavigationBar(2),
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
