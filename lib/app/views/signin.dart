import 'package:flutter/material.dart';
import 'package:quiz_app/app/helper/functions.dart';
import 'package:quiz_app/app/services/auth.dart';
import '../widgets/widgets.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  late String email, password;
  final TextEditingController _emailInputController = TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
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
                      controller: _emailInputController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Digite um e-mail correto";
                        } else {}
                        return null;
                      },
                      decoration: const InputDecoration(hintText: "E-mail"),
                      onChanged: (value) {
                        email = value;
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
                          return "Senha incorreta";
                        } else {}
                        return null;
                      },
                      decoration: const InputDecoration(hintText: "Senha"),
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                        onTap: singIn,
                        child: customOrangeButton(
                          context: context,
                          buttonLabel: "Entrar",
                        )),
                    const SizedBox(
                      height: 18,
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text("Não tem uma conta?",
                            style: TextStyle(fontSize: 16)),
                        const SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/signUp");
                          },
                          child: const Text(
                            "Cadastre-se",
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

  void singIn() async {
    debugPrint(_formKey.currentState!.validate().toString());
    if (_formKey.currentState!.validate()) {
      //debugPrint("está validando");
      setState(() {
        isLoading = true;
      });
      await AuthService()
          .signInEmailPassword(
              _emailInputController.text, _passwordInputController.text)
          .then((value) {
        if (value != null) {
          setState(() {
            isLoading = false;
          });
          HelperFunctions.saveUserLoggedInDetails(isLoggedIn: true);
          Navigator.pushReplacementNamed(context, "/home");
        }
      });
    } else {
      debugPrint("Usuário näo encontrado");
    }
  }
}
