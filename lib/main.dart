import 'package:flutter/material.dart';
import 'package:quiz_app/app/helper/functions.dart';
import 'package:quiz_app/app/views/dictionary_screen.dart';
import 'package:quiz_app/app/views/home.dart';
import 'package:quiz_app/app/views/signin.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app/views/calc_screen.dart';
import 'app/views/create_quiz.dart';
import 'app/views/periodic_table.dart';
import 'app/views/play_quiz.dart';
import 'app/views/question_screen.dart';
import 'app/views/results.dart';
import 'app/views/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isLoggedIn = false;

  @override
  void initState() {
    checkUserLoggedInStatus();
    super.initState();
  }

  checkUserLoggedInStatus() async {
    await HelperFunctions.getLoggedUserDetails().then((value) {
      setState(() {
        isLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: "/home",
      //(isLoggedIn ?? false) ? "/home" : "/signIn",
      routes: {
        "/signIn": (context) => const SignIn(),
        "/signUp": (context) => const SignUp(),
        "/home": (context) => const HomePage(),
        "/createQuiz": (context) => const CreateQuiz(),
        "/periodicTable": (context) => const PeriodicTable(),
        "/dictionary": (context) => const DictionaryScreen(),
        "/calculator":(context) => const CalcScreen(),
        "/playQuiz": (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          return PlayQuiz(quizId: args.toString());
        },
        "/createQuestion": (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          return QuestionScreen(quizId: args.toString());
        },
        "/results": (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String,dynamic>;
          if (args == null) {
            return Container(); 
          }
          else{
            return Results(
            correct:args['correct'],
            incorrect: args['incorrect'],
            total: args['total'],
            notAttempted: args['notAttempted'],
          );
          }
          
        },
      },
    );
  }
}
