import 'package:ethereal_app/bloc/change_data_bloc.dart';
import 'package:ethereal_app/bloc/login_bloc.dart';
import 'package:ethereal_app/bloc/wardrobe_bloc.dart';
import 'package:ethereal_app/ui/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const Main());

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/login",
      routes: {
        "/login": (context) => BlocProvider(
              create: (context) => LoginBloc(),
              child: const Login(),
            ),
        "/register": (context) => const Register(),
        "/profile": (context) => const Profile(),
        "/change_data": (context) => BlocProvider(
          create: (context) => ChangeDataBloc(),
          child: const ChangeData(),
        ),
        "/wardrobe": (context) => BlocProvider(
          create: (context) => WardrobeBloc()..add(WardrobeInitEvent()),
          child: const Wardrobe(),
        ),
      },
    );
  }
}
