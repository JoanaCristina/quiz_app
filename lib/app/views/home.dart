import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/app/services/database.dart';
import 'package:quiz_app/app/views/quizzes_screen.dart';
import 'package:quiz_app/app/views/user_config_screen.dart';
import 'package:quiz_app/app/widgets/widgets.dart';

import 'initial.screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _screens = [
    const  InitialScreen(),
    const QuizzesScreen(),
    const UserConfiguration(),
    ];
     int _currentIndex = 0;
  final DatabaseService _databaseService = DatabaseService();
  Stream? quizStream;

  @override
  void initState() {
    //getQuizData();
    super.initState();
  }

  Widget quizList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
          stream: quizStream,
          builder: (_, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (_, index) {
                      return QuizTile(
                          quizId: snapshot.data.docs[index].data()["quizId"],
                          imgUrl:
                              snapshot.data.docs[index].data()["quizImageUrl"],
                          title: snapshot.data.docs[index].data()["quizTitle"],
                          description: snapshot.data.docs[index]
                              .data()["quizDescription"]);
                    })
                : const Center(child: CircularProgressIndicator());
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: onTabTapped,
      // ignore: prefer_const_literals_to_create_immutables
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home, size:40),
          label:"",
          ),
       
        const BottomNavigationBarItem(
          icon: Icon(Icons.book, size:40),
          label: "",
         ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.settings, size:40),
          label: "",
          ),
      ],
    ) 
  
    




     /* floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, "/createQuiz"),
        child: const Icon(Icons.add),
      ),*/
    );
  }

  onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }





  getQuizData() {
    _databaseService.getQuizData().then((value) {
      setState(() {
        quizStream = value;
      });
    });
  }
}

class QuizTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String description;
  final String quizId;

  const QuizTile(
      {super.key,
      required this.imgUrl,
      required this.title,
      required this.description,
      required this.quizId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed("/playQuiz", arguments: quizId),
      child: Container(
        height: 150,
        margin: const EdgeInsets.only(bottom: 8),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imgUrl,
                width: MediaQuery.of(context).size.width - 48,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black26,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
