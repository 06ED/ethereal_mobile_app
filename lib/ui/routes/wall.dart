import 'package:ethereal_app/bloc/wall_bloc.dart';
import 'package:ethereal_app/ui/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../entity/clothes.dart';
import '../../entity/look.dart';

class Wall extends StatefulWidget {
  const Wall({Key? key}) : super(key: key);

  @override
  State<Wall> createState() => _WallState();
}

class _WallState extends State<Wall> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WallBloc, WallState>(
      builder: (context, state) {
        if (state is WallInitState) {
          return Scaffold(
            body: ListView.builder(
                itemBuilder: (context, index) =>
                    _buildItem(state.looks[index])),
            bottomNavigationBar: const DefaultNavigationBar(0),
          );
        }
        return Scaffold(
          body: Column(
            children: const [],
          ),
          bottomNavigationBar: const DefaultNavigationBar(0),
        );
      },
    );
  }

  Widget _buildItem(Look look) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          color: Colors.white),
      margin: const EdgeInsets.all(30),
      child: Column(
        children: [
          ListView.builder(
              itemBuilder: (context, index) =>
                  _buildClothes(look.clothes[index])),
          Text(
            look.description,
            style: const TextStyle(fontSize: 24, fontFamily: "Montserrat"),
          ),
          _buildRow("Сезон", look.season.name),
          _buildRow("Стиль", look.style.name)
        ],
      ),
    );
  }

  Widget _buildClothes(Clothes clothes) {
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
