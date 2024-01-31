import 'package:ethereal_app/bloc/change_data/change_data_bloc.dart';
import 'package:ethereal_app/bloc/favorite/favorite_bloc.dart';
import 'package:ethereal_app/bloc/get_clothes/get_clothes_bloc.dart';
import 'package:ethereal_app/bloc/login/login_bloc.dart';
import 'package:ethereal_app/bloc/wall/wall_bloc.dart';
import 'package:ethereal_app/bloc/wardrobe/wardrobe_bloc.dart';
import 'package:ethereal_app/ui/routes.dart';
import 'package:ethereal_app/ui/routes/custom_looks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/custom_looks/custom_looks_bloc.dart';

void main() => runApp(const Main());

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/login",
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      routes: {
        "/login": (context) => BlocProvider(
              create: (context) => LoginBloc()..add(LoginInitEvent()),
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
        "/add_clothes": (context) => BlocProvider(
              create: (context) => GetClothesBloc()..add(GetClothesInitEvent()),
              child: const GetClothes(),
            ),
        "/wall": (context) => BlocProvider(
              create: (context) => WallBloc()..add(WallInitEvent()),
              child: const Wall(),
            ),
        "/favorite": (context) => BlocProvider(
              create: (context) => FavoriteBloc()..add(FavoriteInitEvent()),
              child: const Favorite(),
            ),
        "/looks": (context) => BlocProvider(
              create: (context) =>
                  CustomLooksBloc()..add(CustomLooksInitEvent()),
              child: const CustomLooks(),
            ),
      },
    );
  }
}
