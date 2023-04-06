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
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: TextFormField(
        style: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        decoration: InputDecoration(
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          hintText: widget.text,
        ),
      ),
    );
  }
}

class ValidateFormButton extends StatefulWidget {
  final String text;
  final Color color;

  const ValidateFormButton(this.text, this.color, {super.key});

  @override
  State<ValidateFormButton> createState() => _ValidateFormButtonState();
}

class _ValidateFormButtonState extends State<ValidateFormButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 400,
      child: TextButton(
        // hoverColor: const Color.fromARGB(255, 255, 178, 64),
        style: TextButton.styleFrom(
          backgroundColor: widget.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: () {},
        child: Text(
          widget.text,
          style: const TextStyle(
              fontFamily: "Montserrat", fontSize: 24, color: Colors.black),
        ),
      ),
    );
  }
}
