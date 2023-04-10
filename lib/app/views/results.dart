import "package:flutter/material.dart";
import "package:quiz_app/app/widgets/widgets.dart";

class Results extends StatefulWidget {
  final int correct, incorrect, total, notAttempted;

  const Results(
      {super.key,
      required this.correct,
      required this.incorrect,
      required this.total,
      required this.notAttempted});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  bool _nextModule = false;

  @override
  void initState() {
    if (widget.correct / widget.total > 0.8) {
      _nextModule = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 8,
            ),
            widget.correct / widget.total > 0.8
                ? Text(
            
                    "Parabéns, você acertou ${widget.correct} de ${widget.total} questões e já está pronto para desbravar o próximo módulo.",
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 18
                    ))
                : Text(
                    "Que pena, você acertou somente ${widget.correct} de ${widget.total} questões, treine mais um pouco. Eu tenho certeza que na próxima você consegue!",
                      textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 18
                    )
                    ),
                    const SizedBox(height:30),
            Visibility(
                visible: _nextModule,
                child: customOrangeButton(
                  context: context, 
                  buttonLabel: "Ir para o próximo módulo"))
          ],
        ),
      ),
    );
  }
}
