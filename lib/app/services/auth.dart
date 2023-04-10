import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import '../shared/constants/routers.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _currentUser(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  Future signInEmailPassword(String email, String password) async {
    try {
      final response = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final userFirebase = _auth.currentUser;
      return _currentUser(userFirebase!);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future signUp(String email, String password) async {
    try {
      final response = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final userFirebase = _auth.currentUser;
      return _currentUser(userFirebase!);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future signOut() async {
    try {
      return _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
