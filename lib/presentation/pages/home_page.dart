import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_showdown/domain/entities/character.dart';
import 'package:tv_showdown/presentation/bloc/characters_bloc.dart';
import 'package:tv_showdown/presentation/bloc/characters_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CharactersBloc, CharactersState>(
        builder: (context, state) {
          if (state is CharactersLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CharactersDisplayedState) {
            return Column(
              children: [
                getTitleWidget(),
                getCharactersWidget(state),
              ],
            );
          }
          return const Center(
            child: Text("Failed to load app. Please restart."),
          );
        },
      ),
    );
  }
}

Widget getTitleWidget() {
  return Container(
    height: 200,
    alignment: Alignment.center,
    child: const Text(
      "Who Wins?",
      style: TextStyle(
        fontSize: 36,
      ),
    ),
  );
}

Widget getCharactersWidget(CharactersDisplayedState state) {
  return Expanded(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: getCharacterWidget(state.leftCharacter),
        ),
        Expanded(
          child: getCharacterWidget(state.rightCharacter),
        ),
      ],
    ),
  );
}

Widget getCharacterWidget(Character character) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Column(
      children: [
        Text(
          character.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "(${character.showName})",
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 180,
          child: Image.network(
            character.image!,
          ),
        ),
      ],
    ),
  );
}
