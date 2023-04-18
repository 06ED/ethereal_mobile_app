import 'package:flutter/material.dart';
import '../widgets/navigation_bar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Row()],
      ),
      bottomNavigationBar: const DefaultNavigationBar(),
    );
  }

  Widget _buildRow(String keyText, String valueText, Function onTap) {
    return Row(
      children: [
        Text(keyText),
        Text(valueText),
      ],
    );
  }
}
