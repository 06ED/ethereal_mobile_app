import 'package:url_launcher/url_launcher.dart';

import '/bloc/login/login_bloc.dart';
import '/ui/widgets/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _loginController = TextEditingController();
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
    return Scaffold(backgroundColor: Colors.white, body: _buildLoginWidget());
  }

  Widget _buildLoginWidget() {
    return BlocConsumer<LoginBloc, LoginState>(
        builder: (context, state) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Visibility(
                  visible: _visible,
                  child: const Text("ETHEREAL",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 70,
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.white),
                  margin:
                      const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
                  padding: const EdgeInsets.all(20),
                  child: _buildForm(),
                ),
              ],
            ),
        listener: (context, state) {
          if (state is LoginUserState) {
            if (state.correct) {
              Navigator.pushReplacementNamed(context, "/profile");
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                content: Text(
                  "Неправильный логин или пароль",
                  style: TextStyle(fontSize: 20, fontFamily: "Montserrat"),
                ),
                dismissDirection: DismissDirection.startToEnd,
              ));
            }
          }
        });
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: Wrap(
        runSpacing: 20,
        children: [
          InputFormField(
            "Логин",
            controller: _loginController,
          ),
          InputFormField(
            "Пароль",
            controller: _passwordController,
          ),
          BaseFormButton(
            "Войти",
            color: Colors.white,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<LoginBloc>().add(LoginButtonTappedEvent(
                    _loginController.text, _passwordController.text));
              }
            },
          ),
          BaseFormButton("Создать аккаунт",
              color: Colors.white,
              onPressed: () => launchUrl(
                  Uri.parse("https://etherealweb.onrender.com/register"))),
        ],
      ),
    );
  }

  String? _validator(String value) {
    if (value.trim().isEmpty) return "Необходимое поле";
    return null;
  }
}
