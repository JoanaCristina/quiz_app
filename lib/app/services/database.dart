import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class DatabaseService {
  final _db = FirebaseFirestore.instance;

  /*Future<void> addQuizData(Map<String, dynamic> quizData,) async {
     await _db
        .collection("Quiz")
        .add(quizData)
        .then((DocumentReference doc) {
      debugPrint('DocumentSnapshot added with ID: ${doc.id}');
    }).catchError((onError) {
      debugPrint('Failed to add ${onError.toString()}');
    });
  }*/

  Future<void> addQuizData(Map<String, dynamic> quizData, String quizId) async {
    await _db
        .collection("Quiz")
        .doc(quizId)
        .set(quizData)
        .catchError((onError) {
      debugPrint(onError.toString());
    });
  }

  Future<void> addQuestionData(
      Map<String, String> questionData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QNA")
        .add(questionData)
        .catchError((onError) {
      debugPrint(onError.toString());
    });
  }

  Future getQuizData() async {
    return FirebaseFirestore.instance.collection("Quiz").snapshots();
  }

  Future getPeriodicTableData() async{
return FirebaseFirestore.instance.collection("tabelaPeriodica").get();
  }

  Future getQuestionsQuizData(String quizId) async {
    debugPrint("chamou o metodo getQuestion...... $quizId");
    return await FirebaseFirestore.instance
        .collection('Quiz')
        .doc(quizId)
        .collection('QNA')
        .get();
  }

  Future getElementsOfPeriodicTable(String lineId) async {
    debugPrint("chamou a table periodica");
    return await FirebaseFirestore.instance
        .collection('tabelaPeriodica')
        .doc(lineId)
        .collection('elements')
        .get();
  }
}
