import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_showdown/injection_container.dart';
import 'package:tv_showdown/presentation/bloc/characters_bloc.dart';
import 'package:tv_showdown/presentation/bloc/characters_event.dart';
import 'package:tv_showdown/presentation/pages/home_page.dart';

void main() {
  setupLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CharactersBloc>()..add(CharactersLoadStartedEvent()),
      child: const MaterialApp(
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
