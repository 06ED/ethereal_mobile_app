import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/wardrobe_bloc.dart';
import '../../entity/clothes.dart';
import '../widgets/navigation_bar.dart';

class Wardrobe extends StatefulWidget {
  const Wardrobe({Key? key}) : super(key: key);

  @override
  State<Wardrobe> createState() => _WardrobeState();
}

class _WardrobeState extends State<Wardrobe> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WardrobeBloc, WardrobeState>(
      builder: (context, state) {
        if (state is LoadedState) {
          return Scaffold(
            body: ListView.builder(
              itemCount: state.clothes.length,
              itemBuilder: (context, index) =>
                  _buildElement(state.clothes[index]),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.pushNamed(context, "/add_clothes"),
              backgroundColor: Colors.black,
              child: const Icon(Icons.add),
            ),
            bottomNavigationBar: const DefaultNavigationBar(1),
          );
        }
        return const Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
          ),
          bottomNavigationBar: DefaultNavigationBar(1),
        );
      },
    );
  }

  Widget _buildElement(Clothes clothes) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          color: Colors.white),
      margin: const EdgeInsets.all(30),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Scaffold(
                appBar: AppBar(
                  title: Text(clothes.name),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: const Border(
                      bottom: BorderSide(color: Colors.black, width: 2)),
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.white),
                      margin: const EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.memory(clothes.img),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.white),
                      child: Wrap(
                        runSpacing: 15,
                        children: [
                          _buildRow("Сезон", clothes.season.name),
                          _buildRow("Тип одежды", clothes.type.name),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.memory(clothes.img),
            ),
            Text(
              clothes.name,
              style: const TextStyle(fontFamily: "Montserrat", fontSize: 20),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String key, String value) {
    const style = TextStyle(fontSize: 24, fontFamily: "Montserrat");
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        "$key: $value",
        style: style,
      ),
    );
  }
}
