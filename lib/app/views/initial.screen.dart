import 'package:flutter/material.dart';

import '../models/option_model.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  List<Option> options = [
    Option(title: " Tabela Periódica", icon: Icons.home),
    Option(title: " Calculadoras", icon: Icons.home),
    Option(title: " Conversor de Unidades", icon: Icons.home),
    Option(title: " Glossário", icon: Icons.home),
    Option(title: " Tabelas Químicas", icon: Icons.home),
    Option(title: " Tabela Periódica 6", icon: Icons.home),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.count(
      crossAxisCount: 2,
      children: List.generate(options.length, (index) {
        return Center(
          child: GestureDetector(
              onTap: () {
                switch (index) {
                  case 0:
                    Navigator.pushNamed(context, "/periodicTable");
                    break;
                  case 1:
                    Navigator.pushNamed(context, "/calculator");
                    break;
                  case 2:
                    Navigator.pushNamed(context, "/dictionary");
                    break;
                }
              },
              child: OptionCard(option: options[index])),
        );
      }),
    ));
  }
}

class OptionCard extends StatelessWidget {
  final Option option;
  const OptionCard({super.key, required this.option});

  @override
  Widget build(BuildContext context) {






    return Card(
        child: Center(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(option.icon, size: 80),
            Text(option.title),
          ]),
    ));
  }
}
