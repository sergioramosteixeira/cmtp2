import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/clube.dart';
import 'package:flutter_application_1/screens/adminscreen.dart';
import 'package:flutter_application_1/screens/leaguehome.dart';
import 'package:flutter_application_1/widgets/defaultappbar.dart';

class ClubesInscritos extends StatefulWidget{
  static final String routeName = '/clubesinscritos';
  String? liga;
  ClubesInscritos({this.liga});

  @override
  State<ClubesInscritos> createState() => _ClubesInscritosState();
}

  
class _ClubesInscritosState extends State<ClubesInscritos> {

  int currentMenu = 0;

  Clube _clube = Clube(capacidadeEstadio: 0, fundado: 0, cidadeEstadio: '', logo: '', moradaEstadio: '', nome: '', nomeEstadio: '', pais: '', sigla: '');
  String _liga = "BWIN";
  
  List<DropdownMenuItem<Clube>> _options = [];
  String _grupo = "A";
  bool _isDropdownVisible = false;
  List<String> clubes = [];
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    (widget.liga == null) ? _liga = _liga : _liga=widget.liga!;
    (_liga == "Allianz") ? _isDropdownVisible = true : _isDropdownVisible = false;
    updateClubes(_liga);
  }

  @override
  void updateClubes(String l) {
    _options = [];
    clubes = [];
    _firestore.collection("clubesLiga").where("liga", isEqualTo: l).get().then((snapshot) {
      snapshot.docs.forEach((document) {
        clubes.add(document["clube"]);
      });
    });
    _firestore.collection("clubes").get().then((snapshot) {
      snapshot.docs.forEach((document) {
        if (!clubes.contains(document["sigla"])){
          _options.add(
            DropdownMenuItem(
              child: Text(document["sigla"]),
              value: Clube.fromJson(document),
            ),
          );
        }
      });
      if (_options.isNotEmpty) {
        _clube = _options[0].value!;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget gruposDropdown = DropdownButton<String>(
      isExpanded: true,
      value: _grupo,
      items: const [
        DropdownMenuItem(
          child: Text("Grupo A"),
          value: "A",
        ),
        DropdownMenuItem(
          child: Text("Grupo B"),
          value: "B",
        ),
        DropdownMenuItem(
          child: Text("Grupo C"),
          value: "C",
        ),
        DropdownMenuItem(
          child: Text("Grupo D"),
          value: "D",
        ),
        DropdownMenuItem(
          child: Text("Grupo E"),
          value: "E",
        ),
        DropdownMenuItem(
          child: Text("Grupo F"),
          value: "F",
        ),
        DropdownMenuItem(
          child: Text("Grupo G"),
          value: "G",
        ),
        DropdownMenuItem(
          child: Text("Grupo H"),
          value: "H",
        ),
      ],
      onChanged: (value) {
        setState(() {
          _grupo = value!;
        });
      },
    );
    return Scaffold(
      appBar: DefaultAppBar(logo: "lp"),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15), 
          child: Column(
            children: [
              DropdownButton<String>(
                isExpanded: true,
                value: _liga,
                items: const [
                  DropdownMenuItem(
                    child: Text("Liga BWIN"),
                    value: "BWIN",
                  ),
                  DropdownMenuItem(
                    child: Text("Liga Sabseg"),
                    value: "Sabseg",
                  ),
                  DropdownMenuItem(
                    child: Text("Allianz Cup"),
                    value: "Allianz",
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    updateClubes(value!);
                    (value == "Allianz") ? _isDropdownVisible = true : _isDropdownVisible = false;
                    _liga = value;
                  });
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: DropdownButton<Clube>(
                    isExpanded: true,
                    value: _clube,
                    items: _options,
                    onChanged: (value) {
                      setState(() {
                        _clube = value!;
                      });
                    },
                  ),
                ),
              ),
              (_isDropdownVisible) ? gruposDropdown : Text(""),
             
              ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                    .collection("clubesLiga")
                    .doc(_liga+"_"+_clube.sigla)
                    .set({
                      "clube": _clube.sigla,
                      "liga": _liga,
                      "grupo": (_liga == "Allianz") ? _grupo : "",
                    });

                  (widget.liga == null) ? 
                    Navigator.popUntil(context, ModalRoute.withName(AdminScreen.routeName)) :
                    Navigator.popUntil(context, ModalRoute.withName(LeagueHome.routeName+"/"+widget.liga!));
                  
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, 
                  backgroundColor: Colors.green.withOpacity(0.5), 
                  padding: const EdgeInsets.all(15), 
                  disabledForegroundColor: Colors.lightGreen.withOpacity(0.38), 
                  disabledBackgroundColor: Colors.lightGreen.withOpacity(0.12),
                  shadowColor: Colors.green,
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontFamily: 'Changa',
                  )
                ), 
                child: const Text(
                 'Inscrever Clube',
                ),
              ),
            ]
          )
        ),
      )
    );
  }
}