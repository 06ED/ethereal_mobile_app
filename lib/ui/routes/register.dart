import 'package:ethereal_app/bloc/register/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../widgets/form.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
    return BlocConsumer<RegisterBloc, RegisterState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Visibility(
              visible: _visible,
              child: const Text("Регистрация",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 60,
                  )),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.white),
              margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
              padding: const EdgeInsets.all(20),
              child: Wrap(
                runSpacing: 20,
                children: [
                  InputFormField(
                    "Логин",
                    controller: _usernameController,
                  ),
                  InputFormField(
                    "Почта",
                    controller: _emailController,
                  ),
                  InputFormField(
                    "Пароль",
                    controller: _passwordController,
                  ),
                  BaseFormButton(
                    "Создать аккаунт",
                    color: Colors.white,
                    onPressed: () {
                      context.read<RegisterBloc>().add(CreateUserEvent(
                            username: _usernameController.text,
                            mail: _emailController.text,
                            password: _passwordController.text,
                          ));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }, listener: (context, state) {
      if (state is UserRegisteredState) {
        Navigator.pushReplacementNamed(context, "/login");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Пользователь зарегестрирован",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        );
      }
    });
  }
}
