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
        backgroundColor: const Color.fromARGB(255, 87, 173, 143),
        body: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color.fromARGB(255, 87, 130, 117)
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 100,
            horizontal: 40
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
