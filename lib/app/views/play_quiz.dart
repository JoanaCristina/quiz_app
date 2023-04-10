import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/app/services/database.dart';
import '../models/question_model.dart';
import '../widgets/quiz_play_widget.dart';
import '../widgets/widgets.dart';

class PlayQuiz extends StatefulWidget {
  final String quizId;
  const PlayQuiz({super.key, required this.quizId});

  @override
  State<PlayQuiz> createState() => _PlayQuizState();
}

int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;
Stream<int>? correctStream;
Stream<int>? incorrectStream;
StreamController<int> _correctController = StreamController<int>();
StreamController<int> _incorrectController = StreamController<int>();

class _PlayQuizState extends State<PlayQuiz> {
  late DatabaseService databaseService = DatabaseService();
  QuerySnapshot<Map<String, dynamic>>? questionSnapshot;



  QuestionModel getQuestionModelfromDataSnapshot(
      DocumentSnapshot<Map<String, dynamic>> questionSnapshot) {
    QuestionModel questionModel = QuestionModel();
    final data = questionSnapshot.data();

    questionModel.question = data?['question'];
    List<String> options = [
      data?['firstOption'],
      data?['secondOption'],
      data?['thirdOption'],
      data?['fourthOption'],
    ];

    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctAnswer = data?['correctAnswer'];

    questionModel.answered = false;

    return questionModel;
  }

  @override
  void initState() {
    _correctController.add(0);
    _incorrectController.add(0);
    databaseService.getQuestionsQuizData(widget.quizId).then((value) {
      questionSnapshot = value;
      _notAttempted = 0;
      _correct = 0;
      _incorrect = 0;
      total = questionSnapshot!.docs.length;
      correctStream = _correctController.stream;
      incorrectStream = _incorrectController.stream;

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black54),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Column(
        children: [
          questionSnapshot?.docs == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      customStatusButtom(
                          context: context, value: total, label: "Total"),
                      StreamBuilder(
                          stream: correctStream,
                          builder: (_, snapshot) {
                            return customStatusButtom(
                                context: context,
                                value: snapshot.hasData
                                    ? snapshot.data!
                                    : _correct,
                                label: "Acertos");
                          }),
                      StreamBuilder(
                          stream: incorrectStream,
                          builder: (_, snapshot) {
                            return customStatusButtom(
                                context: context,
                                value: snapshot.hasData
                                    ? snapshot.data!
                                    : _incorrect,
                                label: "Erros");
                          }),
                    ],
                  )
                  ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: questionSnapshot?.docs.length ?? 0,
                itemBuilder: (context, int index) {
                  return QuizPlayTile(
                    questionModel: getQuestionModelfromDataSnapshot(
                      questionSnapshot!.docs[index],
                    ),
                    index: index,
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, "/results", arguments: {
            "correct": _correct,
            "incorrect": _incorrect,
            "total": total,
            "notAttempted": _notAttempted
          });
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;

  const QuizPlayTile(
      {super.key, required this.questionModel, required this.index});

  @override
  State<QuizPlayTile> createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Q${widget.index + 1}) ${widget.questionModel.question}",
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        GestureDetector(
          onTap: () {
            if (!widget.questionModel.answered) {
              ///correct
              if (widget.questionModel.option1 ==
                  widget.questionModel.correctAnswer) {
                optionSelected = widget.questionModel.option1;
                widget.questionModel.answered = true;
                _correct++;
                _notAttempted--;
                setState(() {
                  _correctController.add(_correct);
                  
                });
              } else {
                optionSelected = widget.questionModel.option1;
                widget.questionModel.answered = true;
                _incorrect++;
                _notAttempted--;
                setState(() {
                  _incorrectController.add(_incorrect);
                });
              }
            }
          },
          child: OptionTile(
              option: "A",
              description: widget.questionModel.option1,
              correctAnswer: widget.questionModel.correctAnswer,
              optionSelected: optionSelected),
        ),
        const SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () {
            if (!widget.questionModel.answered) {
              ///correct
              if (widget.questionModel.option2 ==
                  widget.questionModel.correctAnswer) {
                optionSelected = widget.questionModel.option2;
                widget.questionModel.answered = true;
                _correct += 1;
                _notAttempted -= 1;
                setState(() { _correctController.add(_correct);});
              } else {
                optionSelected = widget.questionModel.option2;
                widget.questionModel.answered = true;
                _incorrect += 1;
                _notAttempted -= 1;
                setState(() { _incorrectController.add(_incorrect);});
              }
            }
          },
          child: OptionTile(
              option: "B",
              description: widget.questionModel.option2,
              correctAnswer: widget.questionModel.correctAnswer,
              optionSelected: optionSelected),
        ),
        const SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () {
            if (!widget.questionModel.answered) {
              ///correct
              if (widget.questionModel.option3 ==
                  widget.questionModel.correctAnswer) {
                optionSelected = widget.questionModel.option3;
                widget.questionModel.answered = true;
                _correct += 1;
                _notAttempted -= 1;
                setState(() { _correctController.add(_correct);});
              } else {
                optionSelected = widget.questionModel.option3;
                widget.questionModel.answered = true;
                _incorrect += 1;
                _notAttempted -= 1;
                setState(() { _incorrectController.add(_incorrect);});
              }
            }
          },
          child: OptionTile(
              option: "C",
              description: widget.questionModel.option3,
              correctAnswer: widget.questionModel.correctAnswer,
              optionSelected: optionSelected),
        ),
        const SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () {
            if (!widget.questionModel.answered) {
              ///correct
              if (widget.questionModel.option4 ==
                  widget.questionModel.correctAnswer) {
                optionSelected = widget.questionModel.option4;
                widget.questionModel.answered = true;
                _correct += 1;
                _notAttempted -= 1;
                setState(() { _correctController.add(_correct);});
              } else {
                optionSelected = widget.questionModel.option4;
                widget.questionModel.answered = true;
                _incorrect += 1;
                _notAttempted -= 1;
                setState(() { _incorrectController.add(_incorrect);});
              }
            }
          },
          child: OptionTile(
              option: "D",
              description: widget.questionModel.option4,
              correctAnswer: widget.questionModel.correctAnswer,
              optionSelected: optionSelected),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
