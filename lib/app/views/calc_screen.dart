import 'package:flutter/material.dart';


class CalcScreen extends StatefulWidget {
  const CalcScreen({super.key});

  @override
  State<CalcScreen> createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Container(color:Colors.green.shade300)
    );
  }
}