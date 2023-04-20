import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/change_data_bloc.dart';
import '../widgets/form.dart';

class ChangeData extends StatefulWidget {
  const ChangeData({Key? key}) : super(key: key);

  @override
  State<ChangeData> createState() => _ChangeDataState();
}

class _ChangeDataState extends State<ChangeData> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        builder: (context, state) => Scaffold(
              body: Container(
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
            ),
        listener: (context, state) {
          if (state is UserChangedDataState) {
            Navigator.pushNamed(context, "/profile");
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
            "Почта",
            controller: _mailController,
          ),
          BaseFormButton(
            "Сохранить",
            color: Colors.white,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<ChangeDataBloc>().add(ChangeDataButtonTappedEvent(
                    _loginController.text, _mailController.text));
              }
            },
          ),
        ],
      ),
    );
  }
}
