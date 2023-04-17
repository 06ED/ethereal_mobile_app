import 'package:ethereal_app/ui/routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Main());

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/login",
      routes: {
        "/login": (context) => const Login(),
        "/register": (context) => const Register(),
        "/profile": (context) => const Profile(),
      },
    );
  }
}

