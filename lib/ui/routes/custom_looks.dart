import 'package:ethereal_app/bloc/wall_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/custom_looks_bloc.dart';
import '../../bloc/favorite_bloc.dart';
import '../../entity/clothes.dart';
import '../../entity/look.dart';
import '../widgets/navigation_bar.dart';

class CustomLooks extends StatefulWidget {
  const CustomLooks({Key? key}) : super(key: key);

  @override
  State<CustomLooks> createState() => _CustomLooksState();
}

class _CustomLooksState extends State<CustomLooks> {
  late Map<String, List<Look>> looks;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomLooksBloc, CustomLooksState>(
      builder: (context, state) {
        if (state is CustomLooksInitState) {
          looks = state.looks;
        }
        if (state is CustomLooksInitState ||
            state is AddedToFavoriteCustomLookState) {
          final widgets = <Widget>[];

          for (var entry in looks.entries) {
            widgets.add(GestureDetector(
              onTap: () {
                if (entry.value.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                    content: Text(
                      "Пока не подобрали для вас образов",
                      style: TextStyle(fontSize: 20, fontFamily: "Montserrat"),
                    ),
                    dismissDirection: DismissDirection.startToEnd,
                  ));
                  return;
                }
                Navigator.push(context, _buildRoute(entry.value));
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    color: Colors.white),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Icon(
                      Icons.business_center,
                      size: 100,
                    ),
                    Text(
                      entry.key,
                      style: const TextStyle(
                          fontFamily: "Montserrat", fontSize: 24),
                    ),
                  ],
                ),
              ),
            ));
          }

          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [...widgets],
              ),
            ),
            bottomNavigationBar: const DefaultNavigationBar(4),
          );
        }

        return const Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
          ),
          bottomNavigationBar: DefaultNavigationBar(4),
        );
      },
      listener: (context, state) {
        if (state is AddedToFavoriteCustomLookState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            content: Text(
              "Образ добавлен в избранное",
              style: TextStyle(fontSize: 20, fontFamily: "Montserrat"),
            ),
            dismissDirection: DismissDirection.startToEnd,
          ));
        }
      },
    );
  }

  MaterialPageRoute _buildRoute(List<Look> looks) {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
              body: ListView.builder(
                  itemCount: looks.length,
                  itemBuilder: (context, index) => _buildItem(looks[index])),
            ));
  }

  Widget _buildItem(Look look) {
    final clothesWidgetsList = <Widget>[
      for (var i = 0; i < look.clothes.length; i++)
        _buildClothes(look.clothes[i])
    ];

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
                  context
                      .read<CustomLooksBloc>()
                      .add(CustomLooksAddToFavoriteEvent(look: look));
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
