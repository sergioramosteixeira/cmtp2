import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/clube.dart';
import 'package:flutter_application_1/models/jogador.dart';
import 'package:flutter_application_1/screens/adminscreen.dart';
import 'package:flutter_application_1/screens/clubescreen.dart';
import 'package:flutter_application_1/widgets/defaultappbar.dart';
import 'package:intl/intl.dart';

class JogadoresInscritos extends StatefulWidget{
  static final String routeName = '/jogadoresinscritos';
  String? clube;
  String? passaporte;
  JogadoresInscritos({this.clube, this.passaporte});

  @override
  State<JogadoresInscritos> createState() => _JogadoresInscritosState();
}

  
class _JogadoresInscritosState extends State<JogadoresInscritos> {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  int currentMenu = 0;

  final inicioContrato = TextEditingController();
  final fimContrato = TextEditingController();
  final numeroCamisola = TextEditingController(); 

  Clube _clube = Clube(capacidadeEstadio: 0, fundado: 0, cidadeEstadio: '', logo: '', moradaEstadio: '', nome: '', nomeEstadio: '', pais: '', sigla: '');
  Jogador _jogador = Jogador(altura: 0, dataNascimento: DateTime(2023), escolaridade: '', nacionalidade: '', nomeCamisola: '', nomeCompleto: '', passaporte: '', peso: 0, posicao: '', ultimoControloDoping: DateTime(2023));
  List<DropdownMenuItem<Clube>> _options = [];
  List<DropdownMenuItem<Jogador>> _optionsJogadores = [];
  List<String> clubejogadores = [];
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _options = [];
    if (widget.passaporte == null) {
      _firestore.collection("clubeJogadores").where('fimContrato', isGreaterThanOrEqualTo: dateFormat.format(DateTime.now())).get().then((snapshot) {
        snapshot.docs.forEach((document) {
          clubejogadores.add(document["passaporte"]);
        });
      });
      _firestore.collection("jogadores").get().then((snapshot) {
        snapshot.docs.forEach((document) {
          if (!clubejogadores.contains(document["passaporte"])){
            _optionsJogadores.add(
              DropdownMenuItem(
                child: Text(document["passaporte"]+"-"+document["nomeCamisola"]),
                value: Jogador.fromJson(document),
              ),
            );
          }
        });
        if (_optionsJogadores.isNotEmpty) {
          _jogador = _optionsJogadores[0].value!;
        }
      });
    } else {
      _firestore.collection("jogadores").where("passaporte", isEqualTo: widget.passaporte).get().then((snapshot) {
        snapshot.docs.forEach((document) {
          _optionsJogadores.add(
            DropdownMenuItem(
              child: Text(document["passaporte"]+"-"+document["nomeCamisola"]),
              value: Jogador.fromJson(document),
            ),
          );
        });
        if (_optionsJogadores.isNotEmpty) {
          _jogador = _optionsJogadores[0].value!;
        }
      });
    }
    _firestore.collection("clubes").get().then((snapshot) {
      snapshot.docs.forEach((document) {
        _options.add(
          DropdownMenuItem(
            child: Text(document["sigla"]),
            value: Clube.fromJson(document),
          ),
        );
      });
      if (_options.isNotEmpty) {
        (widget.clube != null) ? _clube = _options.firstWhere((element) => element.value!.sigla == widget.clube).value! : _clube = _options[0].value!;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(logo: "lp"),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15), 
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: DropdownButton<Jogador>(
                    isExpanded: true,
                    value: _jogador,
                    items: _optionsJogadores,
                    onChanged: (value) {
                      setState(() {
                        _jogador = value!;
                      });
                    },
                  ),
                ),
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
              TextField(
                controller: inicioContrato,
                decoration: const InputDecoration(
                  labelText: "Início de Contrato",
                ),
                keyboardType: TextInputType.datetime,
              ),
              TextField(
                controller: fimContrato,
                decoration: const InputDecoration(
                  labelText: "Fim de Contrato",
                ),
                keyboardType: TextInputType.datetime,
              ),
              TextField(
                controller: numeroCamisola,
                decoration: const InputDecoration(
                  labelText: "Número da Camisola",
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
             
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                        .collection("clubeJogadores")
                        .doc("${_jogador.passaporte}_${_clube.sigla}_${inicioContrato.text}")
                        .set({
                          "passaporte": _jogador.passaporte,
                          "clube": _clube.sigla,
                          "inicioContrato": inicioContrato.text,
                          "fimContrato": fimContrato.text,
                          "numeroCamisola": numeroCamisola.text,
                        });

                      (widget.clube == null) ? Navigator.popUntil(context, ModalRoute.withName(AdminScreen.routeName)) : Navigator.pushReplacementNamed(context, ClubeScreen.routeName+"/"+widget.clube!);
                      AdminScreen(); 
                      
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
                     'Inscrever Jogador',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AdminScreen.routeName);
                      AdminScreen(); 
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, 
                      backgroundColor: Colors.red.withOpacity(0.5), 
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
                     'Não Inscrever',
                    ),
                  ),
                ],
              ),
            ]
          )
        ),
      )
    );
  }
}