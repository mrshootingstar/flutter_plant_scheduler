import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantly/home/view/homepage.dart';
import 'package:plants_repository/plants_repository.dart';

class App extends StatelessWidget {
  const App({super.key, required this.plantsRepository});

  final PlantsRepository plantsRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: plantsRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: FlutterTodosTheme.light,
      // darkTheme: FlutterTodosTheme.dark,
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
      home: const MyHomePage(title: "Test"),
    );
  }
}
