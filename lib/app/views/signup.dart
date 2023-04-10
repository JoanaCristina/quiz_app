import 'package:flutter/material.dart';
import 'package:quiz_app/app/helper/functions.dart';
import 'package:quiz_app/app/services/auth.dart';
import 'package:quiz_app/app/views/signin.dart';

import '../widgets/widgets.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  late String _name, _email, _password;
  final TextEditingController _nameInputController = TextEditingController();
  final TextEditingController _emailInputController = TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    _nameInputController.dispose();
    _emailInputController.dispose();
    _passwordInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Spacer(),
                    TextFormField(
                      controller: _nameInputController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Digite o nome de usuário";
                        } else {}
                        return null;
                      },
                      decoration: const InputDecoration(hintText: "Nome"),
                      onChanged: (value) {
                        _name = value;
                      },
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      controller: _emailInputController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Digite uma senha válida";
                        } else {}
                        return null;
                      },
                      decoration: const InputDecoration(hintText: "E-mail"),
                      onChanged: (value) {
                        _email = value;
                      },
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordInputController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Digite uma senha válida";
                        } else {}
                      },
                      decoration: const InputDecoration(hintText: "Senha"),
                      onChanged: (value) {
                        _password = value;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: signUp,
                      child: SingleChildScrollView(
                          child: customOrangeButton(
                        context: context,
                        buttonLabel: "Cadastrar",
                      )),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text("Já tem uma conta?",
                            style: TextStyle(fontSize: 16)),
                        const SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignIn()));
                          },
                          child: const Text(
                            "Entrar",
                            style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
            ),
    );
  }

  signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      AuthService()
          .signUp(_emailInputController.text.trim(),
              _passwordInputController.text.trim())
          .then((value) {
        debugPrint("Value ${value.toString()}");
        if (value != null) {
          setState(() {
            isLoading = false;
          });
          HelperFunctions.saveUserLoggedInDetails(isLoggedIn: true);
          Navigator.pushReplacementNamed(context, "/home");
        }
      });
    } else {
      debugPrint("invalidado");
    }
  }
}
