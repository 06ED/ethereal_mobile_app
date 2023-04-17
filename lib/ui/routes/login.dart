import 'package:ethereal_app/bloc/login_bloc.dart';
import 'package:ethereal_app/ui/widgets/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<_LoginState>();
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
    return BlocProvider(
        create: (context) => LoginBloc(), child: _buildLoginWidget());
  }

  Widget _buildLoginWidget() {
    return BlocConsumer<LoginBloc, LoginState>(
        builder: (context, state) => Scaffold(
              backgroundColor: const Color.fromARGB(255, 87, 173, 143),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Visibility(
                    visible: _visible,
                    child: const Text("ETHEREAL",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 70,
                        )),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromARGB(255, 87, 130, 117)),
                    margin: const EdgeInsets.symmetric(
                        vertical: 100, horizontal: 40),
                    padding: const EdgeInsets.all(20),
                    child: Wrap(
                      runSpacing: 20,
                      children: [
                        const InputFormField("Логин"),
                        const InputFormField("Пароль"),
                        ValidateFormButton(
                          "Войти",
                          const Color.fromARGB(255, 255, 199, 115),
                          onPressed: () {
                            context
                                .read<LoginBloc>()
                                .add(LoginButtonTappedEvent("aaa"));
                          },
                        ),
                        ValidateFormButton("Создать аккаунт", Colors.white,
                            onPressed: () =>
                                Navigator.pushNamed(context, "/register")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        listener: (_, __) {}
    );
  }
}
