import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/app/models/element_model.dart';

import '../services/database.dart';

class PeriodicTable extends StatefulWidget {
  const PeriodicTable({super.key});

  @override
  State<PeriodicTable> createState() => _PeriodicTableState();
}

Stream<ElementModel>? elementModelStream;
StreamController<ElementModel> _elementController =
    StreamController<ElementModel>.broadcast();

Color getColor(ElementModel elementModel) {
  switch (elementModel.family) {
    case 'Não Metais':
      {
        return const Color.fromARGB(255, 15, 235, 22);
      }
    case 'Metais Alcalinos':
      {
        return Colors.orange;
      }

    case 'Metais Alcalino-terrosos':
      {
        return Colors.yellow;
      }

    case 'Gases Nobres':
      {
        return const Color.fromARGB(255, 14, 36, 236);
      }

    case 'Metaloides':
      {
        return const Color.fromARGB(255, 190, 95, 199);
      }
    case 'Halogênios':
      {
        return const Color.fromARGB(255, 39, 197, 245);
      }
    case 'Metais de Transição':
      {
        return const Color.fromARGB(255, 199, 118, 118);
      }

    case 'Metais Representativos':
      {
        return const Color.fromARGB(255, 143, 141, 141);
      }
    case 'Lantanídeos':
      {
        return const Color.fromARGB(255, 223, 83, 58);
      }
    case 'Actinídeos':
      {
        return const Color.fromARGB(255, 200, 108, 216);
      }
    default:
      return Colors.transparent;
  }
}

class _PeriodicTableState extends State<PeriodicTable> {
  late DatabaseService databaseService = DatabaseService();
  QuerySnapshot<Map<String, dynamic>>? periodicTableSnapshot;
  QuerySnapshot<Map<String, dynamic>>? elementOfperiodicTableSnapshot;
  Stream? elementsStream;

  List<ElementModel> _periodicElements1 = [
    ElementModel(
        elementName: "Hidrogênio",
        symbol: "H",
        atomicNumber: "1",
        atomicWeight: "1.987",
        family: "Não Metais"),
    ElementModel(
        elementName: "",
        symbol: "2",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "13",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "14",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "15",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "16",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "17",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "Hélio",
        symbol: "He",
        atomicNumber: "2",
        atomicWeight: "1.987",
        family: "Metais Representativos"),
  ];
  List<ElementModel> _periodicElements2 = [
    ElementModel(
        elementName: "Lítio",
        symbol: "Li",
        atomicNumber: "3",
        atomicWeight: "6,94",
        family: "Metais Alcalinos"),
    ElementModel(
        elementName: "Berílio",
        symbol: "Be",
        atomicNumber: "4",
        atomicWeight: "9,0122",
        family: "Metais Alcalino-terrosos"),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "Boro",
        symbol: "B",
        atomicNumber: "5",
        atomicWeight: "10,81",
        family: "Metaloides"),
    ElementModel(
        elementName: "Carbono",
        symbol: "C",
        atomicNumber: "6",
        atomicWeight: "12,011",
        family: "Não Metais"),
    ElementModel(
        elementName: "Nitrogênio",
        symbol: "N",
        atomicNumber: "7",
        atomicWeight: "14,007",
        family: "Não Metais"),
    ElementModel(
        elementName: "Oxigênio",
        symbol: "O",
        atomicNumber: "15,999",
        atomicWeight: "",
        family: "Não Metais"),
    ElementModel(
        elementName: "Flúor",
        symbol: "F",
        atomicNumber: "9",
        atomicWeight: "18,998",
        family: "Halogênios"),
    ElementModel(
        elementName: "Neônio",
        symbol: "Ne",
        atomicNumber: "10",
        atomicWeight: "20,180",
        family: "Gases Nobres"),
  ];
  List<ElementModel> _periodicElements3 = [
    ElementModel(
        elementName: "Sódio",
        symbol: "Na",
        atomicNumber: "11",
        atomicWeight: "22,990",
        family: "Metais Alcalinos"),
    ElementModel(
        elementName: "Magnésio",
        symbol: "Mg",
        atomicNumber: "12",
        atomicWeight: "24,305",
        family: "Metais Alcalino-terrosos"),
    ElementModel(
        elementName: "",
        symbol: "3",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "4",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "5",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "6",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "7",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "8",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "9",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "10",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "11",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "12",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "Alumínio",
        symbol: "Al",
        atomicNumber: "13",
        atomicWeight: "26,982",
        family: "Metais Representativos"),
    ElementModel(
        elementName: "Silício",
        symbol: "Si",
        atomicNumber: "14",
        atomicWeight: "28,085",
        family: "Metaloides"),
    ElementModel(
        elementName: "Fósforo",
        symbol: "P",
        atomicNumber: "15",
        atomicWeight: "30,974",
        family: "Não Metais"),
    ElementModel(
        elementName: "Enxofre",
        symbol: "S",
        atomicNumber: "16",
        atomicWeight: "32,06",
        family: "Não Metais"),
    ElementModel(
        elementName: "Cloro",
        symbol: "Cl",
        atomicNumber: "17",
        atomicWeight: "35,45",
        family: "Halogênios"),
    ElementModel(
        elementName: "Argônio",
        symbol: "Ar",
        atomicNumber: "18",
        atomicWeight: "39,948",
        family: "Gases Nobres"),
  ];
  List<ElementModel> _periodicElements4 = [
    ElementModel(
        elementName: "Potássio",
        symbol: "K",
        atomicNumber: "19",
        atomicWeight: "39,098",
        family: "Metais Alcalinos"),
    ElementModel(
        elementName: "Cálcio",
        symbol: "Ca",
        atomicNumber: "20",
        atomicWeight: "40,078(4)",
        family: "Metais Alcalino-terrosos"),
    ElementModel(
        elementName: "Escândio",
        symbol: "Sc",
        atomicNumber: "21",
        atomicWeight: "44,956",
        family: "Metais de Transição"),
    ElementModel(
        elementName: "",
        symbol: "10",
        atomicNumber: "",
        atomicWeight: "",
        family: "Metais de Transição"),
    ElementModel(
        elementName: "",
        symbol: "11",
        atomicNumber: "",
        atomicWeight: "",
        family: "Metais de Transição"),
    ElementModel(
        elementName: "",
        symbol: "12",
        atomicNumber: "",
        atomicWeight: "",
        family: "Metais de Transição"),
    ElementModel(
        elementName: "",
        symbol: "Ga",
        atomicNumber: "",
        atomicWeight: "",
        family: "Metais de Transição"),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: "Metais de Transição"),
    ElementModel(
        elementName: "",
        symbol: "15",
        atomicNumber: "",
        atomicWeight: "",
        family: "Metais de Transição"),
    ElementModel(
        elementName: "",
        symbol: "16",
        atomicNumber: "",
        atomicWeight: "",
        family: "Metais de Transição"),
    ElementModel(
        elementName: "",
        symbol: "17",
        atomicNumber: "",
        atomicWeight: "",
        family: "Metais de Transição"),
    ElementModel(
        elementName: "",
        symbol: "17",
        atomicNumber: "",
        atomicWeight: "",
        family: "Metais de Transição"),
    ElementModel(
        elementName: "Gálio",
        symbol: "Ga",
        atomicNumber: "31",
        atomicWeight: "69,723",
        family: "Metais Representativos"),
    ElementModel(
        elementName: "Germânio",
        symbol: "Ge",
        atomicNumber: "32",
        atomicWeight: "72,630(8)",
        family: "Metaloides"),
    ElementModel(
        elementName: "Arsênio",
        symbol: "As",
        atomicNumber: "33",
        atomicWeight: "74,922",
        family: "Metaloides"),
    ElementModel(
        elementName: "Selênio",
        symbol: "Se",
        atomicNumber: "34",
        atomicWeight: "78,971(8)",
        family: "Não Metais"),
    ElementModel(
        elementName: "Bromo",
        symbol: "Br",
        atomicNumber: "35",
        atomicWeight: "79,904",
        family: "Halogênios"),
    ElementModel(
        elementName: "Criptrônio",
        symbol: "Kr",
        atomicNumber: "36",
        atomicWeight: "83,798(2)",
        family: "Gases Nobres"),
  ];
  List<ElementModel> _periodicElements5 = [
    ElementModel(
        elementName: "Hidrogênio",
        symbol: "H",
        atomicNumber: "1",
        atomicWeight: "1.987",
        family: "Não Metais"),
    ElementModel(
        elementName: "",
        symbol: "2",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "9",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "10",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "11",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "12",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "13",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "Hidrogênio",
        symbol: "",
        atomicNumber: "50",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "Hidrogênio",
        symbol: "15",
        atomicNumber: "50",
        atomicWeight: "1.987",
        family: "Metais Representativos"),
    ElementModel(
        elementName: "",
        symbol: "16",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "17",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "17",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "17",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "17",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "17",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "17",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "17",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "Hélio",
        symbol: "He",
        atomicNumber: "2",
        atomicWeight: "1.987",
        family: "Metais Representativos"),
  ];
  List<ElementModel> _periodicElements6 = [
    ElementModel(
        elementName: "Hidrogênio",
        symbol: "H",
        atomicNumber: "1",
        atomicWeight: "1.987",
        family: "Não Metais"),
    ElementModel(
        elementName: "",
        symbol: "2",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "9",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "10",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "11",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "12",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "13",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "Hidrogênio",
        symbol: "",
        atomicNumber: "50",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "Hidrogênio",
        symbol: "15",
        atomicNumber: "50",
        atomicWeight: "1.987",
        family: "Metais Representativos"),
    ElementModel(
        elementName: "",
        symbol: "16",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "17",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "17",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "17",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "17",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "17",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "17",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "17",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "Hélio",
        symbol: "He",
        atomicNumber: "2",
        atomicWeight: "1.987",
        family: "Metais Representativos"),
  ];
  List<ElementModel> _periodicElements7 = [
    ElementModel(
        elementName: "Hidrogênio",
        symbol: "H",
        atomicNumber: "1",
        atomicWeight: "1.987",
        family: "Não Metais"),
    ElementModel(
        elementName: "",
        symbol: "2",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "9",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "10",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "11",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "12",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "13",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "Hidrogênio",
        symbol: "",
        atomicNumber: "50",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "Hidrogênio",
        symbol: "15",
        atomicNumber: "50",
        atomicWeight: "1.987",
        family: "Metais Representativos"),
    ElementModel(
        elementName: "",
        symbol: "16",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "17",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "17",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "17",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "17",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "17",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "17",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "17",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "Hélio",
        symbol: "He",
        atomicNumber: "2",
        atomicWeight: "1.987",
        family: "Metais Representativos"),
  ];
  List<ElementModel> _periodicElements0 = [
    ElementModel(
        elementName: "",
        symbol: "1",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
    ElementModel(
        elementName: "",
        symbol: "18",
        atomicNumber: "",
        atomicWeight: "",
        family: ""),
  ];

  List<ElementModel> getElementModelfromDataSnapshot(
      List<DocumentSnapshot<Map<String, dynamic>>> periodicTableSnapshot) {
    List<ElementModel> elementsModelList = [];
    for (var element in periodicTableSnapshot) {
      debugPrint(" Está no for ${periodicTableSnapshot.toString()}");
      List<String> elements = [
        element.data()?['atomicNumber'],
        element.data()?['atomicWeight'],
        element.data()?['elementName'],
        element.data()?['family'],
        element.data()?['symbol']
      ];

      elementsModelList.add(ElementModel(
          elementName: elements[2],
          symbol: elements[4],
          atomicNumber: elements[0],
          atomicWeight: elements[1],
          family: elements[3]));
    }

    debugPrint(" Está no metodo get ${elementsModelList.toString()}");

    return elementsModelList;
  }

  @override
  void initState() {
    super.initState();
    getPeriodicTableData();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> getElements(List<ElementModel> elements) {
      return List.generate(elements.length, (index) {
        return ElementTile(elementModel: elements[index]);
      });
    }

    Widget getPeriodicTableWidget() {
      return elementOfperiodicTableSnapshot?.docs == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Stack(
                  children: [
                    Table(
                      children: [
                        TableRow(
                            children: getElements(
                                getElementModelfromDataSnapshot(
                                    elementOfperiodicTableSnapshot!.docs))),
                        TableRow(children: getElements(_periodicElements1)),
                        TableRow(children: getElements(_periodicElements2)),
                        TableRow(children: getElements(_periodicElements3)),
                        TableRow(children: getElements(_periodicElements4)),
                        TableRow(children: getElements(_periodicElements5)),
                        TableRow(children: getElements(_periodicElements6)),
                        TableRow(children: getElements(_periodicElements7)),
                      ],
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.08,
                      left: MediaQuery.of(context).size.width * 0.26,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    color: Colors.green,
                                  ),
                                  const Text("Nao Metais",
                                      style: TextStyle(fontSize: 11))
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    color: Colors.purple,
                                  ),
                                  const Text("Metais Alcalinos",
                                      style: TextStyle(fontSize: 11))
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    color: Colors.yellow,
                                  ),
                                  const Text("Metais Alcalino-terrosos",
                                      style: TextStyle(fontSize: 11))
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    color: Colors.blueAccent,
                                  ),
                                  const SizedBox(
                                    width: 1,
                                  ),
                                  const Text("Gases Nobres",
                                      style: TextStyle(fontSize: 11))
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(
                                    width: 1,
                                  ),
                                  const Text("Metaloides",
                                      style: TextStyle(fontSize: 11))
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    color: Colors.purple,
                                  ),
                                  const Text("Halogênios",
                                      style: TextStyle(fontSize: 11))
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    color: Colors.purple,
                                  ),
                                  const Text("Metais de Transicao",
                                      style: TextStyle(fontSize: 11))
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    color: Colors.yellow,
                                  ),
                                  const Text("Metais Representativos",
                                      style: TextStyle(fontSize: 11))
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    color: Colors.blueAccent,
                                  ),
                                  const SizedBox(
                                    width: 1,
                                  ),
                                  const Text("Lantanídeos",
                                      style: TextStyle(fontSize: 11))
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(
                                    width: 1,
                                  ),
                                  const Text("Actinídeos",
                                      style: TextStyle(fontSize: 11))
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Table(
                  children: [
                    TableRow(children: getElements(_periodicElements6)),
                    TableRow(children: getElements(_periodicElements7)),
                  ],
                ),
              ],
            );
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Stack(children: [
            getPeriodicTableWidget(),
            StreamBuilder(
              stream: elementsStream,
              builder: (_, snapshot) {
                return Positioned(
                  left: MediaQuery.of(context).size.width * 0.12,
                  top: MediaQuery.of(context).size.height * 0.15,
                  child: !snapshot.hasData
                      ? const SizedBox()
                      : Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              color: getColor(snapshot.data),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(15))),
                          child: Center(child: Text(snapshot.data.symbol)),
                        ),
                );
              },
            )
          ])),
    ));
  }

  getPeriodicTableData() {
    databaseService.getPeriodicTableData().then((value) {
      debugPrint("VALUE PERIODIC: $value");
      periodicTableSnapshot = value;
      for (var element in periodicTableSnapshot!.docs) {
        String lineId = element.id;
        databaseService.getElementsOfPeriodicTable("line0").then((value) {
          elementOfperiodicTableSnapshot = value;
          elementsStream = _elementController.stream;
          setState(() {});
        });
      }
    });
  }
}

class ElementTile extends StatefulWidget {
  final ElementModel elementModel;
  const ElementTile({super.key, required this.elementModel});

  @override
  State<ElementTile> createState() => _ElementTileState();
}

class _ElementTileState extends State<ElementTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: GestureDetector(
        onTap: () {
          debugPrint(widget.elementModel.symbol);
          setState(() {
            _elementController.add(widget.elementModel);
          });
        },
        child: Container(
          width: 50,
          height: 45,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              color: getColor(widget.elementModel)),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, top: 4.0),
                    child: Text(
                      widget.elementModel.atomicNumber,
                      style: const TextStyle(fontSize: 10),
                    ),
                  )
                ],
              ),
              Center(
                  child: Text(
                widget.elementModel.symbol,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
