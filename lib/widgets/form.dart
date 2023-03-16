import 'package:flutter/material.dart';

class FormButton extends StatefulWidget {
  String text;

  FormButton(this.text, {Key? key}) : super(key: key);

  @override
  State<FormButton> createState() => _FormButtonState(text);
}

class _FormButtonState extends State<FormButton> {
  String text;

  _FormButtonState(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: text,
        ),
        style: const TextStyle(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}
