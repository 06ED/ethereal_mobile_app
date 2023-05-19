import 'package:ethereal_app/bloc/wall_bloc.dart';
import 'package:ethereal_app/ui/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Tape extends StatefulWidget {
  const Tape({Key? key}) : super(key: key);

  @override
  State<Tape> createState() => _TapeState();
}

class _TapeState extends State<Tape> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WallBloc, WallState>(
      builder: (context, state)  {
        if (state is WallInitState) {
          return Scaffold(
            body: ListView.builder(itemBuilder: itemBuilder),
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

  void _buildItem() {

  }
}
