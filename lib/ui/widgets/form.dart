import 'package:flutter/material.dart';

class InputFormField extends StatefulWidget {
  final String text;
  final TextEditingController? controller;

  const InputFormField(this.text, {required this.controller, super.key});

  @override
  State<InputFormField> createState() => _InputFormFieldState();
}

class _InputFormFieldState extends State<InputFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: TextFormField(
        controller: widget.controller,
        style: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        decoration: InputDecoration(
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          hintText: widget.text,
        ),
      ),
    );
  }
}

class BaseFormButton extends StatefulWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const BaseFormButton(this.text,
      {required this.color, required this.onPressed, super.key});

  @override
  State<BaseFormButton> createState() => _BaseFormButtonState();
}

class _BaseFormButtonState extends State<BaseFormButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 400,
      child: TextButton(
        style: TextButton.styleFrom(
          side: const BorderSide(color: Colors.black),
          backgroundColor: widget.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: widget.onPressed,
        child: Text(
          widget.text,
          style: const TextStyle(
              fontFamily: "Montserrat", fontSize: 24, color: Colors.black),
        ),
      ),
    );
  }
}
