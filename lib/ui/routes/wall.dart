import '/bloc/wall/wall_bloc.dart';
import '/ui/widgets/navigation_bar.dart';
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
  bool _notified = false;
  late List<Look> _looks;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WallBloc, WallState>(
      listener: (context, state) {
        if (state is AddedToFavoriteState && !_notified) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            content: Text(
              "Образ добавлен в избранное",
              style: TextStyle(fontSize: 20, fontFamily: "Montserrat"),
            ),
            dismissDirection: DismissDirection.startToEnd,
          ));
          _notified = true;
        }
      },
      builder: (context, state) {
        if (state is WallInitState) {
          _looks = state.looks;
        }
        if (state is WallInitState || state is AddedToFavoriteState) {
          return Scaffold(
            body: ListView.builder(
                itemCount: _looks.length,
                itemBuilder: (context, index) => _buildItem(_looks[index])),
            bottomNavigationBar: const DefaultNavigationBar(0),
          );
        }

        return const Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
          ),
          bottomNavigationBar: DefaultNavigationBar(0),
        );
      },
    );
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
                icon: const Icon(Icons.star),
                color: Colors.white,
                onPressed: () {
                  _notified = false;
                  context
                      .read<WallBloc>()
                      .add(WallAddLookToFavoriteEvent(look: look));
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
