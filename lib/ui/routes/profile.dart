import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        initialActiveIndex: 2,
        items: const [
          TabItem(icon: Icons.accessibility, title: "Лента"),
          TabItem(icon: Icons.add_a_photo_outlined, title: "Гардероб"),
          TabItem(icon: Icons.person, title: "Аккаунт"),
          TabItem(icon: Icons.star, title: "Избранное"),
          TabItem(icon: Icons.account_balance, title: "Образы")
        ],
        onTap: (index) {
          switch (index) {
            case 0 : {

            }
          }
        },
      ),
    );
  }
}
