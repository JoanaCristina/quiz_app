import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return Center(
    child: RichText(
        text: const TextSpan(
            style: TextStyle(fontSize: 22),
            // ignore: prefer_const_literals_to_create_immutables
            children: [
          TextSpan(
              text: "Paracelso",
              style: TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.w600)),
          TextSpan(
              text: "App",
              style:
                  TextStyle(color: Colors.orange, fontWeight: FontWeight.w500)),
        ])),
  );
}

Widget customOrangeButton(
    {required BuildContext context,
    required String buttonLabel,
    double? buttonWidth}) {
  return Container(
    height: 50,
    width: buttonWidth ?? MediaQuery.of(context).size.width,
    alignment: Alignment.center,
    decoration: const BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.all(Radius.circular(20))),
    child: Text(
      buttonLabel,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    ),
  );
}

Widget customStatusButtom(
    {required BuildContext context,
    required int value,
    required String label}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    decoration:const  BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20))
    ),
    child: Row(children: [
      Container(
        width: 25,
        height: 30,
        decoration:const  BoxDecoration(
          color:Colors.orange,
      borderRadius: BorderRadius.only(topLeft:Radius.circular(10) ,bottomLeft:Radius.circular(10))
    ),
        child: Center(
          child: Text(value.toString(),
          style: const TextStyle(color: Colors.white),))),
     
     Container(
        width: 65,
        height: 30,
        decoration: BoxDecoration(
          color:Colors.grey.shade700,
      borderRadius: const 
      BorderRadius.only(topRight:Radius.circular(10) ,bottomRight:Radius.circular(10))
    ),
        child: Center(
          child: Text(label,
          style: const TextStyle(color: Colors.white),))),
     
  
      
    ]),
  );
}
