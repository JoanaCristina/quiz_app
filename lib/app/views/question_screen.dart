import 'package:flutter/material.dart';
import 'package:quiz_app/app/widgets/widgets.dart';
import '../services/database.dart';

class QuestionScreen extends StatefulWidget {
  final String quizId;
  const QuestionScreen({required this.quizId, super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  late String _question,
      _correctAnswer,
      _firstOption,
      _secondOption,
      _thirdOption,
      _fourthOption;
  final _questionInputController = TextEditingController();
  final _correctAnswerInputController = TextEditingController();
  final _firstInputController = TextEditingController();
  final _secondInputController = TextEditingController();
  final _thirdInputController = TextEditingController();
  final _fourthInputController = TextEditingController();
  final DatabaseService _databaseService = DatabaseService();

  @override
  void dispose() {
    _questionInputController.dispose();
    _correctAnswerInputController.dispose();
    _firstInputController.dispose();
    _secondInputController.dispose();
    _thirdInputController.dispose();
    _fourthInputController.dispose();
    super.dispose();
  }

  uploadQuizData() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      Map<String, String> questionMap = {
        "question": _questionInputController.text.trim(),
        "correctAnswer": _correctAnswerInputController.text.trim(),
        "firstOption": _firstInputController.text.trim(),
        "secondOption": _secondInputController.text.trim(),
        "thirdOption": _thirdInputController.text.trim(),
        "fourthOption": _fourthInputController.text.trim(),
      };
      await _databaseService
          .addQuestionData(questionMap, widget.quizId)
          .then((value) {
        setState(() {
          _isLoading = false;
          _questionInputController.clear();
          _correctAnswerInputController.clear();
          _firstInputController.clear();
          _secondInputController.clear();
          _thirdInputController.clear(); 
          _fourthInputController.clear();
          
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black54),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _questionInputController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Digite um questão";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _question = value;
                            },
                            decoration: const InputDecoration(
                              hintText: "Questão",
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            controller: _correctAnswerInputController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Digite a resposta correta";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _correctAnswer = value;
                            },
                            decoration: const InputDecoration(
                              hintText: "Resposta correta",
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            controller: _firstInputController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Digite uma Opção incorreta";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _firstOption = value;
                            },
                            decoration: const InputDecoration(
                              hintText: "Opção incorreta 1",
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            controller: _secondInputController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Digite uma Opção incorreta";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _secondOption = value;
                            },
                            decoration: const InputDecoration(
                              hintText: "Opção incorreta 2",
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            controller: _thirdInputController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Digite uma Opção incorreta";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _thirdOption = value;
                            },
                            decoration: const InputDecoration(
                              hintText: "Opção incorreta 3",
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            controller: _fourthInputController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Digite uma Opção incorreta";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _fourthOption = value;
                            },
                            decoration: const InputDecoration(
                              hintText: "Opção incorreta 4",
                            ),
                          ),
                        ],
                      )),
                  const Spacer(),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: customOrangeButton(
                              context: context,
                              buttonLabel: "Sair",
                              buttonWidth:
                                  MediaQuery.of(context).size.width / 2 - 36)),
                      const SizedBox(
                        width: 24,
                      ),
                      GestureDetector(
                          onTap: uploadQuizData,
                          child: customOrangeButton(
                              context: context,
                              buttonLabel: "Adicionar questão",
                              buttonWidth:
                                  MediaQuery.of(context).size.width / 2 - 36)),
                      const SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                  const SizedBox(height: 60)
                ],
              ),
            ),
    );
  }
}
