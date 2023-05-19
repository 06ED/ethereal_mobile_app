import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class DefaultNavigationBar extends StatefulWidget {
  final int index;

  const DefaultNavigationBar(this.index, {Key? key}) : super(key: key);

  @override
  State<DefaultNavigationBar> createState() => _DefaultNavigationBarState();
}

class _DefaultNavigationBarState extends State<DefaultNavigationBar> {
  static const _kRouteIndex = {
    0: "/wall",
    1: "/wardrobe",
    2: "/profile",
    3: "/favorite",
    4: "/looks",
  };

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      color: Colors.black,
      activeColor: Colors.black,
      backgroundColor: Colors.white,
      initialActiveIndex: widget.index,
      items: const [
        TabItem(icon: Icons.accessibility, title: "Лента"),
        TabItem(icon: Icons.add_a_photo_outlined, title: "Гардероб"),
        TabItem(icon: Icons.person, title: "Аккаунт"),
        TabItem(icon: Icons.star, title: "Избранное"),
        TabItem(icon: Icons.account_balance, title: "Образы",)
      ],
      onTap: (index) => Navigator.pushNamed(context, _kRouteIndex[index]!),
    );
  }
}
