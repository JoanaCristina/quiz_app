import 'package:flutter/material.dart';
import 'package:quiz_app/app/services/database.dart';
import 'package:quiz_app/app/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({super.key});

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  late String _quizUrlImage, _quizTitle, _quizDescription;
  final _imageInputController = TextEditingController();
  final _titleInputController = TextEditingController();
  final _descriptionInputController = TextEditingController();
  final DatabaseService _databaseService = DatabaseService();
  bool _isLoading = false;

  createQuizOnline() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      String quizId = randomAlphaNumeric(16);
      Map<String, dynamic> quizData = {
        "quizId": quizId,
        "quizImageUrl": _imageInputController.text.trim(),
        "quizTitle": _titleInputController.text.trim(),
        "quizDescription": _descriptionInputController.text.trim(),
      };
      await _databaseService.addQuizData(quizData, quizId).then((value) {
        setState(() {
          _isLoading = false;
          _imageInputController.clear();
          _titleInputController.clear();
          _descriptionInputController.clear();
        });

        Navigator.pushReplacementNamed(context, "/createQuestion",
            arguments: quizId);
      });
    }
  }

  @override
  void dispose() {
    _imageInputController.dispose();
    _titleInputController.dispose();
    _descriptionInputController.dispose();
    super.dispose();
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
                            controller: _imageInputController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Digite uma url válida";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _quizUrlImage = value;
                            },
                            decoration: const InputDecoration(
                              hintText: "Imagem para Tumblr do Quiz",
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            controller: _titleInputController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Digite um título para o Quiz";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _quizTitle = value;
                            },
                            decoration: const InputDecoration(
                              hintText: "Título do Quiz",
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            controller: _descriptionInputController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Digite uma descrição para o Quiz";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _quizDescription = value;
                            },
                            decoration: const InputDecoration(
                              hintText: "Descrição",
                            ),
                          ),
                        ],
                      )),
                  const Spacer(),
                  GestureDetector(
                      onTap: createQuizOnline,
                      child: customOrangeButton(
                          context: context, buttonLabel: "Criar Quiz")),
                  const SizedBox(height: 60)
                ],
              ),
            ),
    );
  }
}
