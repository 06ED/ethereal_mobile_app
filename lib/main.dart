import 'package:ethereal_app/widgets/form.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Main());

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color.fromARGB(255, 100, 0, 0)),
          padding: const EdgeInsets.all(10),
          child: Column(
            children:  const [
              InputFormField("Text"),
              InputFormField("Text2"),
              ValidateFormButton("Validate")
            ],
          ),
        ),
      ),
    );
  }
}
