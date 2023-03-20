import 'package:flutter/material.dart';

class InputFormField extends StatefulWidget {
  final String text;

  const InputFormField(this.text, {Key? key}) : super(key: key);

  @override
  State<InputFormField> createState() => _InputFormFieldState();
}

class _InputFormFieldState extends State<InputFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: widget.text,
        ),
        style: const TextStyle(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}

class ValidateFormButton extends StatefulWidget {
  const ValidateFormButton({Key? key}) : super(key: key);

  @override
  State<ValidateFormButton> createState() => _ValidateFormButtonState();
}

class _ValidateFormButtonState extends State<ValidateFormButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: Color.fromARGB(255, 0, 0, 0),
        onPressed: () {}
    );
  }
}

