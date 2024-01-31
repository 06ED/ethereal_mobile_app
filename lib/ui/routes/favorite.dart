import 'package:ethereal_app/bloc/favorite/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../entity/clothes.dart';
import '../../entity/look.dart';
import '../widgets/navigation_bar.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(builder: (context, state) {
      if (state is FavoriteInitState) {
        return Scaffold(
          body: ListView.builder(
              itemCount: state.looks.length,
              itemBuilder: (context, index) => _buildItem(state.looks[index])),
          bottomNavigationBar: const DefaultNavigationBar(3),
        );
      }
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
        ),
        bottomNavigationBar: DefaultNavigationBar(3),
      );
    });
  }

  Widget _buildItem(Look look) {
    final clothesWidgetsList = <Widget>[];
    for (var i = 0; i < look.clothes.length; i++) {
      clothesWidgetsList.add(_buildClothes(look.clothes[i]));
    }

    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          color: Colors.white),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ...clothesWidgetsList,
          Text(
            look.description,
            style: const TextStyle(fontSize: 24, fontFamily: "Montserrat"),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                color: Colors.white),
            child: Column(
              children: [
                _buildRow("Сезон", look.season.name),
                _buildRow("Стиль", look.style.name),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(40),
                  ),
                  color: Colors.black),
              margin: const EdgeInsets.only(bottom: 20, right: 20),
              child: IconButton(
                icon: const Icon(Icons.delete_forever),
                color: Colors.redAccent,
                onPressed: () {
                  context
                      .read<FavoriteBloc>()
                      .add(FavoriteRemoveEvent(look: look));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClothes(Clothes clothes) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          clothes.name,
          style: const TextStyle(fontSize: 24, fontFamily: "Montserrat"),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              color: Colors.white),
          margin: const EdgeInsets.all(10),
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 15,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.memory(clothes.img),
              ),
              _buildRow("Тип одежды", clothes.type.name),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRow(String key, String value) {
    const style = TextStyle(fontSize: 20, fontFamily: "Montserrat");

    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        "$key: $value",
        style: style,
      ),
    );
  }
}
