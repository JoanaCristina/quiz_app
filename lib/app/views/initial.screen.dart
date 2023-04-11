import 'package:flutter/material.dart';

import '../models/option_model.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  List<Option> options = [
    Option(
        title: " Tabela Periódica",
        imageURL: "assets/images/periodic-table.png"),
    Option(
        title: " Calculadoras", imageURL: "assets/images/calculadora.png"),
    Option(
        title: " Conversor de Unidades",
        imageURL: "assets/images/calculator.png"),
    Option(title: " Glossário", imageURL: "assets/images/dicionario.png"),
    Option(
        title: " Tabelas Químicas",
        imageURL: "assets/images/tabela.png"),
    Option(
        title: " FlashCards ",
        imageURL: "assets/images/flashcard.png"),
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
            Image.asset(option.imageURL),
            Text(option.title),
          ]),
    ));
  }
}
