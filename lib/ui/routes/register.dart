import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../widgets/form.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _visible = true;

  @override
  void initState() {
    KeyboardVisibilityController()
        .onChange
        .listen((bool visible) => setState(() => _visible = !visible));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildRegisterWidget();
  }

  Widget _buildRegisterWidget() {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 87, 173, 143),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Visibility(
            visible: _visible,
            child: const Text("Регистрация",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 70,
                )),
          ),
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromARGB(255, 87, 130, 117)),
            margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
            padding: const EdgeInsets.all(20),
            child: Wrap(
              runSpacing: 20,
              children: [
                const InputFormField("Логин"),
                const InputFormField("Почта"),
                const InputFormField("Пароль"),
                ValidateFormButton("Создать аккаунт",
                    const Color.fromARGB(255, 255, 199, 115),
                    onPressed: () =>
                        Navigator.pushNamed(context, "/register")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
