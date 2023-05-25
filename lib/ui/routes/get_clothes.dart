import 'package:ethereal_app/entity/clothes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/get_clothes_bloc.dart';
import '../widgets/form.dart';
import '../widgets/navigation_bar.dart';

class GetClothes extends StatefulWidget {
  const GetClothes({Key? key}) : super(key: key);

  @override
  State<GetClothes> createState() => _GetClothesState();
}

class _GetClothesState extends State<GetClothes> {
  late List<ClothesType> _types;
  late List<ClothesSeason> _seasons;

  late BuildContext _buildContext;

  final _listTypes = <Widget>[];
  final _listStyles = <Widget>[];
  final _boolTypes = <bool>[];
  final _boolStyles = <bool>[];

  static const _textStyle = TextStyle(fontFamily: "Montserrat", fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetClothesBloc, GetClothesState>(
        builder: (context, state) {
      _buildContext = context;

      if (state is GetClothesInitState) {
        _seasons = state.seasons;
        _types = state.types;

        if (_listTypes.isEmpty && _listStyles.isEmpty) {
          for (var type in state.types) {
            _listTypes.add(_inContainer(Text(
              type.name,
              style: _textStyle,
            )));
            _boolTypes.add(false);
          }
          for (var season in state.seasons) {
            _listStyles.add(_inContainer(Text(
              season.name,
              style: _textStyle,
            )));
            _boolStyles.add(false);
          }
        }

        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.white),
            margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ToggleButtons(
                  fillColor: Colors.black12,
                  selectedColor: Colors.black,
                  isSelected: _boolTypes,
                  onPressed: (index) => setState(() {
                    // The button that is tapped is set to true, and the others to false.
                    for (int i = 0; i < _boolTypes.length; i++) {
                      _boolTypes[i] = i == index;
                    }
                  }),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  children: _listTypes,
                ),
                ToggleButtons(
                  direction: Axis.vertical,
                  fillColor: Colors.black12,
                  selectedColor: Colors.black,
                  isSelected: _boolStyles,
                  onPressed: (index) => setState(() {
                    // The button that is tapped is set to true, and the others to false.
                    for (int i = 0; i < _boolStyles.length; i++) {
                      _boolStyles[i] = i == index;
                    }
                  }),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  children: _listStyles,
                ),
                BaseFormButton(
                  "Найти",
                  color: Colors.white,
                  onPressed: () => context.read<GetClothesBloc>().add(
                      GetClothesParamsEvent(
                          season: _seasons[_boolStyles.indexOf(true)],
                          type: _types[_boolTypes.indexOf(true)])),
                )
              ],
            ),
          ),
        );
      }
      if (state is GetClothesListState) {
        return Scaffold(
          body: ListView.builder(
            itemCount: state.clothes.length,
            itemBuilder: (context, index) =>
                _buildElement(state.clothes[index]),
          ),
        );
      }
      if (state is SetClothesState) {
        Navigator.pushNamed(context, "/wardrobe");
      }
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
        ),
        bottomNavigationBar: DefaultNavigationBar(1),
      );
    });
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
                    BaseFormButton(
                      "Добавить",
                      color: Colors.white,
                      onPressed: () {
                        _buildContext
                            .read<GetClothesBloc>()
                            .add(SetClothesParamsEvent(clothes: clothes));
                      },
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

  Widget _inContainer(Widget widget) => Container(
        margin: const EdgeInsets.all(6),
        child: widget,
      );
}
